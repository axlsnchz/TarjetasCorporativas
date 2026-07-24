package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.Cuenta;
import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.model.dao.CuentaDao;
import com.example.tarjetascorporativas.model.dao.MovimientoDao;
import com.example.tarjetascorporativas.model.dao.UsuarioDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.util.List;

@WebServlet(name = "CuentaAdminServlet", value = {"/admin/cuentas", "/admin/registrar-cuenta", "/admin/editar-cuenta", "/admin/cambiar-estado-cuenta", "/admin/introducir-fondos", "/admin/depositar-cuenta"})
public class CuentaAdminServlet extends HttpServlet {

    private final CuentaDao cuentaDao = new CuentaDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();
    private final MovimientoDao movimientoDao = new MovimientoDao();
    private final SecureRandom random = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        cargarDatos(request);
        request.getRequestDispatcher("/admin/gestion-cuentas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/registrar-cuenta".equals(path) || "/admin/editar-cuenta".equals(path)) {
            registrarCuenta(request, response);
        } else if ("/admin/cambiar-estado-cuenta".equals(path)) {
            cambiarEstadoCuenta(request, response);
        } else if ("/admin/introducir-fondos".equals(path)) {
            introducirFondos(request, response);
        } else if ("/admin/depositar-cuenta".equals(path)) {
            depositarCuenta(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/cuentas");
        }
    }

