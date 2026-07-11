package com.example.tarjetascorporativas.model;

import java.sql.Timestamp;

public class Empleado extends Usuario {
    public Empleado() {
        super();
        setRol("EMPLEADO");
    }

    public Empleado(Long idUsuario, String nombre, String correo, String password, boolean primerInicio, boolean activo, String codigoRecuperacion) {
        super(idUsuario, nombre, correo, password, "EMPLEADO", primerInicio, activo, codigoRecuperacion);
    }

    public Empleado(Long idUsuario, String nombre, String correo, String password, Long idDepartamento, Long idCargo, boolean primerInicio, boolean activo, String codigoRecuperacion, Timestamp fechaCreacion) {
        super(idUsuario, nombre, correo, password, "EMPLEADO", idDepartamento, idCargo, primerInicio, activo, codigoRecuperacion, fechaCreacion);
    }
}
