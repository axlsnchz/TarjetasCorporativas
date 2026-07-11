package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Cargo implements Serializable {
    private Long idCargo;
    private String nombre;
    private Timestamp fechaCreacion;

    public Cargo() {
    }

    public Cargo(String nombre) {
        this.nombre = nombre;
    }

    public Cargo(Long idCargo, String nombre, Timestamp fechaCreacion) {
        this.idCargo = idCargo;
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
    }

    public Long getIdCargo() {
        return idCargo;
    }

    public void setIdCargo(Long idCargo) {
        this.idCargo = idCargo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
}
