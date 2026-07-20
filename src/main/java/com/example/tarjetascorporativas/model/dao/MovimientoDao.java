package com.example.tarjetascorporativas.model.dao;

import com.example.tarjetascorporativas.model.Cuenta;
import com.example.tarjetascorporativas.model.Movimiento;
import com.example.tarjetascorporativas.utils.SQLConnector;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class MovimientoDao implements Dao<Movimiento, Long> {

    @Override
    public boolean create(Movimiento entidad) {
        String sql = "INSERT INTO MOVIMIENTOS(id_cuenta_origen, id_cuenta_destino, monto, tipo_movimiento, estado, fecha_movimiento, descripcion) " +
                "VALUES(?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (entidad.getIdCuentaOrigen() != null) {
                ps.setLong(1, entidad.getIdCuentaOrigen());
            } else {
                ps.setNull(1, Types.BIGINT);
            }
            ps.setLong(2, entidad.getIdCuentaDestino());
            ps.setBigDecimal(3, entidad.getMonto());
            ps.setString(4, entidad.getTipoMovimiento());
            ps.setString(5, entidad.getEstado() != null ? entidad.getEstado() : "COMPLETADO");
            ps.setString(6, entidad.getDescripcion());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Movimiento> getAll() {
        List<Movimiento> lista = new ArrayList<>();
        String sql = "SELECT m.*, co.numero_cuenta AS numero_cuenta_origen, cd.numero_cuenta AS numero_cuenta_destino " +
                "FROM MOVIMIENTOS m " +
                "LEFT JOIN CUENTAS co ON m.id_cuenta_origen = co.id_cuenta " +
                "JOIN CUENTAS cd ON m.id_cuenta_destino = cd.id_cuenta " +
                "ORDER BY m.fecha_movimiento DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToMovimiento(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Movimiento getById(Long id) {
        String sql = "SELECT m.*, co.numero_cuenta AS numero_cuenta_origen, cd.numero_cuenta AS numero_cuenta_destino " +
                "FROM MOVIMIENTOS m " +
                "LEFT JOIN CUENTAS co ON m.id_cuenta_origen = co.id_cuenta " +
                "JOIN CUENTAS cd ON m.id_cuenta_destino = cd.id_cuenta " +
                "WHERE m.id_movimiento = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMovimiento(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(Movimiento entidad) {
        // Los movimientos financieros son inmutables por seguridad auditada
        return false;
    }

    @Override
    public boolean delete(Long id) {
        // Los registros contables no se borran por auditoría
        return false;
    }

    public List<Movimiento> getByCuentaId(Long idCuenta) {
        List<Movimiento> lista = new ArrayList<>();
        String sql = "SELECT m.*, co.numero_cuenta AS numero_cuenta_origen, cd.numero_cuenta AS numero_cuenta_destino " +
                "FROM MOVIMIENTOS m " +
                "LEFT JOIN CUENTAS co ON m.id_cuenta_origen = co.id_cuenta " +
                "JOIN CUENTAS cd ON m.id_cuenta_destino = cd.id_cuenta " +
                "WHERE m.id_cuenta_origen = ? OR m.id_cuenta_destino = ? " +
                "ORDER BY m.fecha_movimiento DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idCuenta);
            ps.setLong(2, idCuenta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToMovimiento(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Movimiento> getByEmpleadoId(Long idEmpleado) {
        List<Movimiento> lista = new ArrayList<>();
        String sql = "SELECT m.*, co.numero_cuenta AS numero_cuenta_origen, cd.numero_cuenta AS numero_cuenta_destino " +
                "FROM MOVIMIENTOS m " +
                "LEFT JOIN CUENTAS co ON m.id_cuenta_origen = co.id_cuenta " +
                "JOIN CUENTAS cd ON m.id_cuenta_destino = cd.id_cuenta " +
                "WHERE co.id_empleado = ? OR cd.id_empleado = ? " +
                "ORDER BY m.fecha_movimiento DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idEmpleado);
            ps.setLong(2, idEmpleado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToMovimiento(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Movimiento> getByEstado(String estado) {
        List<Movimiento> lista = new ArrayList<>();
        String sql = "SELECT m.*, co.numero_cuenta AS numero_cuenta_origen, cd.numero_cuenta AS numero_cuenta_destino " +
                "FROM MOVIMIENTOS m " +
                "LEFT JOIN CUENTAS co ON m.id_cuenta_origen = co.id_cuenta " +
                "JOIN CUENTAS cd ON m.id_cuenta_destino = cd.id_cuenta " +
                "WHERE m.estado = ? " +
                "ORDER BY m.fecha_movimiento DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, estado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToMovimiento(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean registrarTransferencia(Long idCuentaOrigen, Long idCuentaDestino, BigDecimal monto, String descripcion) {
        if (monto == null || monto.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }

        CuentaDao cuentaDao = new CuentaDao();
        Cuenta origen = cuentaDao.getById(idCuentaOrigen);
        Cuenta destino = cuentaDao.getById(idCuentaDestino);

        if (origen == null || destino == null) {
            System.err.println("Error en transferencia: Cuentas inválidas o inactivas.");
            return false;
        }

        // REGLA CRÍTICA: Verificación de Saldo Suficiente
        if (origen.getSaldo().compareTo(monto) < 0) {
            System.err.println("Error en transferencia: Saldo insuficiente en la cuenta de origen.");
            return false;
        }

        Connection con = null;
        try {
            con = SQLConnector.getConnection();
            con.setAutoCommit(false);

            // 1. Restar de la cuenta origen
            String sqlRestar = "UPDATE CUENTAS SET saldo = saldo - ? WHERE id_cuenta = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlRestar)) {
                ps.setBigDecimal(1, monto);
                ps.setLong(2, idCuentaOrigen);
                ps.executeUpdate();
            }

            // 2. Sumar a la cuenta destino
            String sqlSumar = "UPDATE CUENTAS SET saldo = saldo + ? WHERE id_cuenta = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlSumar)) {
                ps.setBigDecimal(1, monto);
                ps.setLong(2, idCuentaDestino);
                ps.executeUpdate();
            }

            // 3. Insertar movimiento
            String sqlMov = "INSERT INTO MOVIMIENTOS(id_cuenta_origen, id_cuenta_destino, monto, tipo_movimiento, estado, fecha_movimiento, descripcion) " +
                    "VALUES(?, ?, ?, 'TRANSFERENCIA', 'COMPLETADO', CURRENT_TIMESTAMP, ?)";
            try (PreparedStatement ps = con.prepareStatement(sqlMov)) {
                ps.setLong(1, idCuentaOrigen);
                ps.setLong(2, idCuentaDestino);
                ps.setBigDecimal(3, monto);
                ps.setString(4, descripcion != null ? descripcion : "Transferencia entre cuentas del mismo tipo");
                ps.executeUpdate();
            }

            con.commit();
            return true;
        } catch (SQLException e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try { con.setAutoCommit(true); con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
    }

    public boolean registrarDepositoConservadora(BigDecimal monto, String descripcion) {
        if (monto == null || monto.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }

        CuentaDao cuentaDao = new CuentaDao();
        Cuenta conservadora = cuentaDao.getCuentaConservadora();

        if (conservadora == null) {
            System.err.println("Error en depósito: No se encontró la Cuenta Conservadora.");
            return false;
        }

        Connection con = null;
        try {
            con = SQLConnector.getConnection();
            con.setAutoCommit(false);

            // 1. Sumar saldo a la Cuenta Conservadora
            String sqlSumar = "UPDATE CUENTAS SET saldo = saldo + ? WHERE id_cuenta = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlSumar)) {
                ps.setBigDecimal(1, monto);
                ps.setLong(2, conservadora.getIdCuenta());
                ps.executeUpdate();
            }

            // 2. Registrar movimiento de Depósito Inicial
            String sqlMov = "INSERT INTO MOVIMIENTOS(id_cuenta_origen, id_cuenta_destino, monto, tipo_movimiento, estado, fecha_movimiento, descripcion) " +
                    "VALUES(NULL, ?, ?, 'DEPOSITO_INICIAL', 'COMPLETADO', CURRENT_TIMESTAMP, ?)";
            try (PreparedStatement ps = con.prepareStatement(sqlMov)) {
                ps.setLong(1, conservadora.getIdCuenta());
                ps.setBigDecimal(2, monto);
                ps.setString(3, (descripcion != null && !descripcion.trim().isEmpty()) ? descripcion : "Ingreso de fondos a Cuenta Concentradora Corporativa");
                ps.executeUpdate();
            }

            con.commit();
            return true;
        } catch (SQLException e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try { con.setAutoCommit(true); con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
    }

    private Movimiento mapResultSetToMovimiento(ResultSet rs) throws SQLException {
        Movimiento m = new Movimiento();
        m.setIdMovimiento(rs.getLong("id_movimiento"));

        long idOrig = rs.getLong("id_cuenta_origen");
        if (!rs.wasNull()) {
            m.setIdCuentaOrigen(idOrig);
        }

        m.setIdCuentaDestino(rs.getLong("id_cuenta_destino"));
        m.setMonto(rs.getBigDecimal("monto"));
        m.setTipoMovimiento(rs.getString("tipo_movimiento"));
        m.setEstado(rs.getString("estado"));
        m.setFechaMovimiento(rs.getTimestamp("fecha_movimiento"));
        m.setDescripcion(rs.getString("descripcion"));

        try {
            m.setNumeroCuentaOrigen(rs.getString("numero_cuenta_origen"));
        } catch (SQLException ignored) {}

        try {
            m.setNumeroCuentaDestino(rs.getString("numero_cuenta_destino"));
        } catch (SQLException ignored) {}

        return m;
    }
}
