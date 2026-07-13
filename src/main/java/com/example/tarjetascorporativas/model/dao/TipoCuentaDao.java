package com.example.tarjetascorporativas.model.dao;

import com.example.tarjetascorporativas.model.TipoCuenta;
import com.example.tarjetascorporativas.utils.SQLConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TipoCuentaDao implements Dao<TipoCuenta, Long> {

    @Override
    public boolean create(TipoCuenta entidad) {
        String sql = "INSERT INTO TIPOS_CUENTA(nombre, descripcion, es_conservadora, activo) VALUES(?, ?, ?, ?)";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNombre());
            ps.setString(2, entidad.getDescripcion());
            ps.setInt(3, entidad.isEsConservadora() ? 1 : 0);
            ps.setInt(4, entidad.isActivo() ? 1 : 0);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<TipoCuenta> getAll() {
        List<TipoCuenta> lista = new ArrayList<>();
        String sql = "SELECT * FROM TIPOS_CUENTA WHERE activo = 1 ORDER BY nombre ASC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToTipoCuenta(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public TipoCuenta getById(Long id) {
        String sql = "SELECT * FROM TIPOS_CUENTA WHERE id_tipo_cuenta = ? AND activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTipoCuenta(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(TipoCuenta entidad) {
        String sql = "UPDATE TIPOS_CUENTA SET nombre = ?, descripcion = ?, es_conservadora = ?, activo = ? WHERE id_tipo_cuenta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNombre());
            ps.setString(2, entidad.getDescripcion());
            ps.setInt(3, entidad.isEsConservadora() ? 1 : 0);
            ps.setInt(4, entidad.isActivo() ? 1 : 0);
            ps.setLong(5, entidad.getIdTipoCuenta());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "UPDATE TIPOS_CUENTA SET activo = 0 WHERE id_tipo_cuenta = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public TipoCuenta getByNombre(String nombre) {
        String sql = "SELECT * FROM TIPOS_CUENTA WHERE nombre = ? AND activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTipoCuenta(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public TipoCuenta getCuentaConservadoraType() {
        String sql = "SELECT * FROM TIPOS_CUENTA WHERE es_conservadora = 1 AND activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return mapResultSetToTipoCuenta(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private TipoCuenta mapResultSetToTipoCuenta(ResultSet rs) throws SQLException {
        TipoCuenta tc = new TipoCuenta();
        tc.setIdTipoCuenta(rs.getLong("id_tipo_cuenta"));
        tc.setNombre(rs.getString("nombre"));
        tc.setDescripcion(rs.getString("descripcion"));
        tc.setEsConservadora(rs.getInt("es_conservadora") == 1);
        tc.setActivo(rs.getInt("activo") == 1);
        try {
            tc.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        } catch (SQLException ignored) {}
        return tc;
    }
}
