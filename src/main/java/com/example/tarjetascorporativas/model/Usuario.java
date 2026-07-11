package com.example.tarjetascorporativas.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Usuario implements Serializable {
    private Long idUsuario;
    private String nombre;
    private String correo;
    private String password;
    private String rol; // "ADMINISTRADOR" o "EMPLEADO"
    private Long idDepartamento; // FK DEPARTAMENTOS
    private Long idCargo;        // FK CARGOS
    private boolean primerInicio;
    private boolean activo;
    private String codigoRecuperacion;
    private Timestamp fechaCreacion;

    // Campos auxiliares / relaciones para Vistas y DTOs
    private String nombreDepartamento;
    private String nombreCargo;

    public Usuario() {
    }

    public Usuario(Long idUsuario, String nombre, String correo, String password, String rol, boolean primerInicio, boolean activo, String codigoRecuperacion) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.password = password;
        this.rol = rol;
        this.primerInicio = primerInicio;
        this.activo = activo;
        this.codigoRecuperacion = codigoRecuperacion;
    }

    public Usuario(Long idUsuario, String nombre, String correo, String password, String rol, Long idDepartamento, Long idCargo, boolean primerInicio, boolean activo, String codigoRecuperacion, Timestamp fechaCreacion) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.password = password;
        this.rol = rol;
        this.idDepartamento = idDepartamento;
        this.idCargo = idCargo;
        this.primerInicio = primerInicio;
        this.activo = activo;
        this.codigoRecuperacion = codigoRecuperacion;
        this.fechaCreacion = fechaCreacion;
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Long getIdDepartamento() {
        return idDepartamento;
    }

    public void setIdDepartamento(Long idDepartamento) {
        this.idDepartamento = idDepartamento;
    }

    public Long getIdCargo() {
        return idCargo;
    }

    public void setIdCargo(Long idCargo) {
        this.idCargo = idCargo;
    }

    public boolean isPrimerInicio() {
        return primerInicio;
    }

    public void setPrimerInicio(boolean primerInicio) {
        this.primerInicio = primerInicio;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public String getCodigoRecuperacion() {
        return codigoRecuperacion;
    }

    public void setCodigoRecuperacion(String codigoRecuperacion) {
        this.codigoRecuperacion = codigoRecuperacion;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public String getNombreDepartamento() {
        return nombreDepartamento;
    }

    public void setNombreDepartamento(String nombreDepartamento) {
        this.nombreDepartamento = nombreDepartamento;
    }

    public String getNombreCargo() {
        return nombreCargo;
    }

    public void setNombreCargo(String nombreCargo) {
        this.nombreCargo = nombreCargo;
    }
}