    private void registrarCuenta(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String idCuentaStr = request.getParameter("idCuenta");
        String idEmpleadoStr = request.getParameter("idEmpleado");
        String nombreCuenta = request.getParameter("nombreCuenta");
        String descripcion = request.getParameter("descripcion");
        String limiteAsignadoStr = request.getParameter("limiteAsignado");

        if (nombreCuenta != null) nombreCuenta = nombreCuenta.trim();
        if (descripcion != null) descripcion = descripcion.trim();

        if (idEmpleadoStr == null || idEmpleadoStr.isEmpty() ||
            nombreCuenta == null || nombreCuenta.isEmpty() ||
            descripcion == null || descripcion.isEmpty() ||
            limiteAsignadoStr == null || limiteAsignadoStr.isEmpty()) {

            session.setAttribute("mensajeError", "Todos los campos marcados son obligatorios.");
            response.sendRedirect(request.getContextPath() + "/admin/cuentas");
            return;
        }

        try {
            Long idEmpleado = Long.parseLong(idEmpleadoStr);
            BigDecimal limiteAsignado = new BigDecimal(limiteAsignadoStr);
            boolean esEdicion = idCuentaStr != null && !idCuentaStr.trim().isEmpty();

            if (esEdicion) {
                Long idCuenta = Long.parseLong(idCuentaStr.trim());
                Cuenta c = cuentaDao.getById(idCuenta);
                if (c != null) {
                    c.setIdEmpleado(idEmpleado);
                    c.setNombreCuenta(nombreCuenta);
                    c.setDescripcion(descripcion);
                    c.setLimiteAsignado(limiteAsignado);

                    boolean actualizado = cuentaDao.update(c);
                    if (actualizado) {
                        session.setAttribute("mensajeExito", "¡Cuenta '" + nombreCuenta + "' actualizada con éxito!");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo actualizar la cuenta en la base de datos.");
                    }
                } else {
                    session.setAttribute("mensajeError", "No se encontró la cuenta a editar.");
                }
            } else {
                // Generar número de cuenta único seguro (ej. ACCT-4920)
                String numeroCuenta = "ACCT-" + (1000 + random.nextInt(9000));
                while (cuentaDao.getByNumeroCuenta(numeroCuenta) != null) {
                    numeroCuenta = "ACCT-" + (1000 + random.nextInt(9000));
                }

                Cuenta cuenta = new Cuenta();
                cuenta.setNumeroCuenta(numeroCuenta);
                cuenta.setIdEmpleado(idEmpleado);
                cuenta.setNombreCuenta(nombreCuenta);
                cuenta.setDescripcion(descripcion);
                cuenta.setLimiteAsignado(limiteAsignado);
                cuenta.setSaldo(BigDecimal.ZERO);
                cuenta.setActivo(true);

                boolean creada = cuentaDao.create(cuenta);

                if (creada) {
                    session.setAttribute("mensajeExito", "¡Cuenta '" + nombreCuenta + "' creada con éxito!");
                } else {
                    session.setAttribute("mensajeError", "No se pudo registrar la cuenta en la base de datos.");
                }
            }

        } catch (Exception e) {
            session.setAttribute("mensajeError", "Datos inválidos para montos o IDs de la cuenta: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/cuentas");
    }

    private void depositarCuenta(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String idCuentaStr = request.getParameter("idCuenta");
        String montoStr = request.getParameter("monto");
        String descripcion = request.getParameter("descripcion");

        if (idCuentaStr == null || montoStr == null || montoStr.trim().isEmpty()) {
            session.setAttribute("mensajeError", "Debe ingresar un monto válido y seleccionar una cuenta.");
            response.sendRedirect(request.getContextPath() + "/admin/cuentas");
            return;
        }

        try {
            Long idCuentaDestino = Long.parseLong(idCuentaStr);
            BigDecimal monto = new BigDecimal(montoStr.trim());

            if (monto.compareTo(BigDecimal.ZERO) <= 0) {
                session.setAttribute("mensajeError", "El monto a depositar debe ser mayor a cero.");
                response.sendRedirect(request.getContextPath() + "/admin/cuentas");
                return;
            }

            Cuenta concentradora = cuentaDao.getCuentaConcentradora();
            BigDecimal saldoConcentradora = (concentradora != null && concentradora.getSaldo() != null)
                    ? concentradora.getSaldo()
                    : BigDecimal.ZERO;

            if (saldoConcentradora.compareTo(monto) < 0) {
                session.setAttribute("mensajeError", "No hay fondos suficientes en la Cuenta Concentradora. Saldo disponible: $" + String.format("%,.2f", saldoConcentradora) + " MXN.");
                response.sendRedirect(request.getContextPath() + "/admin/cuentas");
                return;
            }

            if (descripcion == null || descripcion.trim().isEmpty()) {
                descripcion = "Depósito desde Cuenta Concentradora";
            }

            boolean exito = movimientoDao.registrarTransferencia(
                    concentradora.getIdCuenta(),
                    idCuentaDestino,
                    monto,
                    descripcion
            );

            if (exito) {
                session.setAttribute("mensajeExito", "¡Depósito de $" + String.format("%,.2f", monto) + " realizado con éxito desde la Cuenta Concentradora!");
            } else {
                session.setAttribute("mensajeError", "No se pudo realizar el depósito en la base de datos.");
            }
        } catch (Exception e) {
            session.setAttribute("mensajeError", "Error al realizar el depósito: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/cuentas");
    }

    private void cambiarEstadoCuenta(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        String idCuentaStr = request.getParameter("idCuenta");
        String accion = request.getParameter("accion");
        String nuevoEstadoStr = request.getParameter("nuevoEstado");

        if (idCuentaStr != null) {
            try {
                Long idCuenta = Long.parseLong(idCuentaStr);
                Cuenta concentradora = cuentaDao.getCuentaConcentradora();
                if (concentradora != null && concentradora.getIdCuenta().equals(idCuenta)) {
                    session.setAttribute("mensajeError", "La Cuenta Concentradora no se puede desactivar ni dar de baja, ya que es la cuenta principal del sistema.");
                    response.sendRedirect(request.getContextPath() + "/admin/cuentas");
                    return;
                }

                boolean actualizado = false;

                if ("dar_de_baja".equals(accion)) {
                    // Dar de baja: Devolución automática de saldo a la concentradora y borrado lógico
                    actualizado = cuentaDao.deshabilitarCuenta(idCuenta);
                    if (actualizado) {
                        session.setAttribute("mensajeExito", "La cuenta ha sido dada de baja correctamente y su saldo se reintegró a la Cuenta Concentradora.");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo dar de baja la cuenta.");
                    }
                } else if ("desactivar".equals(accion) || ("false".equals(nuevoEstadoStr) && accion == null)) {
                    // Desactivar: Marcar inactiva sin devolver saldo aún
                    Cuenta c = cuentaDao.getById(idCuenta);
                    if (c != null) {
                        c.setActivo(false);
                        actualizado = cuentaDao.update(c);
                    }
                    if (actualizado) {
                        session.setAttribute("mensajeExito", "La cuenta ha sido desactivada correctamente.");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo desactivar la cuenta.");
                    }
                } else if ("activar".equals(accion) || ("true".equals(nuevoEstadoStr) && accion == null)) {
                    // Activar: Marcar como activa
                    Cuenta c = cuentaDao.getById(idCuenta);
                    if (c != null) {
                        c.setActivo(true);
                        actualizado = cuentaDao.update(c);
                    }
                    if (actualizado) {
                        session.setAttribute("mensajeExito", "La cuenta ha sido activada correctamente.");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo activar la cuenta.");
                    }
                }
            } catch (Exception e) {
                session.setAttribute("mensajeError", "Error al procesar el estado de la cuenta: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/cuentas");
    }

    private void introducirFondos(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        String montoStr = request.getParameter("monto");
        String descripcion = request.getParameter("descripcion");

        if (montoStr == null || montoStr.trim().isEmpty()) {
            session.setAttribute("mensajeError", "Debe ingresar un monto válido.");
            redirectBack(request, response);
            return;
        }

        try {
            BigDecimal monto = new BigDecimal(montoStr.trim());
            if (monto.compareTo(BigDecimal.ZERO) <= 0) {
                session.setAttribute("mensajeError", "El monto ingresado debe ser mayor a cero.");
                redirectBack(request, response);
                return;
            }

            boolean exito = movimientoDao.registrarDepositoConservadora(monto, descripcion);

            if (exito) {
                session.setAttribute("mensajeExito", "¡Fondos por $" + String.format("%,.2f", monto) + " ingresados exitosamente a la Cuenta Concentradora!");
            } else {
                session.setAttribute("mensajeError", "No se pudieron ingresar los fondos en la base de datos.");
            }

        } catch (Exception e) {
            session.setAttribute("mensajeError", "Monto inválido: " + e.getMessage());
        }

        redirectBack(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/principal-admin.jsp");
        }
    }

    private void cargarDatos(HttpServletRequest request) {
        List<Cuenta> listaCuentas = cuentaDao.getCuentasEmpleados();
        List<Usuario> listaEmpleados = usuarioDao.getEmpleados();

        Cuenta concentradora = cuentaDao.getCuentaConcentradora();
        BigDecimal saldoConcentradora = (concentradora != null && concentradora.getSaldo() != null)
                ? concentradora.getSaldo()
                : BigDecimal.ZERO;

        long activasCount = listaCuentas.stream().filter(Cuenta::isActivo).count();

        request.setAttribute("listaCuentas", listaCuentas);
        request.setAttribute("listaEmpleados", listaEmpleados);
        request.setAttribute("cuentasActivasCount", activasCount);
        request.setAttribute("saldoConcentradora", saldoConcentradora);
    }
}
