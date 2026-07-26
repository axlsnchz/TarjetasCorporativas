package com.example.tarjetascorporativas.model.dao;

import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.utils.SQLConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao implements Dao<Usuario, Long> {

    private static final String BASE_SELECT = 
            "SELECT u.*, d.nombre AS nombre_departamento, c.nombre AS nombre_cargo " +
            "FROM USUARIOS u " +
            "LEFT JOIN DEPARTAMENTOS d ON u.id_departamento = d.id_departamento " +
            "LEFT JOIN CARGOS c ON u.id_cargo = c.id_cargo ";

    @Override
    public boolean create(Usuario entidad) {
        String sql = "INSERT INTO USUARIOS(nombre, correo, password, rol, id_departamento, id_cargo, primer_inicio, activo, codigo_recuperacion, url_foto) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNombre());
            ps.setString(2, entidad.getCorreo());
            ps.setString(3, entidad.getPassword());
            ps.setString(4, entidad.getRol() != null ? entidad.getRol() : "EMPLEADO");

            if (entidad.getIdDepartamento() != null) {
                ps.setLong(5, entidad.getIdDepartamento());
            } else {
                ps.setNull(5, Types.BIGINT);
            }

            if (entidad.getIdCargo() != null) {
                ps.setLong(6, entidad.getIdCargo());
            } else {
                ps.setNull(6, Types.BIGINT);
            }

            ps.setInt(7, entidad.isPrimerInicio() ? 1 : 0);
            ps.setInt(8, entidad.isActivo() ? 1 : 0);
            ps.setString(9, entidad.getCodigoRecuperacion());
            ps.setString(10, entidad.getUrlFoto());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Usuario> getAll() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE u.activo = 1 ORDER BY u.nombre ASC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                usuarios.add(mapResultSetToUsuario(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    @Override
    public Usuario getById(Long id) {
        String sql = BASE_SELECT + "WHERE u.id_usuario = ? AND u.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(Usuario entidad) {
        String sql = "UPDATE USUARIOS SET nombre = ?, correo = ?, rol = ?, id_departamento = ?, id_cargo = ?, primer_inicio = ?, activo = ?, url_foto = ? WHERE id_usuario = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, entidad.getNombre());
            ps.setString(2, entidad.getCorreo());
            ps.setString(3, entidad.getRol());

            if (entidad.getIdDepartamento() != null) {
                ps.setLong(4, entidad.getIdDepartamento());
            } else {
                ps.setNull(4, Types.BIGINT);
            }

            if (entidad.getIdCargo() != null) {
                ps.setLong(5, entidad.getIdCargo());
            } else {
                ps.setNull(5, Types.BIGINT);
            }

            ps.setInt(6, entidad.isPrimerInicio() ? 1 : 0);
            ps.setInt(7, entidad.isActivo() ? 1 : 0);
            ps.setString(8, entidad.getUrlFoto());
            ps.setLong(9, entidad.getIdUsuario());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(Long id) {
        // Borrado Lógico: Cambia activo a 0
        String sql = "UPDATE USUARIOS SET activo = 0 WHERE id_usuario = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario login(String correo, String password) {
        String sql = BASE_SELECT + "WHERE u.correo = ? AND u.password = ? AND u.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, correo);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Usuario getByCorreo(String correo) {
        String sql = BASE_SELECT + "WHERE LOWER(u.correo) = LOWER(?) AND u.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean cambiarEstado(Long idUsuario, boolean activo) {
        String sql = "UPDATE USUARIOS SET activo = ? WHERE id_usuario = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, activo ? 1 : 0);
            ps.setLong(2, idUsuario);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarPassword(Long idUsuario, String nuevaPassword, boolean primerInicio) {
        String sql = "UPDATE USUARIOS SET password = ?, primer_inicio = ? WHERE id_usuario = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuevaPassword);
            ps.setInt(2, primerInicio ? 1 : 0);
            ps.setLong(3, idUsuario);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean guardarCodigoRecuperacion(String correo, String codigo) {
        String sql = "UPDATE USUARIOS SET codigo_recuperacion = ? WHERE correo = ?";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, codigo);
            ps.setString(2, correo);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario getByCodigoRecuperacion(String codigo) {
        String sql = BASE_SELECT + "WHERE u.codigo_recuperacion = ? AND u.activo = 1";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, codigo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Usuario> getEmpleados() {
        List<Usuario> lista = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE u.rol = 'EMPLEADO' AND u.activo = 1 ORDER BY u.nombre ASC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToUsuario(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Usuario> getTodosLosEmpleados() {
        List<Usuario> lista = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE u.rol = 'EMPLEADO' ORDER BY u.id_usuario DESC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToUsuario(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }


    public List<Usuario> getByDepartamentoId(Long idDepartamento) {
        List<Usuario> lista = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE u.id_departamento = ? AND u.activo = 1 ORDER BY u.nombre ASC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idDepartamento);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToUsuario(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Usuario> getByCargoId(Long idCargo) {
        List<Usuario> lista = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE u.id_cargo = ? AND u.activo = 1 ORDER BY u.nombre ASC";
        try (Connection con = SQLConnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, idCargo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToUsuario(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    private Usuario mapResultSetToUsuario(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setIdUsuario(rs.getLong("id_usuario"));
        u.setNombre(rs.getString("nombre"));
        u.setCorreo(rs.getString("correo"));
        u.setPassword(rs.getString("password"));
        u.setRol(rs.getString("rol"));

        long idDepto = rs.getLong("id_departamento");
        if (!rs.wasNull()) {
            u.setIdDepartamento(idDepto);
        }

        long idCar = rs.getLong("id_cargo");
        if (!rs.wasNull()) {
            u.setIdCargo(idCar);
        }

        u.setPrimerInicio(rs.getInt("primer_inicio") == 1);
        u.setActivo(rs.getInt("activo") == 1);
        u.setCodigoRecuperacion(rs.getString("codigo_recuperacion"));

        try {
            u.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        } catch (SQLException ignored) {}

        try {
            u.setNombreDepartamento(rs.getString("nombre_departamento"));
        } catch (SQLException ignored) {}

        try {
            u.setNombreCargo(rs.getString("nombre_cargo"));
        } catch (SQLException ignored) {}

        try {
            u.setUrlFoto(rs.getString("url_foto"));
        } catch (SQLException ignored) {}

        return u;
    }
}
