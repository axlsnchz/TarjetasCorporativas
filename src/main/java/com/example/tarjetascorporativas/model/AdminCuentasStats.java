package com.example.tarjetascorporativas.model;

import java.math.BigDecimal;

public class AdminCuentasStats {
    private final long       cuentasActivas;
    private final long       empConCuenta;
    private final BigDecimal totalCirculacion;
    private final long       congeladas;

    public AdminCuentasStats(long cuentasActivas, long empConCuenta,
                                BigDecimal totalCirculacion, long congeladas) {
        this.cuentasActivas   = cuentasActivas;
        this.empConCuenta     = empConCuenta;
        this.totalCirculacion = totalCirculacion;
        this.congeladas       = congeladas;
    }

    public long       getCuentasActivas()   { return cuentasActivas; }
    public long       getEmpConCuenta()     { return empConCuenta; }
    public BigDecimal getTotalCirculacion() { return totalCirculacion; }
    public long       getCongeladas()       { return congeladas; }
}
