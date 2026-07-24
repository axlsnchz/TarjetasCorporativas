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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CuentaUsuarioServlet", value = "/empleado/cuentas")
public class CuentaUsuarioServlet extends HttpServlet {

    private final CuentaDao cuentaDao = new CuentaDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuarioLogueado = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        List<Cuenta> listaCuentas = new ArrayList<>();
        if (usuarioLogueado != null) {
            listaCuentas = cuentaDao.getByEmpleadoId(usuarioLogueado.getIdUsuario());
        } else {
            // Fallback para pruebas si no hay usuario en sesión
            List<Usuario> empleados = usuarioDao.getEmpleados();
            if (!empleados.isEmpty()) {
                listaCuentas = cuentaDao.getByEmpleadoId(empleados.get(0).getIdUsuario());
            }
        }

        request.setAttribute("listaCuentas", listaCuentas);
        request.getRequestDispatcher("/empleado/gestion-cuentas-usuario.jsp").forward(request, response);
    }
}
