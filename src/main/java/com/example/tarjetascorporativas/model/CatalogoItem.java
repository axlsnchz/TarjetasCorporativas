package com.example.tarjetascorporativas.model;

public class CatalogoItem {
    private final long   id;
    private final String nombre;

    public CatalogoItem(long id, String nombre) {
        this.id     = id;
        this.nombre = nombre;
    }

    public long   getId()     { return id; }
    public String getNombre() { return nombre; }
}
