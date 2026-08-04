package com.example.tarjetascorporativas.model;

import java.math.BigDecimal;

public class AdminDashboardStats {
    private final BigDecimal saldoGlobal;
    private final long       cuentasActivas;
    private final long       tarjetasEmitidas;
    private final long       empleadosActivos;
    private final BigDecimal transferidoMes;

    public AdminDashboardStats(BigDecimal saldoGlobal, long cuentasActivas,
                                  long tarjetasEmitidas, long empleadosActivos,
                                  BigDecimal transferidoMes) {
        this.saldoGlobal      = saldoGlobal;
        this.cuentasActivas   = cuentasActivas;
        this.tarjetasEmitidas = tarjetasEmitidas;
        this.empleadosActivos = empleadosActivos;
        this.transferidoMes   = transferidoMes;
    }

    public BigDecimal getSaldoGlobal()      { return saldoGlobal; }
    public long       getCuentasActivas()   { return cuentasActivas; }
    public long       getTarjetasEmitidas() { return tarjetasEmitidas; }
    public long       getEmpleadosActivos() { return empleadosActivos; }
    public BigDecimal getTransferidoMes()   { return transferidoMes; }
}
