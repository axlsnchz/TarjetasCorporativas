package com.example.tarjetascorporativas.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.tarjetas_corporativas.exception.ServiceException;
import org.example.tarjetas_corporativas.model.CuentaUser;
import org.example.tarjetas_corporativas.service.DashboardUserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "userDashboardServlet", urlPatterns = {"/user/dashboard"})
public class UserDashboardServlet extends HttpServlet {

    private final DashboardUserService dashboardService = new DashboardUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long usuarioId = (Long) request.getSession().getAttribute("usuarioId");
        if (usuarioId == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }

        try {
            List<CuentaUser> cuentas = dashboardService.getCuentas(usuarioId);
            request.setAttribute("cuentas",     cuentas);
            request.setAttribute("saldoTotal",  dashboardService.getSaldoTotal(cuentas));
            request.setAttribute("movimientos", dashboardService.getMovimientosRecientes(usuarioId, 5));
        } catch (ServiceException e) {
            throw new ServletException(e.getMessage(), e);
        }
        request.getRequestDispatcher("/WEB-INF/jsp/user/dashboard.jsp").forward(request, response);
    }
}
