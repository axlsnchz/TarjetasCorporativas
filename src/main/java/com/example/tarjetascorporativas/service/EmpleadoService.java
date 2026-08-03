package com.example.tarjetascorporativas.service;

import org.example.tarjetas_corporativas.config.DataSourceProvider;
import org.example.tarjetas_corporativas.dao.*;
import org.example.tarjetas_corporativas.dao.impl.*;
import org.example.tarjetas_corporativas.exception.ServiceException;
import org.example.tarjetas_corporativas.model.*;
import org.example.tarjetas_corporativas.util.PageUtil;
import org.example.tarjetas_corporativas.util.PasswordUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;


/**
 * Servicio de negocio para la gestión de empleados.
 * <p>
 * Centraliza la creación, actualización y baja lógica de empleados.
 * La baja es transaccional: devuelve los fondos de las cuentas activas a la cuenta
 * corporativa global, bloquea tarjetas, congela cuentas y desactiva el usuario
 * en una sola transacción con rollback automático ante fallos.
 * </p>
 */
public class EmpleadoService {

    private final UsuarioDAO  usuarioDAO;
    private final CuentaDAO   cuentaDAO;
    private final TarjetaDAO  tarjetaDAO;
    private final CuentaGlobalDAO cuentaGlobalDAO;
    private final CatalogoDAO catalogoDAO;

    /** Construye el servicio inicializando las implementaciones DAO. */
    public EmpleadoService() {
        this.usuarioDAO      = new UsuarioDAOImpl();
        this.cuentaDAO       = new CuentaDAOImpl();
        this.tarjetaDAO      = new TarjetaDAOImpl();
        this.cuentaGlobalDAO = new CuentaGlobalDAOImpl();
        this.catalogoDAO     = new CatalogoDAOImpl();
    }

    /**
     * Retorna estadísticas agregadas de empleados (total, activos, inactivos, recientes).
     *
     * @return {@link EmpleadoStats} con los contadores
     * @throws ServiceException si ocurre un error de base de datos
     */
    public EmpleadoStats getStats() {
        try (Connection con = DataSourceProvider.getConnection()) {
            return usuarioDAO.getEmpleadoStats(con);
        } catch (SQLException e) {
            throw new ServiceException("Error al cargar estadísticas de empleados", e);
        }
    }

    /**
     * Retorna la lista completa de empleados para la tabla de administración.
     *
     * @return lista de {@link EmpleadoRow}
     * @throws ServiceException si ocurre un error de base de datos
     */
    public List<EmpleadoRow> getEmpleados() {
        try (Connection con = DataSourceProvider.getConnection()) {
            return usuarioDAO.findAllEmpleados(con);
        } catch (SQLException e) {
            throw new ServiceException("Error al cargar empleados", e);
        }
    }

    public PageResult<EmpleadoRow> getEmpleadosPaged(String search, Boolean activo, int page, int pageSize) {
        try (Connection con = DataSourceProvider.getConnection()) {
            long total  = usuarioDAO.countEmpleados(con, search, activo);
            int  offset = PageUtil.offset(page, pageSize);
            List<EmpleadoRow> items = usuarioDAO.findEmpleadosPaged(con, search, activo, offset, pageSize);
            return new PageResult<>(items, page, pageSize, total);
        } catch (SQLException e) {
            throw new ServiceException("Error al cargar empleados", e);
        }
    }

    /**
     * Retorna los datos necesarios para renderizar el formulario de empleado.
     *
     * @param empleadoId ID del empleado a editar, o {@code null} para creación
     * @return array {@code Object[3]}: {@code [departamentos, cargos, EmpleadoForm|null]}
     * @throws ServiceException si ocurre un error de base de datos
     */
    public Object[] getFormData(Long empleadoId) {
        try (Connection con = DataSourceProvider.getConnection()) {
            List<CatalogoItem> deps    = catalogoDAO.findDepartamentosActivos(con);
            List<CatalogoItem> cargos  = catalogoDAO.findCargosActivos(con);
            EmpleadoForm       empForm = empleadoId != null
                ? usuarioDAO.findForEdit(con, empleadoId) : null;
            return new Object[]{ deps, cargos, empForm };
        } catch (SQLException e) {
            throw new ServiceException("Error al cargar formulario de empleado", e);
        }
    }

