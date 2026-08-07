package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.dao.UsuarioDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // 1. Cierre de Sesión (Logout)
        if ("logout".equalsIgnoreCase(accion)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Si ya existe una sesión activa con usuarioLogueado, redirigir a su panel
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
            redirigirSegunRol(usuario, request, response);
            return;
        }

        // 3. Si no hay sesión, mostrar la vista de login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        if (correo != null) correo = correo.trim();
        if (password != null) password = password.trim();

        if (correo == null || correo.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Por favor, ingrese su correo y contraseña.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Autenticar credenciales mediante UsuarioDao
        Usuario usuario = usuarioDao.login(correo, password);

        if (usuario != null) {
            // Credenciales válidas: Guardar en sesión
            HttpSession session = request.getSession(true);
            session.setAttribute("usuarioLogueado", usuario);

            redirigirSegunRol(usuario, request, response);
        } else {
            // Credenciales inválidas
            request.setAttribute("error", "Correo o contraseña incorrectos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void redirigirSegunRol(Usuario usuario, HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if ("ADMINISTRADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/admin/principal-admin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/empleado/principal-usuario.jsp");
        }
    }
}
