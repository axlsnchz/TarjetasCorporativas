package com.example.tarjetascorporativas.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class TransferenciaHistorial {
    private final BigDecimal monto;
    private final String     concepto;
    private final String     referencia;
    private final Timestamp  fecha;
    private final String     estado;
    private final String     origenNum;
    private final String     destinoNum;
    private final String     origenTitular;
    private final String     destinoTitular;
    private final String     tipo;

    public TransferenciaHistorial(BigDecimal monto, String concepto, String referencia,
                                     Timestamp fecha, String estado,
                                     String origenNum, String destinoNum,
                                     String origenTitular, String destinoTitular, String tipo) {
        this.monto          = monto;
        this.concepto       = concepto;
        this.referencia     = referencia;
        this.fecha          = fecha;
        this.estado         = estado;
        this.origenNum      = origenNum;
        this.destinoNum     = destinoNum;
        this.origenTitular  = origenTitular;
        this.destinoTitular = destinoTitular;
        this.tipo           = tipo;
    }

    public BigDecimal getMonto()          { return monto; }
    public String     getConcepto()       { return concepto; }
    public String     getReferencia()     { return referencia; }
    public Timestamp  getFecha()          { return fecha; }
    public String     getEstado()         { return estado; }
    public String     getOrigenNum()      { return origenNum; }
    public String     getDestinoNum()     { return destinoNum; }
    public String     getOrigenTitular()  { return origenTitular; }
    public String     getDestinoTitular() { return destinoTitular; }
    public String     getTipo()           { return tipo; }
}