    /**
     * Crea un nuevo empleado hasheando la contraseña con BCrypt antes de persistir.
     *
     * @param nombre   nombre completo
     * @param email    correo único del empleado
     * @param password contraseña en texto plano (se hashea internamente)
     * @param rol      rol del sistema ({@code "admin"} o {@code "empleado"})
     * @param depId    ID del departamento
     * @param cargoId  ID del cargo
     * @throws ServiceException con clave {@code "empleado_dup"} si el email ya existe
     */
    public void crear(String nombre, String apellidoPaterno, String apellidoMaterno,
                      String email, String password, String rol,
                      Long depId, Long cargoId) {
        try (Connection con = DataSourceProvider.getConnection()) {
            String hash = PasswordUtil.hash(password);
            usuarioDAO.insertEmpleado(con, nombre, apellidoPaterno, apellidoMaterno,
                    email, hash, rol, depId, cargoId);
            con.commit();
        } catch (SQLIntegrityConstraintViolationException e) {
            throw new ServiceException("Email duplicado", "empleado_dup", e);
        } catch (SQLException e) {
            throw new ServiceException("Error al crear empleado", e);
        }
    }

    /**
     * Actualiza los datos de un empleado existente.
     * Si {@code password} es no nulo y no vacío, también actualiza el hash de contraseña.
     *
     * @param id       ID del empleado
     * @param nombre   nombre completo
     * @param email    correo único
     * @param password nueva contraseña en texto plano, o {@code null}/{@code ""} para no cambiarla
     * @param rol      rol del sistema
     * @param depId    ID del departamento
     * @param cargoId  ID del cargo
     * @throws ServiceException con clave {@code "empleado_dup"} si el email ya existe
     */
    public void actualizar(long id, String nombre, String apellidoPaterno, String apellidoMaterno,
                           String email, String password, String rol, Long depId, Long cargoId) {
        try (Connection con = DataSourceProvider.getConnection()) {
            if (password != null && !password.isBlank()) {
                String hash = PasswordUtil.hash(password);
                usuarioDAO.updateEmpleadoConHash(con, id, nombre, apellidoPaterno, apellidoMaterno,
                        email, rol, depId, cargoId, hash);
            } else {
                usuarioDAO.updateEmpleado(con, id, nombre, apellidoPaterno, apellidoMaterno,
                        email, rol, depId, cargoId);
            }
            con.commit();
        } catch (SQLIntegrityConstraintViolationException e) {
            throw new ServiceException("Email duplicado", "empleado_dup", e);
        } catch (SQLException e) {
            throw new ServiceException("Error al actualizar empleado", e);
        }
    }

    /**
     * Baja lógica transaccional de un empleado.
     * <ol>
     *   <li>Suma los saldos de sus cuentas activas y los devuelve a {@code CUENTA_GLOBAL}.</li>
     *   <li>Bloquea todas sus tarjetas activas (respeta {@code ck_tarjeta_estado_actv}).</li>
     *   <li>Congela y pone a cero sus cuentas activas (respeta {@code ck_cuenta_estado_actv}).</li>
     *   <li>Desactiva el registro de usuario.</li>
     * </ol>
     * Si cualquier paso falla se hace rollback completo.
     *
     * @param empleadoId ID del usuario/empleado a dar de baja
     * @throws ServiceException si ocurre un error irrecuperable de base de datos
     */
    public void eliminar(long empleadoId) {
        try (Connection con = DataSourceProvider.getConnection()) {
            try {
                // 1. Sum active account balances
                BigDecimal totalSaldo = usuarioDAO.sumSaldoCuentasActivas(con, empleadoId);

                // 2. Return balance to global account
                if (totalSaldo.compareTo(BigDecimal.ZERO) > 0) {
                    cuentaGlobalDAO.addSaldo(con, totalSaldo);
                }

                // 3. Block cards (constraint requires estado='BLOQUEADA' when activo=0)
                tarjetaDAO.deactivateByUsuarioId(con, empleadoId);

                // 4. Zero-out and freeze accounts (constraint requires estado='CONGELADA' when activo=0)
                cuentaDAO.deactivateByUsuarioId(con, empleadoId);

                // 5. Deactivate user
                usuarioDAO.deactivate(con, empleadoId);

                con.commit();
            } catch (SQLException e) {
                con.rollback();
                throw e;
            }
        } catch (SQLException e) {
            throw new ServiceException("Error al eliminar empleado", e);
        }
    }
}
