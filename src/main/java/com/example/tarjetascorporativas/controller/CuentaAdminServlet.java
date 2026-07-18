package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.Cuenta;
import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.model.dao.CuentaDao;
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

@WebServlet(name = "CuentaAdminServlet", value = {"/admin/cuentas", "/admin/registrar-cuenta", "/admin/cambiar-estado-cuenta"})
public class CuentaAdminServlet extends HttpServlet {

    private final CuentaDao cuentaDao = new CuentaDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();
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

        if ("/admin/registrar-cuenta".equals(path)) {
            registrarCuenta(request, response);
        } else if ("/admin/cambiar-estado-cuenta".equals(path)) {
            cambiarEstadoCuenta(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/cuentas");
        }
    }

    private void registrarCuenta(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String idEmpleadoStr = request.getParameter("idEmpleado");
        String nombreCuenta = request.getParameter("nombreCuenta");
        String descripcion = request.getParameter("descripcion");
        String limiteAsignadoStr = request.getParameter("limiteAsignado");
        String saldoInicialStr = request.getParameter("saldoInicial");

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
            BigDecimal saldoInicial = (saldoInicialStr != null && !saldoInicialStr.isEmpty())
                    ? new BigDecimal(saldoInicialStr)
                    : limiteAsignado;

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
            cuenta.setSaldo(saldoInicial);
            cuenta.setActivo(true);

            boolean creada = cuentaDao.create(cuenta);

            if (creada) {
                session.setAttribute("mensajeExito", "¡Cuenta '" + nombreCuenta + "' creada con éxito para el empleado!");
            } else {
                session.setAttribute("mensajeError", "No se pudo registrar la cuenta en la base de datos.");
            }

        } catch (Exception e) {
            session.setAttribute("mensajeError", "Datos inválidos para montos o IDs de la cuenta: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/cuentas");
    }

    private void cambiarEstadoCuenta(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        String idCuentaStr = request.getParameter("idCuenta");
        String nuevoEstadoStr = request.getParameter("nuevoEstado");

        if (idCuentaStr != null && nuevoEstadoStr != null) {
            try {
                Long idCuenta = Long.parseLong(idCuentaStr);
                boolean nuevoEstado = Boolean.parseBoolean(nuevoEstadoStr);

                boolean actualizado;
                if (!nuevoEstado) {
                    // Deshabilitar la cuenta con reintegro automático a la conservadora
                    actualizado = cuentaDao.deshabilitarCuenta(idCuenta);
                } else {
                    Cuenta c = cuentaDao.getById(idCuenta);
                    if (c != null) {
                        c.setActivo(true);
                        actualizado = cuentaDao.update(c);
                    } else {
                        actualizado = false;
                    }
                }

                if (actualizado) {
                    session.setAttribute("mensajeExito", "Estado de la cuenta actualizado correctamente.");
                } else {
                    session.setAttribute("mensajeError", "No se pudo actualizar el estado de la cuenta.");
                }
            } catch (Exception e) {
                session.setAttribute("mensajeError", "Error al cambiar el estado de la cuenta.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/cuentas");
    }

    private void cargarDatos(HttpServletRequest request) {
        List<Cuenta> listaCuentas = cuentaDao.getTodasLasCuentas();
        List<Usuario> listaEmpleados = usuarioDao.getEmpleados();

        long activasCount = listaCuentas.stream().filter(Cuenta::isActivo).count();

        request.setAttribute("listaCuentas", listaCuentas);
        request.setAttribute("listaEmpleados", listaEmpleados);
        request.setAttribute("cuentasActivasCount", activasCount);
    }
}
