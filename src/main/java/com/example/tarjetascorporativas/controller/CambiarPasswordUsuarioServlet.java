package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.model.dao.UsuarioDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "CambiarPasswordUsuarioServlet", value = "/empleado/cambiar-password")
public class CambiarPasswordUsuarioServlet extends HttpServlet {

    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuarioLogueado = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String passActual = request.getParameter("passActual");
        String nuevaPassword = request.getParameter("nuevaPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (passActual != null) passActual = passActual.trim();
        if (nuevaPassword != null) nuevaPassword = nuevaPassword.trim();
        if (confirmPassword != null) confirmPassword = confirmPassword.trim();

        if (passActual == null || passActual.isEmpty() ||
            nuevaPassword == null || nuevaPassword.isEmpty() ||
            confirmPassword == null || confirmPassword.isEmpty()) {

            session.setAttribute("mensajeError", "Todos los campos de contraseña son obligatorios.");
            response.sendRedirect(request.getContextPath() + "/empleado/configuracion-usuario.jsp");
            return;
        }

        // 1. Validar que la contraseña actual ingresada coincida con la del usuario logueado en BD
        Usuario usuarioBD = usuarioDao.login(usuarioLogueado.getCorreo(), passActual);
        if (usuarioBD == null) {
            session.setAttribute("mensajeError", "La contraseña actual ingresada es incorrecta.");
            response.sendRedirect(request.getContextPath() + "/empleado/configuracion-usuario.jsp");
            return;
        }

        // 2. Validar que las nuevas contraseñas coincidan
        if (!nuevaPassword.equals(confirmPassword)) {
            session.setAttribute("mensajeError", "La nueva contraseña y su confirmación no coinciden.");
            response.sendRedirect(request.getContextPath() + "/empleado/configuracion-usuario.jsp");
            return;
        }

        // 3. Validar políticas de contraseña (mínimo 8 caracteres, al menos 1 letra y 1 número)
        if (nuevaPassword.length() < 8 || !nuevaPassword.matches(".*[a-zA-Z].*") || !nuevaPassword.matches(".*[0-9].*")) {
            session.setAttribute("mensajeError", "La nueva contraseña debe tener al menos 8 caracteres, incluir al menos 1 letra y 1 número.");
            response.sendRedirect(request.getContextPath() + "/empleado/configuracion-usuario.jsp");
            return;
        }

        // 4. Actualizar contraseña en BD
        boolean exito = usuarioDao.actualizarPassword(usuarioLogueado.getIdUsuario(), nuevaPassword, false);
        if (exito) {
            usuarioLogueado.setPassword(nuevaPassword);
            session.setAttribute("usuarioLogueado", usuarioLogueado);
            session.setAttribute("mensajeExito", "¡Tu contraseña ha sido actualizada exitosamente!");
        } else {
            session.setAttribute("mensajeError", "Ocurrió un error al actualizar la contraseña en la base de datos.");
        }

        response.sendRedirect(request.getContextPath() + "/empleado/configuracion-usuario.jsp");
    }
}
