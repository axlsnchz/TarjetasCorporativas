package com.example.tarjetascorporativas.model.dao;

import com.example.tarjetascorporativas.model.Tarjeta;
import com.example.tarjetascorporativas.utils.SQLConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TarjetaDao implements Dao<Tarjeta, Long> {

    @Override
    public boolean create(Tarjeta entidad) {
        String sql = "INSERT INTO TARJETAS(numero_tarjeta, alias, fecha_expiracion, cvv, tipo_tarjeta, id_cuenta, activo) VALUES(?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNumeroTarjeta());
            ps.setString(2, entidad.getAlias());
            ps.setString(3, entidad.getFechaExpiracion());
            ps.setString(4, entidad.getCvv());
            ps.setString(5, entidad.getTipoTarjeta());
            ps.setLong(6, entidad.getIdCuenta());
            ps.setInt(7, entidad.isActivo() ? 1 : 0);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Tarjeta> getAll() {
        List<Tarjeta> lista = new ArrayList<>();
        String sql = "SELECT t.*, c.numero_cuenta FROM TARJETAS t JOIN CUENTAS c ON t.id_cuenta = c.id_cuenta WHERE t.activo = 1 ORDER BY t.id_tarjeta DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToTarjeta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Tarjeta getById(Long id) {
        String sql = "SELECT t.*, c.numero_cuenta FROM TARJETAS t JOIN CUENTAS c ON t.id_cuenta = c.id_cuenta WHERE t.id_tarjeta = ? AND t.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTarjeta(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(Tarjeta entidad) {
        String sql = "UPDATE TARJETAS SET numero_tarjeta = ?, alias = ?, fecha_expiracion = ?, cvv = ?, tipo_tarjeta = ?, id_cuenta = ?, activo = ? WHERE id_tarjeta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNumeroTarjeta());
            ps.setString(2, entidad.getAlias());
            ps.setString(3, entidad.getFechaExpiracion());
            ps.setString(4, entidad.getCvv());
            ps.setString(5, entidad.getTipoTarjeta());
            ps.setLong(6, entidad.getIdCuenta());
            ps.setInt(7, entidad.isActivo() ? 1 : 0);
            ps.setLong(8, entidad.getIdTarjeta());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(Long id) {
        // Borrado lógico de la tarjeta
        String sql = "UPDATE TARJETAS SET activo = 0 WHERE id_tarjeta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Tarjeta> getByCuentaId(Long idCuenta) {
        List<Tarjeta> lista = new ArrayList<>();
        String sql = "SELECT t.*, c.numero_cuenta FROM TARJETAS t JOIN CUENTAS c ON t.id_cuenta = c.id_cuenta WHERE t.id_cuenta = ? AND t.activo = 1 ORDER BY t.id_tarjeta DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idCuenta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToTarjeta(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Tarjeta getByNumeroTarjeta(String numeroTarjeta) {
        String sql = "SELECT t.*, c.numero_cuenta FROM TARJETAS t JOIN CUENTAS c ON t.id_cuenta = c.id_cuenta WHERE t.numero_tarjeta = ? AND t.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, numeroTarjeta);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTarjeta(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deshabilitarTarjeta(Long idTarjeta) {
        return delete(idTarjeta);
    }

    private Tarjeta mapResultSetToTarjeta(ResultSet rs) throws SQLException {
        Tarjeta t = new Tarjeta();
        t.setIdTarjeta(rs.getLong("id_tarjeta"));
        t.setNumeroTarjeta(rs.getString("numero_tarjeta"));
        t.setAlias(rs.getString("alias"));
        t.setFechaExpiracion(rs.getString("fecha_expiracion"));
        t.setCvv(rs.getString("cvv"));
        t.setTipoTarjeta(rs.getString("tipo_tarjeta"));
        t.setIdCuenta(rs.getLong("id_cuenta"));
        t.setActivo(rs.getInt("activo") == 1);

        try {
            t.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        } catch (SQLException ignored) {}

        try {
            t.setNumeroCuenta(rs.getString("numero_cuenta"));
        } catch (SQLException ignored) {}

        return t;
    }
}
