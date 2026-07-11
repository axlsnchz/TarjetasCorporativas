package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Movimiento implements Serializable {
    private Long idMovimiento;
    private Long idCuentaOrigen;
    private Long idCuentaDestino;
    private BigDecimal monto;
    private String tipoMovimiento; // "TRANSFERENCIA", "DEPOSITO_INICIAL", "REINTEGRO_CONSERVADORA"
    private String estado; // "COMPLETADO", "FALLIDO"
    private Timestamp fechaMovimiento;
    private String descripcion;

    // Campos auxiliares para Vistas
    private String numeroCuentaOrigen;
    private String numeroCuentaDestino;

    public Movimiento() {
    }

    public Movimiento(Long idMovimiento, Long idCuentaOrigen, Long idCuentaDestino, BigDecimal monto, String tipoMovimiento, Timestamp fechaMovimiento, String descripcion) {
        this.idMovimiento = idMovimiento;
        this.idCuentaOrigen = idCuentaOrigen;
        this.idCuentaDestino = idCuentaDestino;
        this.monto = monto;
        this.tipoMovimiento = tipoMovimiento;
        this.fechaMovimiento = fechaMovimiento;
        this.descripcion = descripcion;
        this.estado = "COMPLETADO";
    }

    public Movimiento(Long idMovimiento, Long idCuentaOrigen, Long idCuentaDestino, BigDecimal monto, String tipoMovimiento, String estado, Timestamp fechaMovimiento, String descripcion) {
        this.idMovimiento = idMovimiento;
        this.idCuentaOrigen = idCuentaOrigen;
        this.idCuentaDestino = idCuentaDestino;
        this.monto = monto;
        this.tipoMovimiento = tipoMovimiento;
        this.estado = estado;
        this.fechaMovimiento = fechaMovimiento;
        this.descripcion = descripcion;
    }

    public Long getIdMovimiento() {
        return idMovimiento;
    }

    public void setIdMovimiento(Long idMovimiento) {
        this.idMovimiento = idMovimiento;
    }

    public Long getIdCuentaOrigen() {
        return idCuentaOrigen;
    }

    public void setIdCuentaOrigen(Long idCuentaOrigen) {
        this.idCuentaOrigen = idCuentaOrigen;
    }

    public Long getIdCuentaDestino() {
        return idCuentaDestino;
    }

    public void setIdCuentaDestino(Long idCuentaDestino) {
        this.idCuentaDestino = idCuentaDestino;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public String getTipoMovimiento() {
        return tipoMovimiento;
    }

    public void setTipoMovimiento(String tipoMovimiento) {
        this.tipoMovimiento = tipoMovimiento;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Timestamp getFechaMovimiento() {
        return fechaMovimiento;
    }

    public void setFechaMovimiento(Timestamp fechaMovimiento) {
        this.fechaMovimiento = fechaMovimiento;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getNumeroCuentaOrigen() {
        return numeroCuentaOrigen;
    }

    public void setNumeroCuentaOrigen(String numeroCuentaOrigen) {
        this.numeroCuentaOrigen = numeroCuentaOrigen;
    }

    public String getNumeroCuentaDestino() {
        return numeroCuentaDestino;
    }

    public void setNumeroCuentaDestino(String numeroCuentaDestino) {
        this.numeroCuentaDestino = numeroCuentaDestino;
    }
}
