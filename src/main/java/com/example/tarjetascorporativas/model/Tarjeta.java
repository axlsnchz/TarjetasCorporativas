package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Tarjeta implements Serializable {
    private Long idTarjeta;
    private String numeroTarjeta;
    private String alias;
    private String fechaExpiracion;
    private String cvv;
    private String tipoTarjeta; // "FISICA" o "DIGITAL"
    private Long idCuenta;
    private boolean activo;
    private Timestamp fechaCreacion;

    // Campos auxiliares / relaciones para Vistas y DTOs
    private String numeroCuenta;
    private String nombreEmpleado;
    private String nombreCargo;
    private String nombreDepartamento;
    private String nombreCuenta;
    private Long idEmpleado;

    public Tarjeta() {
    }

    public Tarjeta(Long idTarjeta, String numeroTarjeta, String fechaExpiracion, String cvv, String tipoTarjeta, Long idCuenta, boolean activo) {
        this.idTarjeta = idTarjeta;
        this.numeroTarjeta = numeroTarjeta;
        this.fechaExpiracion = fechaExpiracion;
        this.cvv = cvv;
        this.tipoTarjeta = tipoTarjeta;
        this.idCuenta = idCuenta;
        this.activo = activo;
    }

    public Tarjeta(Long idTarjeta, String numeroTarjeta, String alias, String fechaExpiracion, String cvv, String tipoTarjeta, Long idCuenta, boolean activo, Timestamp fechaCreacion) {
        this.idTarjeta = idTarjeta;
        this.numeroTarjeta = numeroTarjeta;
        this.alias = alias;
        this.fechaExpiracion = fechaExpiracion;
        this.cvv = cvv;
        this.tipoTarjeta = tipoTarjeta;
        this.idCuenta = idCuenta;
        this.activo = activo;
        this.fechaCreacion = fechaCreacion;
    }

    public Long getIdTarjeta() {
        return idTarjeta;
    }

    public void setIdTarjeta(Long idTarjeta) {
        this.idTarjeta = idTarjeta;
    }

    public String getNumeroTarjeta() {
        return numeroTarjeta;
    }

    public void setNumeroTarjeta(String numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getFechaExpiracion() {
        return fechaExpiracion;
    }

    public void setFechaExpiracion(String fechaExpiracion) {
        this.fechaExpiracion = fechaExpiracion;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getTipoTarjeta() {
        return tipoTarjeta;
    }

    public void setTipoTarjeta(String tipoTarjeta) {
        this.tipoTarjeta = tipoTarjeta;
    }

    public Long getIdCuenta() {
        return idCuenta;
    }

    public void setIdCuenta(Long idCuenta) {
        this.idCuenta = idCuenta;
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

    public String getNumeroCuenta() {
        return numeroCuenta;
    }

    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public String getNombreEmpleado() {
        return nombreEmpleado;
    }

    public void setNombreEmpleado(String nombreEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
    }

    public String getNombreCargo() {
        return nombreCargo;
    }

    public void setNombreCargo(String nombreCargo) {
        this.nombreCargo = nombreCargo;
    }

    public String getNombreDepartamento() {
        return nombreDepartamento;
    }

    public void setNombreDepartamento(String nombreDepartamento) {
        this.nombreDepartamento = nombreDepartamento;
    }

    public String getNombreCuenta() {
        return nombreCuenta;
    }

    public void setNombreCuenta(String nombreCuenta) {
        this.nombreCuenta = nombreCuenta;
    }

    public Long getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(Long idEmpleado) {
        this.idEmpleado = idEmpleado;
    }
}
