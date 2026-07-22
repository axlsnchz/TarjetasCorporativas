package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.Cargo;
import com.example.tarjetascorporativas.model.Departamento;
import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.model.dao.CargoDao;
import com.example.tarjetascorporativas.model.dao.DepartamentoDao;
import com.example.tarjetascorporativas.model.dao.UsuarioDao;
import com.example.tarjetascorporativas.utils.EmailSender;
import com.example.tarjetascorporativas.utils.PasswordGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

@WebServlet(name = "EmpleadoServlet", value = {"/admin/empleados", "/admin/registrar-empleado", "/admin/editar-empleado", "/admin/cambiar-estado-empleado"})
@MultipartConfig
public class EmpleadoServlet extends HttpServlet {

    private final UsuarioDao usuarioDao = new UsuarioDao();
    private final DepartamentoDao departamentoDao = new DepartamentoDao();
    private final CargoDao cargoDao = new CargoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        cargarDatosEmpleado(request);
        request.getRequestDispatcher("/admin/gestion-empleados.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/registrar-empleado".equals(path) || "/admin/editar-empleado".equals(path)) {
            registrarEmpleado(request, response);
        } else if ("/admin/cambiar-estado-empleado".equals(path)) {
            cambiarEstadoEmpleado(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/empleados");
        }
    }

    private void registrarEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String idUsuarioStr = request.getParameter("idUsuario");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String correo = request.getParameter("correo");
        String departamentoNombre = request.getParameter("departamento");
        String cargoNombre = request.getParameter("cargo");

        if (nombreCompleto != null) nombreCompleto = nombreCompleto.trim();
        if (correo != null) correo = correo.trim();
        if (departamentoNombre != null) departamentoNombre = departamentoNombre.trim();
        if (cargoNombre != null) cargoNombre = cargoNombre.trim();

        // Validar campos obligatorios
        if (nombreCompleto == null || nombreCompleto.isEmpty() ||
                correo == null || correo.isEmpty() ||
                departamentoNombre == null || departamentoNombre.isEmpty() ||
                cargoNombre == null || cargoNombre.isEmpty()) {

            session.setAttribute("mensajeError", "Todos los campos marcados son obligatorios.");
            response.sendRedirect(request.getContextPath() + "/admin/empleados");
            return;
        }

        boolean esEdicion = idUsuarioStr != null && !idUsuarioStr.trim().isEmpty();

        // 1. Obtener o crear Departamento
        Departamento depto = departamentoDao.getByNombre(departamentoNombre);
        if (depto == null) {
            depto = new Departamento();
            depto.setNombre(departamentoNombre);
            departamentoDao.create(depto);
            depto = departamentoDao.getByNombre(departamentoNombre);
        }

        // 2. Obtener o crear Cargo
        Cargo cargo = cargoDao.getByNombre(cargoNombre);
        if (cargo == null) {
            cargo = new Cargo();
            cargo.setNombre(cargoNombre);
            cargoDao.create(cargo);
            cargo = cargoDao.getByNombre(cargoNombre);
        }

        // Procesar foto de perfil enviada
        jakarta.servlet.http.Part fotoPart = null;
        try {
            fotoPart = request.getPart("foto");
        } catch (Exception ignored) {}

