<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    // Carga de métricas reales para el Resumen General
    com.example.tarjetascorporativas.model.dao.CuentaDao cDao = new com.example.tarjetascorporativas.model.dao.CuentaDao();
    com.example.tarjetascorporativas.model.dao.TarjetaDao tDao = new com.example.tarjetascorporativas.model.dao.TarjetaDao();
    com.example.tarjetascorporativas.model.dao.MovimientoDao mDao = new com.example.tarjetascorporativas.model.dao.MovimientoDao();

    com.example.tarjetascorporativas.model.Cuenta concentradora = cDao.getCuentaConcentradora();
    java.math.BigDecimal saldoConcentradora = (concentradora != null && concentradora.getSaldo() != null) ? concentradora.getSaldo() : java.math.BigDecimal.ZERO;

    java.util.List<com.example.tarjetascorporativas.model.Cuenta> cuentasEmpleados = cDao.getCuentasEmpleados();
    long cuentasActivas = cuentasEmpleados.stream().filter(com.example.tarjetascorporativas.model.Cuenta::isActivo).count();
    long tarjetasEmitidas = tDao.getAll().size();

    java.math.BigDecimal valorEnTransito = cuentasEmpleados.stream()
            .filter(c -> c.isActivo() && c.getSaldo() != null)
            .map(com.example.tarjetascorporativas.model.Cuenta::getSaldo)
            .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

    java.math.BigDecimal balanceTotalCorporativo = saldoConcentradora.add(valorEnTransito);

    java.util.List<com.example.tarjetascorporativas.model.Movimiento> ultimosMovimientos = mDao.getAll();

    request.setAttribute("saldoConcentradora", saldoConcentradora);
    request.setAttribute("saldoMatriz", saldoConcentradora); // Compatibilidad
    request.setAttribute("cuentasActivasCount", cuentasActivas);
    request.setAttribute("tarjetasEmitidasCount", tarjetasEmitidas);
    request.setAttribute("valorEnTransito", valorEnTransito);
    request.setAttribute("balanceTotalCorporativo", balanceTotalCorporativo);
    request.setAttribute("ultimosMovimientos", ultimosMovimientos);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Resumen General</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons (CDN + Fallback Local) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="${pageContext.request.contextPath}/assets/icons/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #0c0e12;
            font-family: 'Inter', sans-serif;
            color: #E2E2E8;
            min-height: 100vh;
        }
        @media (min-width: 768px) {
            .main-content {
                margin-left: 260px;
            }
        }
        .bg-figma-card {
            background: #14161c;
            border: 1px solid rgba(255, 255, 255, 0.03);
            border-radius: 24px;
        }
        .bg-figma-neon {
            background: #00F2FF;
            border-radius: 24px;
            color: #002022;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .text-muted {
            color: #BAC9CC !important;
        }
        .text-cyan-neon {
            color: #00DBE7 !important;
        }
        .btn-figma-neon {
            background: #00E5FF;
            border-radius: 32px;
            color: #002022;
            font-family: 'Inter', sans-serif;
            font-weight: 700;
            border: 1px solid transparent;
            transition: all 0.2s ease;
            white-space: nowrap;
        }
        .btn-figma-neon:hover {
            background: #00bfe7;
            color: #002022;
            transform: translateY(-1px);
        }
        .btn-outline-figma-neon {
            background: transparent;
            border-radius: 32px;
            color: #00e5ff;
            font-weight: 700;
            border: 1px solid #00e5ff;
            transition: all 0.2s ease;
            white-space: nowrap;
        }
        .btn-outline-figma-neon:hover {
            background: rgba(0, 229, 255, 0.1);
            color: #00e5ff;
        }
        .form-label-figma {
            color: #bac9cc;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 8px;
            display: block;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .form-figma-input {
            background-color: #1e2024 !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: #ffffff !important;
            border-radius: 8px !important;
            padding: 12px 16px !important;
            font-size: 15px !important;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }
        .form-figma-input:focus {
            border-color: #00e5ff !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 229, 255, 0.15) !important;
        }
        .tracking-widest-custom {
            letter-spacing: 0.08rem;
        }
        .backdrop-blur {
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<jsp:include page="sidebar-admin.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-content d-flex flex-column min-vh-100">

    <!-- HEADER SUPERIOR CONTROLADO -->
    <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
            style="height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
        <button class="btn d-md-none text-cyan-neon fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarAdmin" aria-controls="sidebarAdmin" aria-label="Abrir menú">
            <i class="bi bi-list"></i>
        </button>
        <i class="bi bi-person-circle text-cyan-neon fs-3 role-button" style="cursor: pointer;"></i>
    </header>

    <!-- CONTENIDO PRINCIPAL DE LA VISTA -->
    <main class="flex-grow-1 p-4 p-md-5">
        <div class="container-fluid p-0">

            <!-- Alertas de Feedback de Sesión -->
            <c:if test="${not empty sessionScope.mensajeExito}">
                <div class="alert alert-success alert-dismissible fade show border-0 rounded-3 shadow mb-4" style="background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.3) !important; color: #10B981;" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.mensajeExito}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="mensajeExito" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.mensajeError}">
                <div class="alert alert-danger alert-dismissible fade show border-0 rounded-3 shadow mb-4" style="background: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.3) !important; color: #EF4444;" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.mensajeError}
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="mensajeError" scope="session"/>
            </c:if>

            <!-- Fila de Título -->
            <div class="mb-5">
                <h2 class="fw-bold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Resumen General</h2>
                <p class="m-0 mt-2" style="color: #BAC9CC !important; font-weight: 500;">Monitoreo en tiempo real del estado financiero corporativo.</p>
            </div>

            <!-- Bloque de Tarjetas Informativas -->
            <div class="row g-4 mb-5">
                <!-- Balance Corporativo -->
                <div class="col-xl-8 col-12">
                    <div class="p-4 p-md-5 bg-figma-card h-100 d-flex flex-column justify-content-between shadow-sm">
                        <div>
                            <span class="d-block fw-bold tracking-widest-custom mb-3" style="font-size: 0.75rem; color: #BAC9CC !important;">BALANCE TOTAL CORPORATIVO</span>
                            <div class="d-flex align-items-baseline gap-2 mb-4">
                                <h3 class="display-4 fw-bold m-0 text-white">
                                    $<fmt:formatNumber value="${balanceTotalCorporativo}" pattern="#,##0.00"/>
                                </h3>
                                <span class="fs-4 fw-semibold text-cyan-neon">MXN</span>
                            </div>
                        </div>

                        <!-- Sub-métricas horizontales limpias -->
                        <div class="row g-3 pt-3 border-top" style="border-color: rgba(255, 255, 255, 0.04) !important;">
                            <div class="col-4">
                                <span class="d-block text-uppercase fw-bold small tracking-wider mb-1" style="font-size: 0.65rem; color: #BAC9CC !important;">Cuentas Activas</span>
                                <span class="fs-4 fw-bold text-white">${cuentasActivasCount}</span>
                            </div>
                            <div class="col-4">
                                <span class="d-block text-uppercase fw-bold small tracking-wider mb-1" style="font-size: 0.65rem; color: #BAC9CC !important;">Tarjetas Emitidas</span>
                                <span class="fs-4 fw-bold text-white">${tarjetasEmitidasCount}</span>
                            </div>
                            <div class="col-4">
                                <span class="d-block text-uppercase fw-bold small tracking-wider mb-1" style="font-size: 0.65rem; color: #BAC9CC !important;">Valor en Tránsito</span>
                                <span class="fs-4 fw-bold text-cyan-neon">
                                    $<fmt:formatNumber value="${valorEnTransito}" pattern="#,##0.00"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Datos y Gestión de Cuenta Concentradora Principal -->
                <div class="col-xl-4 col-12">
                    <div class="p-4 p-md-5 h-100 d-flex flex-column justify-content-between shadow-sm" style="background: linear-gradient(135deg, #00F2FF 0%, #00BBE4 100%); border-radius: 24px; min-height: 260px;">
                        <div>
                            <div class="mb-2">
                                <h4 class="fw-bold tracking-wider lh-sm m-0" style="font-size: 1.4rem; color: #002022; font-family: 'Plus Jakarta Sans', sans-serif;">
                                    CUENTA CONCENTRADORA
                                </h4>
                            </div>

                            <div class="mt-3">
                                <span class="d-block text-uppercase fw-bold" style="font-size: 10px; color: rgba(0, 32, 34, 0.65); letter-spacing: 1px;">Saldo Principal</span>
                                <div class="d-flex align-items-baseline gap-1 mt-1">
                                    <span class="display-6 fw-bold" style="color: #002022; font-family: 'Plus Jakarta Sans', sans-serif;">
                                        $<fmt:formatNumber value="${saldoConcentradora}" pattern="#,##0.00"/>
                                    </span>
                                    <span class="fw-bold fs-6" style="color: #002022;">MXN</span>
                                </div>
                            </div>
                        </div>

                        <div class="pt-3">
                            <p class="small m-0 mb-3 fw-semibold" style="color: rgba(0, 32, 34, 0.85); font-size: 12px; line-height: 1.4;">
                                Cuenta principal que concentra la liquidez corporativa y distribuye fondos al sistema.
                            </p>
                            <button type="button" class="btn w-100 fw-bold py-3 rounded-pill d-flex align-items-center justify-content-center gap-2 shadow-sm"
                                    style="background: #002022; color: #00F2FF; border: none; font-size: 0.95rem; transition: all 0.2s ease;"
                                    data-bs-toggle="modal" data-bs-target="#modalIntroducirFondos">
                                <i class="bi bi-plus-circle-fill fs-5"></i>
                                <span>Introducir Fondos</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cabecera de Transacciones -->
            <div class="row mb-4 align-items-center">
                <div class="col-12 col-sm-6">
                    <h4 class="fs-4 fw-semibold text-white m-0 d-flex align-items-center gap-2">
                        <i class="bi bi-clock-history text-cyan-neon"></i> Últimas transacciones
                    </h4>
                </div>

                <!-- Selector de Filtrado -->
                <div class="col-12 col-sm-6 d-flex justify-content-sm-end align-items-center gap-2 mt-2 mt-sm-0">
                    <span class="d-none d-md-inline" style="font-size: 0.75rem; color: #BAC9CC !important;">Filtrar todas las transacciones</span>
                    <div class="dropdown">
                        <button class="btn btn-sm btn-dark dropdown-toggle px-3 border-0 text-white-50 d-flex align-items-center gap-1" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="background: #14161c; font-size: 0.85rem;">
                            <i class="bi bi-funnel"></i> Todas
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark">
                            <li><a class="dropdown-item active" href="#">Todas</a></li>
                            <li><a class="dropdown-item" href="#">Completadas</a></li>
                            <li><a class="dropdown-item" href="#">Fallidas</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Contenedor Oscuro de la Tabla y Estado Vacío -->
            <div class="row">
                <div class="col-12">
                    <div class="bg-figma-card p-4 p-md-5 d-flex flex-column shadow-lg" style="min-height: 350px; background: #14161c;">

                        <!-- Encabezados integrados -->
                        <div class="row text-uppercase fw-bold pb-3 mb-3 border-bottom g-0" style="font-size: 0.65rem; letter-spacing: 1.5px; border-color: rgba(255,255,255,0.04) !important; color: #BAC9CC !important; opacity: 1;">
                            <div class="col-4 text-start"><i class="bi bi-file-text me-1"></i>Concepto / Descripción</div>
                            <div class="col-3 text-center"><i class="bi bi-calendar-event me-1"></i>Fecha</div>
                            <div class="col-2 text-center"><i class="bi bi-info-circle me-1"></i>Estado</div>
                            <div class="col-3 text-end"><i class="bi bi-currency-dollar me-1"></i>Monto</div>
                        </div>

                        <c:choose>
                            <c:when test="${not empty ultimosMovimientos}">
                                <div class="d-flex flex-column gap-2" id="transactionsList">
                                    <c:forEach var="mov" items="${ultimosMovimientos}">
                                        <div class="row align-items-center py-3 px-2 rounded-3 g-0 transaction-item" style="border-bottom: 1px solid rgba(255, 255, 255, 0.03); transition: background 0.2s ease;">
                                            <div class="col-4 text-start d-flex align-items-center gap-3">
                                                <div class="rounded-circle d-flex align-items-center justify-content-center flex-shrink-0"
                                                     style="width: 38px; height: 38px; background: ${mov.tipoMovimiento == 'DEPOSITO_INICIAL' ? 'rgba(0, 242, 255, 0.1)' : 'rgba(99, 102, 241, 0.1)'}; color: ${mov.tipoMovimiento == 'DEPOSITO_INICIAL' ? '#00F2FF' : '#818CF8'}; border: 1px solid ${mov.tipoMovimiento == 'DEPOSITO_INICIAL' ? 'rgba(0, 242, 255, 0.2)' : 'rgba(99, 102, 241, 0.2)'};">
                                                    <i class="bi ${mov.tipoMovimiento == 'DEPOSITO_INICIAL' ? 'bi-plus-lg' : 'bi-arrow-left-right'} fs-6"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-semibold text-white" style="font-size: 0.9rem;">
                                                        <c:choose>
                                                            <c:when test="${mov.tipoMovimiento == 'DEPOSITO_INICIAL'}">Ingreso a Cuenta Concentradora</c:when>
                                                            <c:when test="${mov.tipoMovimiento == 'TRANSFERENCIA'}">Transferencia de Fondos</c:when>
                                                            <c:when test="${mov.tipoMovimiento == 'REINTEGRO_CONSERVADORA'}">Reintegro a Cuenta Concentradora</c:when>
                                                            <c:otherwise>${mov.tipoMovimiento}</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="small" style="font-size: 11px; color: #BAC9CC !important;">${mov.descripcion}</div>
                                                </div>
                                            </div>
                                            <div class="col-3 text-center small font-monospace" style="color: #BAC9CC !important; font-size: 0.8rem;">
                                                <fmt:formatDate value="${mov.fechaMovimiento}" pattern="dd/MM/yyyy HH:mm" />
                                            </div>
                                            <div class="col-2 text-center">
                                                <span class="badge px-3 py-1 rounded-pill font-monospace"
                                                      style="background: rgba(0, 242, 255, 0.1); color: #00F2FF; border: 1px solid rgba(0, 242, 255, 0.3); font-size: 10px;">
                                                    ${mov.estado}
                                                </span>
                                            </div>
                                            <div class="col-3 text-end font-monospace fw-bold fs-6 ${mov.tipoMovimiento == 'DEPOSITO_INICIAL' ? 'text-cyan-neon' : 'text-white'}">
                                                ${mov.tipoMovimiento == 'DEPOSITO_INICIAL' ? '+' : ''}$<fmt:formatNumber value="${mov.monto}" pattern="#,##0.00"/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Bloque Central de Estado Vacío -->
                                <div class="text-center my-auto py-5">
                                    <div class="d-inline-flex align-items-center justify-content-center border rounded-3 mb-4"
                                         style="width: 48px; height: 48px; border-color: rgba(255, 255, 255, 0.15) !important; color: rgba(0, 242, 255, 0.5);">
                                        <i class="bi bi-receipt fs-4"></i>
                                    </div>
                                    <h5 class="fw-normal text-white mb-2" style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.4rem;">Aún no hay transacciones registradas</h5>
                                    <p class="small m-0 mx-auto" style="max-width: 420px; font-family: 'Plus Jakarta Sans', sans-serif; color: #BAC9CC !important;">Utiliza el botón de Introducir Fondos para inyectar capital a la Cuenta Concentradora.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<!-- Modal Introducir Fondos -->
<jsp:include page="modal-introducir-fondos.jsp" />

<!-- Bootstrap 5 JavaScript Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>