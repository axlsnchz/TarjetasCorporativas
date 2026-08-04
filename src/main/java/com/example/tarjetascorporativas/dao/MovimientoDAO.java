package com.example.tarjetascorporativas.dao;

import org.example.tarjetas_corporativas.model.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

/**
 * DAO para la tabla {@code MOVIMIENTOS}.
 */
public class MovimientoDAO {

    private static final Calendar UTC = Calendar.getInstance(TimeZone.getTimeZone("UTC"));

    public long insertAsignacion(Connection con, long cuentaDestinoId,
                                 BigDecimal monto, long adminId) throws SQLException {
        String sql =
            "INSERT INTO MOVIMIENTOS " +
            "(tipo, cuenta_destino_id, monto, concepto, realizado_por) " +
            "VALUES ('asignacion_fondos', ?, ?, 'Asignación de fondos corporativos', ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, new String[]{"ID"})) {
            ps.setLong(1, cuentaDestinoId);
            ps.setBigDecimal(2, monto);
            ps.setLong(3, adminId);
            ps.executeUpdate();
            try (ResultSet rk = ps.getGeneratedKeys()) {
                rk.next();
                return rk.getLong(1);
            }
        }
    }

    public void insertTransferencia(Connection con, long origenId, long destinoId,
                                    BigDecimal monto, String concepto, long realizadoPor) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(
                "INSERT INTO MOVIMIENTOS " +
                "(tipo, cuenta_origen_id, cuenta_destino_id, monto, concepto, realizado_por) " +
                "VALUES ('transferencia', ?, ?, ?, ?, ?)")) {
            ps.setLong(1, origenId);
            ps.setLong(2, destinoId);
            ps.setBigDecimal(3, monto);
            ps.setString(4, concepto);
            ps.setLong(5, realizadoPor);
            ps.executeUpdate();
        }
    }

    public List<MovimientoDashboard> findDashboardByUsuarioId(Connection con,
                                                               long usuarioId, int limit) throws SQLException {
        String sql =
            "SELECT m.tipo, m.monto, m.concepto, m.fecha, " +
            "       co.numero_cuenta AS origen_num, cd.numero_cuenta AS destino_num, " +
            "       cat_o.nombre AS cat_origen, cat_d.nombre AS cat_destino " +
            "FROM MOVIMIENTOS m " +
            "LEFT JOIN CUENTAS co ON m.cuenta_origen_id  = co.id " +
            "LEFT JOIN CUENTAS cd ON m.cuenta_destino_id = cd.id " +
            "LEFT JOIN CATEGORIAS_CUENTA cat_o ON co.categoria_id = cat_o.id " +
            "LEFT JOIN CATEGORIAS_CUENTA cat_d ON cd.categoria_id = cat_d.id " +
            "WHERE (co.usuario_id = ? OR cd.usuario_id = ?) AND m.estado = 'PROCESADO' " +
            "ORDER BY m.fecha DESC FETCH FIRST ? ROWS ONLY";

        List<MovimientoDashboard> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, usuarioId);
            ps.setLong(2, usuarioId);
            ps.setInt(3, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new MovimientoDashboard(
                        rs.getString("tipo"),
                        rs.getBigDecimal("monto"),
                        rs.getString("concepto"),
                        rs.getTimestamp("fecha", UTC),
                        rs.getString("origen_num"),
                        rs.getString("destino_num"),
                        rs.getString("cat_origen"),
                        rs.getString("cat_destino")
                    ));
                }
            }
        }
        return list;
    }

    public List<MovimientoDetalle> findDetalleByUsuarioId(Connection con,
                                                           long usuarioId, int limit) throws SQLException {
        String sql =
            "SELECT m.tipo, NVL(m.monto,0) AS monto, m.concepto, m.referencia, m.fecha, " +
            "       co.numero_cuenta AS cuenta_origen_num, cd.numero_cuenta AS cuenta_destino_num, " +
            "       CASE WHEN co.usuario_id = ? THEN 'salida' ELSE 'entrada' END AS direccion " +
            "FROM MOVIMIENTOS m " +
            "LEFT JOIN CUENTAS co ON m.cuenta_origen_id  = co.id " +
            "LEFT JOIN CUENTAS cd ON m.cuenta_destino_id = cd.id " +
            "WHERE (co.usuario_id = ? OR cd.usuario_id = ?) AND m.estado = 'PROCESADO' " +
            "ORDER BY m.fecha DESC FETCH FIRST ? ROWS ONLY";

        List<MovimientoDetalle> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, usuarioId);
            ps.setLong(2, usuarioId);
            ps.setLong(3, usuarioId);
            ps.setInt(4, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new MovimientoDetalle(
                        rs.getString("tipo"),
                        rs.getBigDecimal("monto"),
                        rs.getString("concepto"),
                        rs.getString("referencia"),
                        rs.getTimestamp("fecha", UTC),
                        rs.getString("cuenta_origen_num"),
                        rs.getString("cuenta_destino_num"),
                        rs.getString("direccion")
                    ));
                }
            }
        }
        return list;
    }

    public List<TransferenciaHistorial> findHistorialPaged(Connection con, long usuarioId,
                                                            String tipo, int offset, int limit) throws SQLException {
        boolean enviada  = "enviada".equals(tipo);
        boolean recibida = "recibida".equals(tipo);
        StringBuilder sb = new StringBuilder(
            "SELECT m.monto, m.concepto, m.referencia, m.fecha, m.estado, " +
            "co.numero_cuenta AS origen_num, cd.numero_cuenta AS destino_num, " +
            "NVL(uo.nombre,'—') AS origen_titular, NVL(ud.nombre,'—') AS destino_titular, " +
            "co.usuario_id AS origen_uid " +
            "FROM MOVIMIENTOS m " +
            "LEFT JOIN CUENTAS co ON m.cuenta_origen_id  = co.id " +
            "LEFT JOIN CUENTAS cd ON m.cuenta_destino_id = cd.id " +
            "LEFT JOIN USUARIOS uo ON co.usuario_id = uo.id " +
            "LEFT JOIN USUARIOS ud ON cd.usuario_id = ud.id " +
            "WHERE m.tipo = 'transferencia' AND (co.usuario_id = ? OR cd.usuario_id = ?) ");
        if (enviada)  sb.append("AND co.usuario_id = ? ");
        if (recibida) sb.append("AND cd.usuario_id = ? ");
        sb.append("ORDER BY m.fecha DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        List<TransferenciaHistorial> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sb.toString())) {
            int idx = 1;
            ps.setLong(idx++, usuarioId); ps.setLong(idx++, usuarioId);
            if (enviada || recibida) ps.setLong(idx++, usuarioId);
            ps.setInt(idx++, offset); ps.setInt(idx, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    long origenUid = rs.getLong("origen_uid");
                    list.add(new TransferenciaHistorial(
                        rs.getBigDecimal("monto"), rs.getString("concepto"),
                        rs.getString("referencia"), rs.getTimestamp("fecha", UTC),
                        rs.getString("estado"), rs.getString("origen_num"),
                        rs.getString("destino_num"), rs.getString("origen_titular"),
                        rs.getString("destino_titular"),
                        origenUid == usuarioId ? "enviada" : "recibida"));
                }
            }
        }
        return list;
    }

    public long countHistorial(Connection con, long usuarioId, String tipo) throws SQLException {
        boolean enviada  = "enviada".equals(tipo);
        boolean recibida = "recibida".equals(tipo);
        StringBuilder sb = new StringBuilder(
            "SELECT COUNT(*) FROM MOVIMIENTOS m " +
            "LEFT JOIN CUENTAS co ON m.cuenta_origen_id  = co.id " +
            "LEFT JOIN CUENTAS cd ON m.cuenta_destino_id = cd.id " +
            "WHERE m.tipo = 'transferencia' AND (co.usuario_id = ? OR cd.usuario_id = ?) ");
        if (enviada)  sb.append("AND co.usuario_id = ? ");
        if (recibida) sb.append("AND cd.usuario_id = ? ");
        try (PreparedStatement ps = con.prepareStatement(sb.toString())) {
            int idx = 1;
            ps.setLong(idx++, usuarioId); ps.setLong(idx++, usuarioId);
            if (enviada || recibida) ps.setLong(idx++, usuarioId);
            try (ResultSet rs = ps.executeQuery()) { rs.next(); return rs.getLong(1); }
        }
    }

    public TransferenciaStats getMonthlyStats(Connection con, long usuarioId) throws SQLException {
        String sql =
            "SELECT COUNT(*) AS total_mes, " +
            "  NVL(SUM(CASE WHEN co.usuario_id = ? THEN m.monto ELSE 0 END),0) AS enviado, " +
            "  NVL(SUM(CASE WHEN cd.usuario_id = ? THEN m.monto ELSE 0 END),0) AS recibido " +
            "FROM MOVIMIENTOS m " +
            "LEFT JOIN CUENTAS co ON m.cuenta_origen_id  = co.id " +
            "LEFT JOIN CUENTAS cd ON m.cuenta_destino_id = cd.id " +
            "WHERE m.tipo = 'transferencia' " +
            "  AND (co.usuario_id = ? OR cd.usuario_id = ?) " +
            "  AND TRUNC(m.fecha, 'MM') = TRUNC(SYSDATE, 'MM')";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, usuarioId);
            ps.setLong(2, usuarioId);
            ps.setLong(3, usuarioId);
            ps.setLong(4, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                BigDecimal env = rs.getBigDecimal("enviado");
                BigDecimal rec = rs.getBigDecimal("recibido");
                return new TransferenciaStats(
                    rs.getLong("total_mes"),
                    env  != null ? env  : BigDecimal.ZERO,
                    rec  != null ? rec  : BigDecimal.ZERO
                );
            }
        }
    }

    public List<TransferenciaHistorial> findHistorialByUsuarioId(Connection con,
                                                                 long usuarioId, int limit) throws SQLException {
        String sql =
            "SELECT m.monto, m.concepto, m.referencia, m.fecha, m.estado, " +
            "       co.numero_cuenta AS origen_num, cd.numero_cuenta AS destino_num, " +
            "       NVL(uo.nombre,'—') AS origen_titular, NVL(ud.nombre,'—') AS destino_titular, " +
            "       co.usuario_id AS origen_uid " +
            "FROM MOVIMIENTOS m " +
            "LEFT JOIN CUENTAS  co ON m.cuenta_origen_id  = co.id " +
            "LEFT JOIN CUENTAS  cd ON m.cuenta_destino_id = cd.id " +
            "LEFT JOIN USUARIOS uo ON co.usuario_id = uo.id " +
            "LEFT JOIN USUARIOS ud ON cd.usuario_id = ud.id " +
            "WHERE m.tipo = 'transferencia' AND (co.usuario_id = ? OR cd.usuario_id = ?) " +
            "ORDER BY m.fecha DESC FETCH FIRST ? ROWS ONLY";

        List<TransferenciaHistorial> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, usuarioId);
            ps.setLong(2, usuarioId);
            ps.setInt(3, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    long origenUid = rs.getLong("origen_uid");
                    list.add(new TransferenciaHistorial(
                        rs.getBigDecimal("monto"),
                        rs.getString("concepto"),
                        rs.getString("referencia"),
                        rs.getTimestamp("fecha", UTC),
                        rs.getString("estado"),
                        rs.getString("origen_num"),
                        rs.getString("destino_num"),
                        rs.getString("origen_titular"),
                        rs.getString("destino_titular"),
                        origenUid == usuarioId ? "enviada" : "recibida"
                    ));
                }
            }
        }
        return list;
    }
}
