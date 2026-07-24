package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.Cuenta;
import com.example.tarjetascorporativas.model.Tarjeta;
import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.model.dao.CuentaDao;
import com.example.tarjetascorporativas.model.dao.TarjetaDao;
import com.example.tarjetascorporativas.model.dao.UsuarioDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.List;

@WebServlet(name = "TarjetaAdminServlet", value = {"/admin/tarjetas", "/admin/emitir-tarjeta", "/admin/cambiar-estado-tarjeta"})
public class TarjetaAdminServlet extends HttpServlet {

    private final TarjetaDao tarjetaDao = new TarjetaDao();
    private final CuentaDao cuentaDao = new CuentaDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();
    private final SecureRandom random = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        cargarDatos(request);
        request.getRequestDispatcher("/admin/gestion-tarjetas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/emitir-tarjeta".equals(path)) {
            emitirTarjeta(request, response);
        } else if ("/admin/cambiar-estado-tarjeta".equals(path)) {
            cambiarEstadoTarjeta(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/tarjetas");
        }
    }

    private void emitirTarjeta(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        String idTarjetaStr = request.getParameter("idTarjeta");
        String idCuentaStr = request.getParameter("idCuenta");
        String tipoTarjeta = request.getParameter("tipoTarjeta"); // "VIRTUAL" o "FISICA"
        String alias = request.getParameter("alias");
        String numeroTarjeta = request.getParameter("numeroTarjeta");
        String cvv = request.getParameter("cvv");
        String fechaExpiracion = request.getParameter("fechaExpiracion");

        if (idCuentaStr == null || idCuentaStr.trim().isEmpty()) {
            session.setAttribute("mensajeError", "Debe seleccionar la cuenta a la que pertenecerá la tarjeta.");
            response.sendRedirect(request.getContextPath() + "/admin/tarjetas");
            return;
        }

        try {
            Long idCuenta = Long.parseLong(idCuentaStr);

            if (tipoTarjeta == null || tipoTarjeta.trim().isEmpty()) {
                tipoTarjeta = "VIRTUAL";
            } else {
                tipoTarjeta = tipoTarjeta.trim().toUpperCase();
            }

            if (alias == null || alias.trim().isEmpty()) {
                alias = "Tarjeta" + (random.nextInt(900) + 100);
            } else {
                alias = alias.trim();
            }

            // Limpiar formato de número de tarjeta
            if (numeroTarjeta != null) {
                numeroTarjeta = numeroTarjeta.replaceAll("\\s+", "");
            }
            if (numeroTarjeta == null || numeroTarjeta.length() < 16) {
                StringBuilder sb = new StringBuilder("4532");
                for (int i = 0; i < 12; i++) {
                    sb.append(random.nextInt(10));
                }
                numeroTarjeta = sb.toString();
            } else if (numeroTarjeta.length() > 16) {
                numeroTarjeta = numeroTarjeta.substring(0, 16);
            }

            if (cvv == null || cvv.trim().isEmpty()) {
                cvv = String.format("%03d", random.nextInt(1000));
            } else {
                cvv = cvv.trim();
                if (cvv.length() > 4) {
                    cvv = cvv.substring(0, 4);
                }
            }

            // Expiración estrictamente de máximo 5 caracteres (MM/YY) para cumplir con el esquema Oracle VARCHAR2(5)
            if (fechaExpiracion == null || fechaExpiracion.trim().isEmpty()) {
                java.time.LocalDate now = java.time.LocalDate.now().plusYears(3);
                fechaExpiracion = String.format("%02d/%02d", now.getMonthValue(), now.getYear() % 100);
            } else {
                fechaExpiracion = fechaExpiracion.trim().replaceAll("\\s+", "");
                if (fechaExpiracion.length() > 5) {
                    fechaExpiracion = fechaExpiracion.substring(0, 5);
                }
            }

            boolean esEdicion = idTarjetaStr != null && !idTarjetaStr.trim().isEmpty();
            boolean exito = false;

            if (esEdicion) {
                Long idTarjeta = Long.parseLong(idTarjetaStr.trim());
                Tarjeta t = tarjetaDao.getById(idTarjeta);
                if (t == null) {
                    t = new Tarjeta();
                    t.setIdTarjeta(idTarjeta);
                }
                t.setIdCuenta(idCuenta);
                t.setTipoTarjeta(tipoTarjeta);
                t.setAlias(alias);
                t.setNumeroTarjeta(numeroTarjeta);
                t.setCvv(cvv);
                t.setFechaExpiracion(fechaExpiracion);
                t.setActivo(true);
                exito = tarjetaDao.update(t);
                if (exito) {
                    session.setAttribute("mensajeExito", "¡Tarjeta '" + alias + "' actualizada exitosamente!");
                } else {
                    session.setAttribute("mensajeError", "No se pudo actualizar la tarjeta en la base de datos.");
                }
            } else {
                Tarjeta tarjeta = new Tarjeta();
                tarjeta.setIdCuenta(idCuenta);
                tarjeta.setTipoTarjeta(tipoTarjeta);
                tarjeta.setAlias(alias);
                tarjeta.setNumeroTarjeta(numeroTarjeta);
                tarjeta.setCvv(cvv);
                tarjeta.setFechaExpiracion(fechaExpiracion);
                tarjeta.setActivo(true);
                exito = tarjetaDao.create(tarjeta);
                if (exito) {
                    session.setAttribute("mensajeExito", "¡Tarjeta '" + alias + "' emitida exitosamente!");
                } else {
                    session.setAttribute("mensajeError", "No se pudo registrar la tarjeta en la base de datos.");
                }
            }

        } catch (Exception e) {
            session.setAttribute("mensajeError", "Error al procesar la emisión de la tarjeta: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/tarjetas");
    }

    private void cambiarEstadoTarjeta(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        String idTarjetaStr = request.getParameter("idTarjeta");
        String accion = request.getParameter("accion"); // "activar", "desactivar", "dar_de_baja"

        if (idTarjetaStr != null) {
            try {
                Long idTarjeta = Long.parseLong(idTarjetaStr);
                boolean exito = false;

                if ("dar_de_baja".equals(accion)) {
                    exito = tarjetaDao.delete(idTarjeta);
                    if (exito) {
                        session.setAttribute("mensajeExito", "La tarjeta ha sido dada de baja correctamente.");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo dar de baja la tarjeta.");
                    }
                } else if ("desactivar".equals(accion)) {
                    Tarjeta t = tarjetaDao.getById(idTarjeta);
                    if (t != null) {
                        t.setActivo(false);
                        exito = tarjetaDao.update(t);
                    }
                    if (exito) {
                        session.setAttribute("mensajeExito", "La tarjeta ha sido desactivada correctamente.");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo desactivar la tarjeta.");
                    }
                } else if ("activar".equals(accion)) {
                    Tarjeta t = tarjetaDao.getById(idTarjeta);
                    if (t != null) {
                        t.setActivo(true);
                        exito = tarjetaDao.update(t);
                    }
                    if (exito) {
                        session.setAttribute("mensajeExito", "La tarjeta ha sido activada correctamente.");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo activar la tarjeta.");
                    }
                }
            } catch (Exception e) {
                session.setAttribute("mensajeError", "Error al modificar la tarjeta: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/tarjetas");
    }

    private void cargarDatos(HttpServletRequest request) {
        List<Tarjeta> listaTarjetas = tarjetaDao.getTodasLasTarjetas();
        List<Usuario> listaEmpleados = usuarioDao.getEmpleados();
        List<Cuenta> listaCuentas = cuentaDao.getCuentasEmpleados();

        request.setAttribute("listaTarjetas", listaTarjetas);
        request.setAttribute("listaEmpleados", listaEmpleados);
        request.setAttribute("listaCuentas", listaCuentas);
    }
}
