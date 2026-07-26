package com.example.tarjetascorporativas.controller;

import com.example.tarjetascorporativas.model.Tarjeta;
import com.example.tarjetascorporativas.model.Usuario;
import com.example.tarjetascorporativas.model.dao.TarjetaDao;
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

@WebServlet(name = "TarjetaUsuarioServlet", value = "/empleado/tarjetas")
public class TarjetaUsuarioServlet extends HttpServlet {

    private final TarjetaDao tarjetaDao = new TarjetaDao();
    private final UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuarioLogueado = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        List<Tarjeta> listaTarjetas = new ArrayList<>();
        if (usuarioLogueado != null) {
            listaTarjetas = tarjetaDao.getByEmpleadoId(usuarioLogueado.getIdUsuario());
        } else {
            // Fallback para pruebas si no hay usuario en sesión
            List<Usuario> empleados = usuarioDao.getEmpleados();
            if (!empleados.isEmpty()) {
                listaTarjetas = tarjetaDao.getByEmpleadoId(empleados.get(0).getIdUsuario());
            }
        }

        request.setAttribute("listaTarjetas", listaTarjetas);
        request.getRequestDispatcher("/empleado/gestion-tarjetas-usuario.jsp").forward(request, response);
    }
}
