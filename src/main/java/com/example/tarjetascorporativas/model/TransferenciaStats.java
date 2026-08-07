package com.example.tarjetascorporativas.model;

import java.math.BigDecimal;

public class TransferenciaStats {
    private final long       totalMes;
    private final BigDecimal enviado;
    private final BigDecimal recibido;
    private final BigDecimal neto;

    public TransferenciaStats(long totalMes, BigDecimal enviado, BigDecimal recibido) {
        this.totalMes = totalMes;
        this.enviado  = enviado;
        this.recibido = recibido;
        this.neto     = recibido.subtract(enviado);
    }

    public long       getTotalMes() { return totalMes; }
    public BigDecimal getEnviado()  { return enviado; }
    public BigDecimal getRecibido() { return recibido; }
    public BigDecimal getNeto()     { return neto; }
}
