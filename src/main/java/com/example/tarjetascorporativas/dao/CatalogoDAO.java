package com.example.tarjetascorporativas.dao;

import org.example.tarjetas_corporativas.model.CatalogoItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para las tablas de catálogo: {@code DEPARTAMENTOS}, {@code CARGOS} y {@code CATEGORIAS_CUENTA}.
 */
public class CatalogoDAO {

    public List<CatalogoItem> findDepartamentosActivos(Connection con) throws SQLException {
        return querySimple(con, "SELECT id, nombre FROM DEPARTAMENTOS WHERE activo=1 ORDER BY nombre");
    }

    public List<CatalogoItem> findCargosActivos(Connection con) throws SQLException {
        return querySimple(con, "SELECT id, nombre FROM CARGOS WHERE activo=1 ORDER BY nombre");
    }

    public List<CatalogoItem> findCategoriasActivas(Connection con) throws SQLException {
        return querySimple(con, "SELECT id, nombre FROM CATEGORIAS_CUENTA WHERE activo=1 ORDER BY nombre");
    }

    public void insertDepartamento(Connection con, String nombre) throws SQLException {
        exec(con, "INSERT INTO DEPARTAMENTOS (nombre) VALUES (?)", nombre);
    }

    public void insertCargo(Connection con, String nombre) throws SQLException {
        exec(con, "INSERT INTO CARGOS (nombre) VALUES (?)", nombre);
    }

    public void insertCategoria(Connection con, String nombre) throws SQLException {
        exec(con, "INSERT INTO CATEGORIAS_CUENTA (nombre) VALUES (?)", nombre);
    }

    public void updateDepartamento(Connection con, long id, String nombre) throws SQLException {
        execUpdate(con, "UPDATE DEPARTAMENTOS SET nombre=? WHERE id=?", nombre, id);
    }

    public void updateCargo(Connection con, long id, String nombre) throws SQLException {
        execUpdate(con, "UPDATE CARGOS SET nombre=? WHERE id=?", nombre, id);
    }

    public void updateCategoria(Connection con, long id, String nombre) throws SQLException {
        execUpdate(con, "UPDATE CATEGORIAS_CUENTA SET nombre=? WHERE id=?", nombre, id);
    }

    public void deactivateDepartamento(Connection con, long id) throws SQLException {
        execDeactivate(con, "DEPARTAMENTOS", id);
    }

    public void deactivateCargo(Connection con, long id) throws SQLException {
        execDeactivate(con, "CARGOS", id);
    }

    public void deactivateCategoria(Connection con, long id) throws SQLException {
        execDeactivate(con, "CATEGORIAS_CUENTA", id);
    }

    // Helpers

