package com.example.tarjetascorporativas.model.dao;

import com.example.tarjetascorporativas.model.Departamento;
import com.example.tarjetascorporativas.utils.SQLConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DepartamentoDao implements Dao<Departamento, Long> {

    @Override
    public boolean create(Departamento entidad) {
        String sql = "INSERT INTO DEPARTAMENTOS(nombre) VALUES(?)";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNombre());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Departamento> getAll() {
        List<Departamento> lista = new ArrayList<>();
        String sql = "SELECT * FROM DEPARTAMENTOS ORDER BY nombre ASC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToDepartamento(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Departamento getById(Long id) {
        String sql = "SELECT * FROM DEPARTAMENTOS WHERE id_departamento = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDepartamento(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(Departamento entidad) {
        String sql = "UPDATE DEPARTAMENTOS SET nombre = ? WHERE id_departamento = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNombre());
            ps.setLong(2, entidad.getIdDepartamento());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM DEPARTAMENTOS WHERE id_departamento = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Departamento getByNombre(String nombre) {
        String sql = "SELECT * FROM DEPARTAMENTOS WHERE nombre = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDepartamento(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Departamento mapResultSetToDepartamento(ResultSet rs) throws SQLException {
        Departamento d = new Departamento();
        d.setIdDepartamento(rs.getLong("id_departamento"));
        d.setNombre(rs.getString("nombre"));
        try {
            d.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        } catch (SQLException ignored) {}
        return d;
    }
}
