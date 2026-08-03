package com.example.tarjetascorporativas.service;

import org.example.tarjetas_corporativas.config.DataSourceProvider;
import org.example.tarjetas_corporativas.dao.CuentaDAO;
import org.example.tarjetas_corporativas.dao.MovimientoDAO;
import org.example.tarjetas_corporativas.dao.impl.CuentaDAOImpl;
import org.example.tarjetas_corporativas.dao.impl.MovimientoDAOImpl;
import org.example.tarjetas_corporativas.exception.ServiceException;
import org.example.tarjetas_corporativas.model.CuentaUser;
import org.example.tarjetas_corporativas.model.MovimientoDashboard;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Servicio de negocio para los datos del dashboard de empleado.
 * <p>
 * Provee el resumen de cuentas activas del usuario, el saldo total consolidado
 * y los últimos movimientos para la vista de inicio del empleado.
 * </p>
 */
public class DashboardUserService {

    private final CuentaDAO    cuentaDAO;
    private final MovimientoDAO movimientoDAO;

    /** Construye el servicio inicializando las implementaciones DAO. */
    public DashboardUserService() {
        this.cuentaDAO    = new CuentaDAOImpl();
        this.movimientoDAO = new MovimientoDAOImpl();
    }

    /**
     * Retorna las cuentas activas del usuario para la sección resumen del dashboard.
     *
     * @param usuarioId ID del usuario
     * @return lista de {@link CuentaUser}
     * @throws ServiceException si ocurre un error de base de datos
     */
    public List<CuentaUser> getCuentas(long usuarioId) {
        try (Connection con = DataSourceProvider.getConnection()) {
            return cuentaDAO.findByUsuarioId(con, usuarioId);
        } catch (SQLException e) {
            throw new ServiceException("Error al cargar cuentas del usuario", e);
        }
    }

    /**
     * Calcula el saldo total consolidado sumando los saldos de todas las cuentas provistas.
     *
     * @param cuentas lista de cuentas del usuario (puede estar vacía)
     * @return suma de saldos; {@link BigDecimal#ZERO} si la lista está vacía
     */
    public BigDecimal getSaldoTotal(List<CuentaUser> cuentas) {
        return cuentas.stream()
            .map(CuentaUser::getSaldo)
            .filter(s -> s != null)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    /**
     * Retorna los últimos movimientos del usuario para la sección de actividad reciente.
     *
     * @param usuarioId ID del usuario
     * @param limit     número máximo de registros
     * @return lista de {@link MovimientoDashboard}
     * @throws ServiceException si ocurre un error de base de datos
     */
    public List<MovimientoDashboard> getMovimientosRecientes(long usuarioId, int limit) {
        try (Connection con = DataSourceProvider.getConnection()) {
            return movimientoDAO.findDashboardByUsuarioId(con, usuarioId, limit);
        } catch (SQLException e) {
            throw new ServiceException("Error al cargar movimientos del usuario", e);
        }
    }
}
