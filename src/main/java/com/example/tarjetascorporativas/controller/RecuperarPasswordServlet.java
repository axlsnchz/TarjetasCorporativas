package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.dao.UsuarioDao;
import com.example.tarjetascorporativas.utils.EmailSender;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.SecureRandom;

@WebServlet(name = "RecuperarPasswordServlet", value = "/recuperar-password")
public class RecuperarPasswordServlet extends HttpServlet {

    private final UsuarioDao usuarioDao = new UsuarioDao();
    private static final String ALPHA_NUMERIC = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("cambiar_password".equalsIgnoreCase(accion)) {
            procesarCambioPassword(request, response);
        } else {
            procesarSolicitudCodigo(request, response);
        }
    }

    private void procesarSolicitudCodigo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        if (correo != null) correo = correo.trim();

        if (correo == null || correo.isEmpty()) {
            request.setAttribute("error", "Por favor, ingrese un correo electrónico válido.");
            request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
            return;
        }

        Usuario usuario = usuarioDao.getByCorreo(correo);

        if (usuario == null || !usuario.isActivo()) {
            request.setAttribute("error", "El correo ingresado no se encuentra registrado o el usuario está inactivo.");
            request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
            return;
        }

        // Generar código aleatorio único y no repetible
        String codigo = generarCodigoUnico();
        usuarioDao.guardarCodigoRecuperacion(correo, codigo);

        // Formatear correo electrónico en HTML
        String asunto = "Código de Recuperación - FinTech Corp";
        String mensajeHtml = String.format(
                "<div style=\"font-family: 'Segoe UI', Arial, sans-serif; background-color: #0c0e12; color: #ffffff; padding: 30px; border-radius: 12px; max-width: 550px; margin: auto;\">" +
                "  <div style=\"text-align: center; margin-bottom: 25px;\">" +
                "    <h1 style=\"color: #00dbe7; margin: 0; font-size: 24px;\">FinTech Corp</h1>" +
                "    <p style=\"color: #b9cacb; font-size: 13px; margin-top: 4px;\">Banca Institucional</p>" +
                "  </div>" +
                "  <p style=\"font-size: 15px; color: #e0e0e0;\">Hola <strong>%s</strong>,</p>" +
                "  <p style=\"font-size: 14px; color: #b9cacb; line-height: 1.5;\">Hemos recibido una solicitud para restablecer la contraseña de tu cuenta. Utiliza el siguiente código de verificación de seguridad:</p>" +
                "  <div style=\"background-color: #111318; border: 2px dashed #00dbe7; color: #00dbe7; font-size: 30px; font-weight: bold; letter-spacing: 6px; text-align: center; padding: 18px; margin: 25px 0; border-radius: 8px;\">%s</div>" +
                "  <p style=\"font-size: 13px; color: #b9cacb;\">Este código es de uso único e intransferible. Si no solicitaste este cambio, puedes ignorar este mensaje.</p>" +
                "  <hr style=\"border: none; border-top: 1px solid #3a494b; margin: 30px 0 15px 0;\" />" +
                "  <p style=\"color: #64748b; font-size: 11px; text-align: center; margin: 0;\">FinTech Corp &copy; 2026 - Sistema de Gestión Empresarial</p>" +
                "</div>",
                usuario.getNombre(), codigo
        );

        try {
            EmailSender.sendMail(correo, asunto, mensajeHtml);
            request.setAttribute("paso", "validar");
            request.setAttribute("correo", correo);
            request.setAttribute("mensajeExito", "Hemos enviado un código de verificación a tu correo electrónico.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error al enviar el correo. Por favor intenta más tarde: " + e.getMessage());
        }

        request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
    }

    private void procesarCambioPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String codigo = request.getParameter("codigo");
        String nuevaPassword = request.getParameter("nuevaPassword");
        String confirmarPassword = request.getParameter("confirmarPassword");

        if (correo != null) correo = correo.trim();
        if (codigo != null) codigo = codigo.trim().toUpperCase();

        if (codigo == null || codigo.isEmpty() || nuevaPassword == null || nuevaPassword.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.setAttribute("paso", "validar");
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
            return;
        }

        if (!nuevaPassword.equals(confirmarPassword)) {
            request.setAttribute("error", "Las contraseñas ingresadas no coinciden.");
            request.setAttribute("paso", "validar");
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
            return;
        }

        // Validación de formato de clave segura (mínimo 8 caracteres, 1 letra, 1 número)
        if (nuevaPassword.length() < 8 || !nuevaPassword.matches(".*[a-zA-Z].*") || !nuevaPassword.matches(".*[0-9].*")) {
            request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres, incluir al menos 1 letra y 1 número.");
            request.setAttribute("paso", "validar");
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
            return;
        }

        // Validar código contra la base de datos
        Usuario usuario = usuarioDao.getByCodigoRecuperacion(codigo);

        if (usuario == null || !usuario.getCorreo().equalsIgnoreCase(correo)) {
            request.setAttribute("error", "El código de verificación ingresado es incorrecto o ha expirado.");
            request.setAttribute("paso", "validar");
            request.setAttribute("correo", correo);
            request.getRequestDispatcher("/recucontrasena.jsp").forward(request, response);
            return;
        }

        // Actualización de contraseña y limpieza de código
        usuarioDao.actualizarPassword(usuario.getIdUsuario(), nuevaPassword, false);
        usuarioDao.guardarCodigoRecuperacion(correo, null);

        request.setAttribute("exito", "¡Tu contraseña ha sido actualizada con éxito! Por favor inicia sesión.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private String generarCodigoUnico() {
        String codigo;
        do {
            StringBuilder sb = new StringBuilder(6);
            for (int i = 0; i < 6; i++) {
                sb.append(ALPHA_NUMERIC.charAt(RANDOM.nextInt(ALPHA_NUMERIC.length())));
            }
            codigo = sb.toString();
        } while (usuarioDao.getByCodigoRecuperacion(codigo) != null);

        return codigo;
    }
}