        String base64Foto = null;
        if (fotoPart != null && fotoPart.getSize() > 0) {
            try (java.io.InputStream is = fotoPart.getInputStream();
                 java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    baos.write(buffer, 0, bytesRead);
                }
                byte[] imageBytes = baos.toByteArray();
                String mimeType = fotoPart.getContentType();
                if (mimeType == null || !mimeType.startsWith("image/")) {
                    mimeType = "image/png";
                }
                base64Foto = "data:" + mimeType + ";base64," + java.util.Base64.getEncoder().encodeToString(imageBytes);
            } catch (Exception e) {
                System.err.println("Error procesando foto de perfil: " + e.getMessage());
            }
        }

        if (esEdicion) {
            try {
                Long idUsuario = Long.parseLong(idUsuarioStr.trim());
                Usuario u = usuarioDao.getById(idUsuario);
                if (u != null) {
                    // Verificar si el correo cambió y pertenece a otro usuario
                    Usuario existente = usuarioDao.getByCorreo(correo);
                    if (existente != null && !existente.getIdUsuario().equals(idUsuario)) {
                        session.setAttribute("mensajeError", "El correo electrónico " + correo + " ya pertenece a otro empleado.");
                        response.sendRedirect(request.getContextPath() + "/admin/empleados");
                        return;
                    }

                    u.setNombre(nombreCompleto);
                    u.setCorreo(correo);
                    if (depto != null) u.setIdDepartamento(depto.getIdDepartamento());
                    if (cargo != null) u.setIdCargo(cargo.getIdCargo());
                    if (base64Foto != null) u.setUrlFoto(base64Foto);

                    boolean actualizado = usuarioDao.update(u);
                    if (actualizado) {
                        session.setAttribute("mensajeExito", "¡Empleado '" + nombreCompleto + "' actualizado con éxito!");
                    } else {
                        session.setAttribute("mensajeError", "No se pudo actualizar el empleado en la base de datos.");
                    }
                } else {
                    session.setAttribute("mensajeError", "No se encontró el empleado a editar.");
                }
            } catch (Exception e) {
                session.setAttribute("mensajeError", "Error al editar empleado: " + e.getMessage());
            }
        } else {
            // Verificar si el correo ya existe
            if (usuarioDao.getByCorreo(correo) != null) {
                session.setAttribute("mensajeError", "El correo electrónico " + correo + " ya está registrado en el sistema.");
                response.sendRedirect(request.getContextPath() + "/admin/empleados");
                return;
            }

            // Generar contraseña temporal
            String tempPassword = PasswordGenerator.generateSecurePassword();

            Usuario usuario = new Usuario();
            usuario.setNombre(nombreCompleto);
            usuario.setCorreo(correo);
            usuario.setPassword(tempPassword);
            usuario.setRol("EMPLEADO");
            if (depto != null) usuario.setIdDepartamento(depto.getIdDepartamento());
            if (cargo != null) usuario.setIdCargo(cargo.getIdCargo());
            if (base64Foto != null) usuario.setUrlFoto(base64Foto);
            usuario.setPrimerInicio(true);
            usuario.setActivo(true);

            boolean creado = usuarioDao.create(usuario);

            if (creado) {
                enviarCorreoCredenciales(nombreCompleto, correo, tempPassword);
                session.setAttribute("mensajeExito", "¡Empleado registrado con éxito! Se han enviado sus credenciales de acceso a " + correo);
            } else {
                session.setAttribute("mensajeError", "No se pudo registrar el empleado en la base de datos.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/empleados");
    }

    private void cambiarEstadoEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        String idUsuarioStr = request.getParameter("idUsuario");
        String nuevoEstadoStr = request.getParameter("nuevoEstado");

        if (idUsuarioStr != null && nuevoEstadoStr != null) {
            try {
                Long idUsuario = Long.parseLong(idUsuarioStr);
                boolean nuevoEstado = Boolean.parseBoolean(nuevoEstadoStr);

                boolean actualizado = usuarioDao.cambiarEstado(idUsuario, nuevoEstado);
                if (actualizado) {
                    session.setAttribute("mensajeExito", "El estado del empleado fue actualizado correctamente.");
                } else {
                    session.setAttribute("mensajeError", "No se pudo actualizar el estado del empleado.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("mensajeError", "ID de usuario inválido.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/empleados");
    }

    private void enviarCorreoCredenciales(String nombre, String correoDestino, String password) {
        new Thread(() -> {
            try {
                String asunto = "FinTech Corp - Credenciales de Acceso Institucional";
                String mensajeHtml =
                        "<!DOCTYPE html>" +
                                "<html>" +
                                "<head><meta charset='UTF-8'></head>" +
                                "<body style='font-family: Arial, sans-serif; background-color: #0c0e12; color: #E2E2E8; padding: 20px;'>" +
                                "<div style='max-width: 600px; margin: 0 auto; background-color: #14161c; border: 1px solid rgba(0, 242, 255, 0.2); border-radius: 12px; padding: 30px;'>" +
                                "  <h1 style='color: #00DBE7; margin-bottom: 5px; font-size: 24px;'>FinTech Corp</h1>" +
                                "  <div style='color: #B9CACB; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 25px;'>Banca Institucional</div>" +
                                "  <h2 style='color: #FFFFFF; font-size: 18px;'>¡Bienvenido al equipo, " + nombre + "!</h2>" +
                                "  <p style='color: #B9CACB; font-size: 14px; line-height: 1.6;'>Se ha generado tu cuenta institucional en nuestra plataforma corporativa. A continuación se presentan tus credenciales de acceso temporal:</p>" +
                                "  <div style='background-color: #0d0f14; border-left: 4px solid #00DBE7; padding: 15px; border-radius: 6px; margin: 20px 0;'>" +
                                "    <p style='margin: 5px 0; color: #E2E2E8;'><strong>Correo electrónico:</strong> <span style='color: #00DBE7;'>" + correoDestino + "</span></p>" +
                                "    <p style='margin: 5px 0; color: #E2E2E8;'><strong>Contraseña temporal:</strong> <code style='background: #1e2024; color: #00DBE7; padding: 4px 8px; border-radius: 4px; font-size: 15px; font-weight: bold;'>" + password + "</code></p>" +
                                "  </div>" +
                                "  <p style='color: #bfdbfe; font-size: 13px; background-color: #0c1a26; padding: 12px; border-radius: 6px; border: 1px solid #1e3a5f;'>" +
                                "    <strong>Importante:</strong> Al ingresar por primera vez, el sistema te solicitará cambiar tu contraseña por una contraseña personalizada." +
                                "  </p>" +
                                "  <hr style='border: none; border-top: 1px solid rgba(255,255,255,0.1); margin: 25px 0;'>" +
                                "  <p style='color: #64748B; font-size: 11px; text-align: center; margin: 0;'>Este es un mensaje automático generado por FinTech Corp. Por favor no respondas a este correo.</p>" +
                                "</div>" +
                                "</body>" +
                                "</html>";

                EmailSender.sendMail(correoDestino, asunto, mensajeHtml);
            } catch (Exception e) {
                System.err.println("No se pudo enviar el correo de notificación al empleado: " + e.getMessage());
            }
        }).start();
    }

    private void cargarDatosEmpleado(HttpServletRequest request) {
        List<Usuario> listaEmpleados = usuarioDao.getTodosLosEmpleados();
        List<Departamento> deptos = departamentoDao.getAll();

        int totalEmpleados = listaEmpleados.size();
        long activosCount = listaEmpleados.stream().filter(Usuario::isActivo).count();
        int deptosCount = deptos.size();

        Calendar calNow = Calendar.getInstance();
        int currentMonth = calNow.get(Calendar.MONTH);
        int currentYear = calNow.get(Calendar.YEAR);

        long nuevosMesCount = listaEmpleados.stream().filter(u -> {
            if (u.getFechaCreacion() == null) return false;
            Calendar cal = Calendar.getInstance();
            cal.setTime(u.getFechaCreacion());
            return cal.get(Calendar.MONTH) == currentMonth && cal.get(Calendar.YEAR) == currentYear;
        }).count();

        request.setAttribute("listaEmpleados", listaEmpleados);
        request.setAttribute("totalEmpleados", totalEmpleados);
        request.setAttribute("activosCount", activosCount);
        request.setAttribute("deptosCount", deptosCount);
        request.setAttribute("nuevosMesCount", nuevosMesCount);
    }
}
