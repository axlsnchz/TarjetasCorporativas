package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class TipoCuenta implements Serializable {
    private Long idTipoCuenta;
    private String nombre;
    private String descripcion;
    private boolean esConservadora;
    private boolean activo;
    private Timestamp fechaCreacion;

    public TipoCuenta() {
    }

    public TipoCuenta(Long idTipoCuenta, String nombre, String descripcion, boolean esConservadora, boolean activo) {
        this.idTipoCuenta = idTipoCuenta;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.esConservadora = esConservadora;
        this.activo = activo;
    }

    public TipoCuenta(Long idTipoCuenta, String nombre, String descripcion, boolean esConservadora, boolean activo, Timestamp fechaCreacion) {
        this.idTipoCuenta = idTipoCuenta;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.esConservadora = esConservadora;
        this.activo = activo;
        this.fechaCreacion = fechaCreacion;
    }

    public Long getIdTipoCuenta() {
        return idTipoCuenta;
    }

    public void setIdTipoCuenta(Long idTipoCuenta) {
        this.idTipoCuenta = idTipoCuenta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean isEsConservadora() {
        return esConservadora;
    }

    public void setEsConservadora(boolean esConservadora) {
        this.esConservadora = esConservadora;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
}
