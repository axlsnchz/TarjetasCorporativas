package com.example.tarjetascorporativas.controller.filters;

import com.example.tarjetascorporativas.model.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class FiltroAutenticacion implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización si es necesaria
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Evaluar si es un recurso público exento de autenticación
        boolean esRecursoPublico = isPublicResource(path);

        HttpSession session = httpRequest.getSession(false);
        boolean logueado = (session != null && session.getAttribute("usuarioLogueado") != null);

        if (logueado || esRecursoPublico) {
            // Si está logueado, validar control de acceso por rol (ADMINISTRADOR vs EMPLEADO)
            if (logueado && !esRecursoPublico) {
                Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
                
                // Si un Empleado intenta acceder a rutas de administración /admin/*
                if ("EMPLEADO".equalsIgnoreCase(usuario.getRol()) && path.startsWith("/admin/")) {
                    httpResponse.sendRedirect(contextPath + "/usuario/principal-usuario.jsp");
                    return;
                }

                // Si un Administrador intenta acceder a rutas de usuario /usuario/*
                if ("ADMINISTRADOR".equalsIgnoreCase(usuario.getRol()) && path.startsWith("/usuario/")) {
                    httpResponse.sendRedirect(contextPath + "/admin/principal-admin.jsp");
                    return;
                }
            }

            chain.doFilter(request, response);
        } else {
            // Usuario no autenticado intentando acceder a ruta protegida -> Redirigir a login.jsp
            httpResponse.sendRedirect(contextPath + "/login.jsp");
        }
    }

    private boolean isPublicResource(String path) {
        if (path == null || path.isEmpty() || "/".equals(path)) {
            return true;
        }

        // Páginas públicas permitidas
        if (path.equals("/login") ||
            path.equals("/login.jsp") ||
            path.equals("/recuperar-password") ||
            path.equals("/recucontrasena.jsp") ||
            path.equals("/index.jsp")) {
            return true;
        }

        // Recursos estáticos (assets, css, js, icons, etc.)
        return path.startsWith("/assets/") ||
               path.startsWith("/css/") ||
               path.startsWith("/js/") ||
               path.startsWith("/icons/") ||
               path.startsWith("/favicon.ico");
    }

    @Override
    public void destroy() {
        // Limpieza si es necesaria
    }
}
