package com.example.tarjetascorporativas.model.dao;

import com.example.tarjetascorporativas.model.Cuenta;
import com.example.tarjetascorporativas.utils.SQLConnector;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class CuentaDao implements Dao<Cuenta, Long> {

    private static final String BASE_SELECT =
            "SELECT c.*, u.nombre AS nombre_empleado " +
                    "FROM CUENTAS c " +
                    "LEFT JOIN USUARIOS u ON c.id_empleado = u.id_usuario ";

    @Override
    public boolean create(Cuenta entidad) {
        String sql = "INSERT INTO CUENTAS(numero_cuenta, id_empleado, nombre_cuenta, descripcion, saldo, limite_asignado, activo) VALUES(?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNumeroCuenta());
            if (entidad.getIdEmpleado() != null) {
                ps.setLong(2, entidad.getIdEmpleado());
            } else {
                ps.setNull(2, Types.BIGINT);
            }
            ps.setString(3, entidad.getNombreCuenta());
            ps.setString(4, entidad.getDescripcion());
            ps.setBigDecimal(5, entidad.getSaldo() != null ? entidad.getSaldo() : BigDecimal.ZERO);
            ps.setBigDecimal(6, entidad.getLimiteAsignado() != null ? entidad.getLimiteAsignado() : BigDecimal.ZERO);
            ps.setInt(7, entidad.isActivo() ? 1 : 0);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Cuenta> getAll() {
        List<Cuenta> lista = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE c.activo = 1 ORDER BY c.id_cuenta DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Cuenta> getTodasLasCuentas() {
        List<Cuenta> lista = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY c.id_cuenta DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Cuenta getById(Long id) {
        String sql = BASE_SELECT + "WHERE c.id_cuenta = ? AND c.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCuenta(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(Cuenta entidad) {
        String sql = "UPDATE CUENTAS SET numero_cuenta = ?, id_empleado = ?, nombre_cuenta = ?, descripcion = ?, saldo = ?, limite_asignado = ?, activo = ? WHERE id_cuenta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNumeroCuenta());
            if (entidad.getIdEmpleado() != null) {
                ps.setLong(2, entidad.getIdEmpleado());
            } else {
                ps.setNull(2, Types.BIGINT);
            }
            ps.setString(3, entidad.getNombreCuenta());
            ps.setString(4, entidad.getDescripcion());
            ps.setBigDecimal(5, entidad.getSaldo() != null ? entidad.getSaldo() : BigDecimal.ZERO);
            ps.setBigDecimal(6, entidad.getLimiteAsignado() != null ? entidad.getLimiteAsignado() : BigDecimal.ZERO);
            ps.setInt(7, entidad.isActivo() ? 1 : 0);
            ps.setLong(8, entidad.getIdCuenta());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(Long id) {
        // Regla Financiera Crítica: Retorno automático de saldo a la Cuenta Conservadora antes de borrado lógico
        return deshabilitarCuenta(id);
    }

    public List<Cuenta> getByEmpleadoId(Long idEmpleado) {
        List<Cuenta> lista = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE c.id_empleado = ? AND c.activo = 1 ORDER BY c.id_cuenta DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idEmpleado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToCuenta(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Cuenta getByNumeroCuenta(String numeroCuenta) {
        String sql = BASE_SELECT + "WHERE c.numero_cuenta = ? AND c.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, numeroCuenta);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCuenta(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Cuenta getCuentaConservadora() {
        String sql = BASE_SELECT + "WHERE c.id_empleado IS NULL AND c.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return mapResultSetToCuenta(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean actualizarSaldo(Long idCuenta, BigDecimal nuevoSaldo) {
        String sql = "UPDATE CUENTAS SET saldo = ? WHERE id_cuenta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBigDecimal(1, nuevoSaldo);
            ps.setLong(2, idCuenta);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean retornarSaldoAConservadora(Long idCuenta) {
        Cuenta cuenta = getById(idCuenta);
        if (cuenta == null || cuenta.getSaldo() == null || cuenta.getSaldo().compareTo(BigDecimal.ZERO) <= 0) {
            return true; // No hay saldo que devolver
        }

        Cuenta conservadora = getCuentaConservadora();
        if (conservadora == null || conservadora.getIdCuenta().equals(idCuenta)) {
            return false; // La propia cuenta conservadora no se devuelve a sí misma
        }

        BigDecimal montoARetornar = cuenta.getSaldo();

        Connection con = null;
        try {
            con = SQLConnector.getConnection();
            con.setAutoCommit(false);

            // 1. Restar saldo de la cuenta a 0
            String sqlZero = "UPDATE CUENTAS SET saldo = 0 WHERE id_cuenta = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlZero)) {
                ps.setLong(1, idCuenta);
                ps.executeUpdate();
            }

            // 2. Sumar saldo a la Cuenta Conservadora
            String sqlSum = "UPDATE CUENTAS SET saldo = saldo + ? WHERE id_cuenta = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlSum)) {
                ps.setBigDecimal(1, montoARetornar);
                ps.setLong(2, conservadora.getIdCuenta());
                ps.executeUpdate();
            }

            // 3. Registrar el movimiento contable de Reintegro
            String sqlMov = "INSERT INTO MOVIMIENTOS(id_cuenta_origen, id_cuenta_destino, monto, tipo_movimiento, estado, fecha_movimiento, descripcion) " +
                    "VALUES(?, ?, ?, 'REINTEGRO_CONSERVADORA', 'COMPLETADO', CURRENT_TIMESTAMP, ?)";
            try (PreparedStatement ps = con.prepareStatement(sqlMov)) {
                ps.setLong(1, idCuenta);
                ps.setLong(2, conservadora.getIdCuenta());
                ps.setBigDecimal(3, montoARetornar);
                ps.setString(4, "Reintegro automático por desactivación/borrado de cuenta");
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

    public boolean deshabilitarCuenta(Long idCuenta) {
        // 1. Devolver saldo automáticamente a la Conservadora
        retornarSaldoAConservadora(idCuenta);

        // 2. Desactivar la cuenta (Borrado lógico)
        String sql = "UPDATE CUENTAS SET activo = 0 WHERE id_cuenta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idCuenta);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Cuenta mapResultSetToCuenta(ResultSet rs) throws SQLException {
        Cuenta c = new Cuenta();
        c.setIdCuenta(rs.getLong("id_cuenta"));
        c.setNumeroCuenta(rs.getString("numero_cuenta"));

        long idEmp = rs.getLong("id_empleado");
        if (!rs.wasNull()) {
            c.setIdEmpleado(idEmp);
        }

        c.setNombreCuenta(rs.getString("nombre_cuenta"));
        c.setDescripcion(rs.getString("descripcion"));
        c.setSaldo(rs.getBigDecimal("saldo"));
        c.setLimiteAsignado(rs.getBigDecimal("limite_asignado"));
        c.setActivo(rs.getInt("activo") == 1);

        try {
            c.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        } catch (SQLException ignored) {}

        try {
            c.setNombreEmpleado(rs.getString("nombre_empleado"));
        } catch (SQLException ignored) {}

        return c;
    }
}
