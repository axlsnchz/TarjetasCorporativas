package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Cuenta implements Serializable {
    private Long idCuenta;
    private String numeroCuenta;
    private Long idEmpleado; // null para la Cuenta Conservadora Principal
    private String nombreCuenta;
    private String descripcion;
    private BigDecimal saldo;
    private BigDecimal limiteAsignado;
    private boolean activo;
    private Timestamp fechaCreacion;

    // Campos auxiliares / relaciones para Vistas y DTOs
    private String nombreEmpleado;

    public Cuenta() {
    }

    public Cuenta(Long idCuenta, String numeroCuenta, Long idEmpleado, BigDecimal saldo, boolean activo) {
        this.idCuenta = idCuenta;
        this.numeroCuenta = numeroCuenta;
        this.idEmpleado = idEmpleado;
        this.saldo = saldo;
        this.activo = activo;
    }

    public Cuenta(Long idCuenta, String numeroCuenta, Long idEmpleado, String nombreCuenta, String descripcion, BigDecimal saldo, BigDecimal limiteAsignado, boolean activo, Timestamp fechaCreacion) {
        this.idCuenta = idCuenta;
        this.numeroCuenta = numeroCuenta;
        this.idEmpleado = idEmpleado;
        this.nombreCuenta = nombreCuenta;
        this.descripcion = descripcion;
        this.saldo = saldo;
        this.limiteAsignado = limiteAsignado;
        this.activo = activo;
        this.fechaCreacion = fechaCreacion;
    }

    public Long getIdCuenta() {
        return idCuenta;
    }

    public void setIdCuenta(Long idCuenta) {
        this.idCuenta = idCuenta;
    }

    public String getNumeroCuenta() {
        return numeroCuenta;
    }

    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public Long getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(Long idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public String getNombreCuenta() {
        return nombreCuenta;
    }

    public void setNombreCuenta(String nombreCuenta) {
        this.nombreCuenta = nombreCuenta;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigDecimal getSaldo() {
        return saldo;
    }

    public void setSaldo(BigDecimal saldo) {
        this.saldo = saldo;
    }

    public BigDecimal getLimiteAsignado() {
        return limiteAsignado;
    }

    public void setLimiteAsignado(BigDecimal limiteAsignado) {
        this.limiteAsignado = limiteAsignado;
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

    public String getNombreEmpleado() {
        return nombreEmpleado;
    }

    public void setNombreEmpleado(String nombreEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
    }
}

