package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Departamento implements Serializable {
    private Long idDepartamento;
    private String nombre;
    private Timestamp fechaCreacion;

    public Departamento() {
    }

    public Departamento(String nombre) {
        this.nombre = nombre;
    }

    public Departamento(Long idDepartamento, String nombre, Timestamp fechaCreacion) {
        this.idDepartamento = idDepartamento;
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
    }

    public Long getIdDepartamento() {
        return idDepartamento;
    }

    public void setIdDepartamento(Long idDepartamento) {
        this.idDepartamento = idDepartamento;
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
