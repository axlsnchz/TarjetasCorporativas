package com.example.tarjetascorporativas.model;

import java.sql.Timestamp;

public class Admin extends Usuario {
    public Admin() {
        super();
        setRol("ADMINISTRADOR");
    }

    public Admin(Long idUsuario, String nombre, String correo, String password, boolean primerInicio, boolean activo, String codigoRecuperacion) {
        super(idUsuario, nombre, correo, password, "ADMINISTRADOR", primerInicio, activo, codigoRecuperacion);
    }

    public Admin(Long idUsuario, String nombre, String correo, String password, Long idDepartamento, Long idCargo, boolean primerInicio, boolean activo, String codigoRecuperacion, Timestamp fechaCreacion) {
        super(idUsuario, nombre, correo, password, "ADMINISTRADOR", idDepartamento, idCargo, primerInicio, activo, codigoRecuperacion, fechaCreacion);
    }
}