    private List<CatalogoItem> querySimple(Connection con, String sql) throws SQLException {
        List<CatalogoItem> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(new CatalogoItem(rs.getLong("id"), rs.getString("nombre")));
        }
        return list;
    }

    private void exec(Connection con, String sql, String nombre) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.executeUpdate();
        }
    }

    private void execUpdate(Connection con, String sql, String nombre, long id) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setLong(2, id);
            ps.executeUpdate();
        }
    }

    public List<Object[]> findCargosConCount(Connection con) throws SQLException {
        String sql =
            "SELECT c.id, c.nombre, COUNT(u.id) AS total_emp " +
            "FROM CARGOS c " +
            "LEFT JOIN EMPLEADOS e ON e.cargo_id = c.id " +
            "LEFT JOIN USUARIOS u ON u.id = e.usuario_id AND u.activo = 1 " +
            "WHERE c.activo = 1 " +
            "GROUP BY c.id, c.nombre ORDER BY c.nombre";
        List<Object[]> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(new Object[]{ rs.getLong("id"), rs.getString("nombre"), rs.getLong("total_emp") });
        }
        return list;
    }

    public List<Object[]> findEmpleadosByCargo(Connection con, long cargoId) throws SQLException {
        String sql =
            "SELECT u.id, " +
            "       u.nombre || ' ' || NVL(u.apellido_paterno,'') AS nombre_completo, " +
            "       u.email, NVL(d.nombre,'Sin depto') AS departamento " +
            "FROM EMPLEADOS e " +
            "JOIN USUARIOS u ON u.id = e.usuario_id AND u.activo = 1 " +
            "LEFT JOIN DEPARTAMENTOS d ON d.id = e.departamento_id " +
            "WHERE e.cargo_id = ? ORDER BY u.nombre";
        List<Object[]> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, cargoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(new Object[]{ rs.getLong("id"), rs.getString("nombre_completo"),
                                           rs.getString("email"), rs.getString("departamento") });
            }
        }
        return list;
    }

    public List<Object[]> findDepartamentosConCount(Connection con) throws SQLException {
        String sql =
            "SELECT d.id, d.nombre, COUNT(u.id) AS total_emp " +
            "FROM DEPARTAMENTOS d " +
            "LEFT JOIN EMPLEADOS e ON e.departamento_id = d.id " +
            "LEFT JOIN USUARIOS u ON u.id = e.usuario_id AND u.activo = 1 " +
            "WHERE d.activo = 1 " +
            "GROUP BY d.id, d.nombre ORDER BY d.nombre";
        List<Object[]> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(new Object[]{ rs.getLong("id"), rs.getString("nombre"), rs.getLong("total_emp") });
        }
        return list;
    }

    public List<Object[]> findEmpleadosByDepartamento(Connection con, long deptId) throws SQLException {
        String sql =
            "SELECT u.id, " +
            "       u.nombre || ' ' || NVL(u.apellido_paterno,'') AS nombre_completo, " +
            "       u.email, NVL(c.nombre,'Sin cargo') AS cargo " +
            "FROM EMPLEADOS e " +
            "JOIN USUARIOS u ON u.id = e.usuario_id AND u.activo = 1 " +
            "LEFT JOIN CARGOS c ON c.id = e.cargo_id " +
            "WHERE e.departamento_id = ? ORDER BY u.nombre";
        List<Object[]> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, deptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(new Object[]{ rs.getLong("id"), rs.getString("nombre_completo"),
                                           rs.getString("email"), rs.getString("cargo") });
            }
        }
        return list;
    }

    public List<Object[]> findCategoriasConCount(Connection con) throws SQLException {
        String sql =
            "SELECT cat.id, cat.nombre, COUNT(c.id) AS total_cuentas " +
            "FROM CATEGORIAS_CUENTA cat " +
            "LEFT JOIN CUENTAS c ON c.categoria_id = cat.id AND c.activo = 1 " +
            "WHERE cat.activo = 1 " +
            "GROUP BY cat.id, cat.nombre ORDER BY cat.nombre";
        List<Object[]> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(new Object[]{ rs.getLong("id"), rs.getString("nombre"), rs.getLong("total_cuentas") });
        }
        return list;
    }

    public List<Object[]> findCuentasByCategoria(Connection con, long categoriaId) throws SQLException {
        String sql =
            "SELECT c.id, c.numero_cuenta, " +
            "       u.nombre || ' ' || NVL(u.apellido_paterno,'') AS titular, " +
            "       c.saldo, c.estado " +
            "FROM CUENTAS c " +
            "JOIN USUARIOS u ON u.id = c.usuario_id " +
            "WHERE c.categoria_id = ? AND c.activo = 1 ORDER BY u.nombre";
        List<Object[]> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, categoriaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(new Object[]{ rs.getLong("id"), rs.getString("numero_cuenta"),
                                           rs.getString("titular"), rs.getBigDecimal("saldo"),
                                           rs.getString("estado") });
            }
        }
        return list;
    }

    // Table name is safe: only called with whitelist string literals from callers above
    private void execDeactivate(Connection con, String tabla, long id) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM " + tabla + " WHERE id = ?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }
}
