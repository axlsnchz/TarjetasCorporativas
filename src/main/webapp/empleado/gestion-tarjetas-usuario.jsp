<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%
    if (request.getAttribute("listaTarjetas") == null) {
        com.example.tarjetascorporativas.model.Usuario user = (com.example.tarjetascorporativas.model.Usuario) session.getAttribute("usuarioLogueado");
        com.example.tarjetascorporativas.model.dao.TarjetaDao tDao = new com.example.tarjetascorporativas.model.dao.TarjetaDao();
        com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();

        java.util.List<com.example.tarjetascorporativas.model.Tarjeta> cards;
        if (user != null) {
            cards = tDao.getByEmpleadoId(user.getIdUsuario());
        } else {
            java.util.List<com.example.tarjetascorporativas.model.Usuario> emps = uDao.getEmpleados();
            if (!emps.isEmpty()) {
                cards = tDao.getByEmpleadoId(emps.get(0).getIdUsuario());
            } else {
                cards = new java.util.ArrayList<>();
            }
        }
        request.setAttribute("listaTarjetas", cards);
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Mis Tarjetas</title>

    <!-- Bootstrap 5 CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons CDN & Local -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="${pageContext.request.contextPath}/assets/icons/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts: Inter & Plus Jakarta Sans -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0C0E12;
            color: #E2E2E8;
            min-height: 100vh;
        }

        .font-jakarta {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .bg-figma-card { background-color: #14171C !important; }
        .bg-figma-input { background-color: #0D0F14 !important; }
        .bg-figma-select { background-color: #1E2024 !important; }

        .text-figma-cyan { color: #00DBE7 !important; }
        .text-figma-muted { color: #B9CACB !important; }
        .text-figma-gray { color: #BAC9CC !important; }

        .backdrop-blur {
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }

        .dashboard-glow {
            position: absolute;
            width: 500px;
            height: 500px;
            background: rgba(112, 0, 255, 0.03);
            filter: blur(140px);
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }

        /* Estilizado de Tarjetas interactivos (misma estética que Mis Cuentas) */
        .card-item-box {
            background: #14171C;
            border: 1px solid #30363d;
            border-radius: 16px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }
        .card-item-box:hover {
            border-color: rgba(0, 219, 231, 0.5);
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }
        .card-item-box.active-selected {
            border: 2px solid #00DBE7 !important;
            box-shadow: 0 0 20px rgba(0, 219, 231, 0.25), inset 0 0 15px rgba(0, 219, 231, 0.05);
            background: linear-gradient(145deg, #161a22, #11141a);
        }

        .icon-box-cyan {
            width: 44px;
            height: 44px;
            background: rgba(0, 219, 231, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00DBE7;
        }

        .badge-activa {
            background: rgba(0, 242, 255, 0.1);
            color: #00F2FF;
            border: 1px solid rgba(0, 242, 255, 0.3);
            font-size: 10px;
            letter-spacing: 0.05rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-family: monospace;
            font-weight: 700;
        }
        .badge-inactiva {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
            font-size: 10px;
            letter-spacing: 0.05rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-family: monospace;
            font-weight: 700;
        }
        .badge-tipo {
            background: rgba(112, 0, 255, 0.15);
            color: #a855f7;
            border: 1px solid rgba(168, 85, 247, 0.3);
            font-size: 10px;
            letter-spacing: 0.05rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-family: monospace;
            font-weight: 700;
        }

        .form-control-dark, .form-select-dark {
            border: 1px solid rgba(255, 255, 255, 0.05);
            color: #ffffff;
        }
        .form-control-dark:focus, .form-select-dark:focus {
            background-color: transparent;
            border-color: #00DBE7;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 219, 231, 0.15);
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            font-size: 13px;
        }
        .detail-label {
            color: #8b949e;
        }
        .detail-value {
            color: #e6edf3;
            font-weight: 600;
        }

        .progress-cyan {
            height: 6px;
            background-color: #1e242d;
            border-radius: 4px;
            overflow: hidden;
        }
        .progress-bar-cyan {
            background: linear-gradient(90deg, #00DBE7, #00F2FF);
            box-shadow: 0 0 10px rgba(0, 219, 231, 0.5);
            height: 100%;
        }

        /* Mockup Visual de Tarjeta de Crédito / Débito */
        .credit-card-preview {
            background: linear-gradient(135deg, #1b2028 0%, #0d0f14 100%);
            border: 1px solid rgba(0, 219, 231, 0.25);
            border-radius: 16px;
            padding: 20px;
            position: relative;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
            overflow: hidden;
        }
        .credit-card-preview::before {
            content: '';
            position: absolute;
            top: -40%;
            right: -20%;
            width: 250px;
            height: 250px;
            background: radial-gradient(circle, rgba(0,219,231,0.08) 0%, rgba(0,0,0,0) 70%);
            pointer-events: none;
        }
        .credit-card-chip {
            width: 36px;
            height: 26px;
            background: linear-gradient(135deg, #e6c666, #997819);
            border-radius: 5px;
            border: 1px solid rgba(255,255,255,0.2);
            position: relative;
        }

        @media (max-width: 767.98px) {
            .top-header { left: 0 !important; }
            main { margin-left: 0 !important; padding: 95px 20px 40px 20px !important; }
        }
    </style>
</head>
<body class="overflow-x-hidden min-vh-100">

<div class="d-flex min-vh-100 position-relative">
    <div class="dashboard-glow" style="left: 30%; top: 20%;"></div>

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp" />

    <!-- CONTENIDO PRINCIPAL -->
    <main class="flex-grow-1 position-relative" style="margin-left: 260px; padding: 115px 40px 40px 40px; z-index: 1;">

        <!-- HEADER FIJO -->
        <div class="position-fixed top-0 end-0 top-header d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
             style="left: 260px; height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
            <button class="btn d-md-none text-figma-cyan fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarUsuario" aria-controls="sidebarUsuario" aria-label="Abrir menú">
                <i class="bi bi-list"></i>
            </button>
            <i class="bi bi-person-circle text-figma-cyan fs-3 role-button" style="cursor: pointer;"></i>
        </div>

        <!-- Título de la Sección -->
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="fw-bold display-6 font-jakarta" style="color: #E1FDFF;">Mis Tarjetas</h2>
                <p class="text-figma-muted m-0 fs-6 opacity-75">Consulta las tarjetas asociadas a tus cuentas corporativas y sus detalles</p>
            </div>
        </div>

        <!-- BARRA DE BÚSQUEDA Y FILTRADO -->
        <div class="bg-figma-card rounded-4 p-3 mb-4 border backdrop-blur font-jakarta" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <div class="row g-3 align-items-end">
                <!-- Buscar Tarjeta -->
                <div class="col-12 col-md-6 col-lg-6">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">BUSCAR TARJETA</label>
                    <div class="input-group rounded-2 overflow-hidden">
                        <span class="input-group-text bg-figma-input border-0 text-secondary px-3"><i class="bi bi-search"></i></span>
                        <input type="text" id="userSearchInput" class="form-control form-control-dark bg-figma-input py-2 text-figma-muted border-0 shadow-none" placeholder="Buscar por alias, tarjeta o cuenta...">
                    </div>
                </div>
                <!-- Tipo Select -->
                <div class="col-12 col-md-3 col-lg-3">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">TIPO</label>
                    <select id="userSelectTipo" class="form-select form-select-dark bg-figma-select py-2 border-0 text-white shadow-none">
                        <option selected value="all">Todos los tipos</option>
                        <option value="virtual">Virtual</option>
                        <option value="fisica">Física</option>
                    </select>
                </div>
                <!-- Estado Select -->
                <div class="col-12 col-md-3 col-lg-3">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">ESTADO</label>
                    <select id="userSelectEstado" class="form-select form-select-dark bg-figma-select py-2 border-0 text-white shadow-none">
                        <option selected value="all">Todos los estados</option>
                        <option value="active">Activas</option>
                        <option value="inactive">Inactivas</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- REJILLA PRINCIPAL DE CONTENIDO -->
        <div class="row g-4 font-jakarta">

            <!-- COLUMNA IZQUIERDA: Grid de Tarjetas -->
            <div class="col-12 col-xl-8">
                <c:choose>
                    <c:when test="${empty listaTarjetas}">
                        <!-- Estado Vacío -->
                        <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 min-vh-50 backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
                            <h3 class="fw-semibold text-white mb-5 fs-5">Mis tarjetas</h3>
                            <div class="d-flex flex-column align-items-center justify-content-center text-center my-auto py-5">
                                <div class="position-relative mb-4 text-secondary opacity-25">
                                    <i class="bi bi-credit-card-2-front" style="font-size: 5.5rem;"></i>
                                    <i class="bi bi-wallet2 position-absolute text-figma-cyan fs-4" style="bottom: 12px; right: 22px;"></i>
                                </div>
                                <h4 class="h5 text-light fw-normal mb-2">No tienes tarjetas registradas aún.</h4>
                                <p class="text-figma-muted small mx-auto" style="max-width: 380px;">Solicita a tu administrador la emisión de una tarjeta para tus cuentas asignadas.</p>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3" id="cardsGridContainer">
                            <c:forEach var="tarjeta" items="${listaTarjetas}" varStatus="status">
                                <!-- Cálculo de números enmascarados -->
                                <c:set var="numRaw" value="${tarjeta.numeroTarjeta}" />
                                <c:set var="lastFour" value="${fn:length(numRaw) >= 4 ? fn:substring(numRaw, fn:length(numRaw) - 4, fn:length(numRaw)) : '0000'}" />

                                <c:set var="saldo" value="${tarjeta.saldo ne null ? tarjeta.saldo : 0}" />
                                <c:set var="limite" value="${tarjeta.limiteAsignado ne null ? tarjeta.limiteAsignado : 0}" />

                                <div class="col-12 col-md-6 col-lg-4 card-tarjeta-item"
                                     data-alias="${tarjeta.alias.toLowerCase()}"
                                     data-cuenta="${tarjeta.nombreCuenta ne null ? tarjeta.nombreCuenta.toLowerCase() : ''}"
                                     data-numero="${tarjeta.numeroTarjeta}"
                                     data-estado="${tarjeta.activo ? 'active' : 'inactive'}"
                                     data-tipo="${tarjeta.tipoTarjeta.toLowerCase()}">

                                    <div class="card-item-box ${status.first ? 'active-selected' : ''}"
                                         onclick="selectCard(this)"
                                         data-id="${tarjeta.idTarjeta}"
                                         data-alias="${tarjeta.alias}"
                                         data-numfull="${tarjeta.numeroTarjeta}"
                                         data-nummasked="•••• •••• •••• ${lastFour}"
                                         data-expiracion="${tarjeta.fechaExpiracion}"
                                         data-cvv="${tarjeta.cvv}"
                                         data-tipo="${tarjeta.tipoTarjeta}"
                                         data-idcuenta="${tarjeta.idCuenta}"
                                         data-nombrecuenta="${empty tarjeta.nombreCuenta ? 'Cuenta Corporativa' : tarjeta.nombreCuenta}"
                                         data-numcuenta="${tarjeta.numeroCuenta}"
                                         data-titular="${empty tarjeta.nombreEmpleado ? (sessionScope.usuarioLogueado ne null ? sessionScope.usuarioLogueado.nombre : 'Empleado') : tarjeta.nombreEmpleado}"
                                         data-cargo="${empty tarjeta.nombreCargo ? 'Sin cargo' : tarjeta.nombreCargo}"
                                         data-departamento="${empty tarjeta.nombreDepartamento ? 'General' : tarjeta.nombreDepartamento}"
                                         data-estado="${tarjeta.activo ? 'Activa' : 'Inactiva'}"
                                         data-isactive="${tarjeta.activo}"
                                         data-saldo="${saldo}"
                                         data-limite="${limite}">

                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <div class="icon-box-cyan">
                                                <i class="bi bi-credit-card-2-front-fill fs-5"></i>
                                            </div>
                                            <div class="d-flex gap-1 align-items-center">
                                                <span class="badge-tipo">${tarjeta.tipoTarjeta}</span>
                                                <span class="${tarjeta.activo ? 'badge-activa' : 'badge-inactiva'}">
                                                    ${tarjeta.activo ? 'ACTIVA' : 'INACTIVA'}
                                                </span>
                                            </div>
                                        </div>

                                        <h4 class="fw-semibold text-white mb-1 fs-5">${tarjeta.alias}</h4>
                                        <div class="text-secondary small font-monospace mb-3" style="font-size: 12px;">•••• •••• •••• ${lastFour}</div>

                                        <div class="mb-3">
                                            <span class="fs-5 fw-bold text-figma-cyan">$<fmt:formatNumber value="${saldo}" pattern="#,##0.00" /></span>
                                            <span class="small text-secondary font-monospace ms-1">MXN</span>
                                        </div>

                                        <div class="text-figma-muted small d-flex justify-content-between align-items-center" style="font-size: 11px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 10px;">
                                            <span class="text-truncate me-2"><i class="bi bi-bank me-1"></i>${empty tarjeta.nombreCuenta ? 'Cuenta' : tarjeta.nombreCuenta}</span>
                                            <span class="font-monospace">EXP ${tarjeta.fechaExpiracion}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Bloque filtro sin resultados -->
                        <div id="noUserResults" class="text-center py-5 d-none">
                            <i class="bi bi-search text-muted fs-3 mb-2 d-block"></i>
                            <h6 class="text-muted">No se encontraron tarjetas que coincidan con la búsqueda</h6>
                        </div>

                        <!-- Paginas UI Inferior -->
                        <div class="d-flex justify-content-center align-items-center gap-2 mt-4">
                            <button class="btn btn-sm btn-outline-secondary rounded-circle px-2 py-1" style="width: 32px; height: 32px;"><i class="bi bi-chevron-left"></i></button>
                            <button class="btn btn-sm btn-figma-cyan text-dark fw-bold rounded-circle" style="width: 32px; height: 32px; background: #00DBE7;">1</button>
                            <button class="btn btn-sm btn-outline-secondary rounded-circle px-2 py-1" style="width: 32px; height: 32px;"><i class="bi bi-chevron-right"></i></button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- COLUMNA DERECHA: Detalle Lateral (Panel de Tarjeta Seleccionada) -->
            <div class="col-12 col-xl-4">
                <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">

                    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom border-secondary border-opacity-10">
                        <h3 class="fw-semibold text-white fs-5 m-0">Detalles de la tarjeta</h3>
                        <span class="badge" style="background: rgba(0, 219, 231, 0.1); color: #00DBE7; border: 1px solid rgba(0, 219, 231, 0.3); font-size: 10px;">
                            Tarjeta seleccionada
                        </span>
                    </div>

                    <!-- Mini vista previa de la Tarjeta Corporativa (Mockup) -->
                    <div class="credit-card-preview mb-4" id="previewCardBox">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="fw-bold text-figma-cyan font-jakarta" style="font-size: 13px; letter-spacing: 1px;">FINTECH CORP</span>
                            <div class="d-flex gap-1 align-items-center">
                                <span id="previewTipoBadge" class="badge-tipo">VIRTUAL</span>
                                <span id="previewBadge" class="badge-activa">ACTIVA</span>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="credit-card-chip"></div>
                            <i class="bi bi-wifi text-secondary fs-4" style="transform: rotate(90deg);"></i>
                        </div>

                        <div class="mb-3">
                            <div class="text-secondary small text-uppercase mb-1" style="font-size: 9px; letter-spacing: 1px;">Número de Tarjeta</div>
                            <div id="previewNumMasked" class="fs-5 fw-bold text-white font-monospace" style="letter-spacing: 2px;">
                                •••• •••• •••• 0000
                            </div>
                        </div>

                        <div class="row g-2 align-items-end">
                            <div class="col-6">
                                <div class="text-secondary small text-uppercase" style="font-size: 8px; letter-spacing: 1px;">Titular</div>
                                <div id="previewTitular" class="text-white small fw-semibold text-truncate" style="font-size: 11px;">Empleado</div>
                            </div>
                            <div class="col-3 text-center">
                                <div class="text-secondary small text-uppercase" style="font-size: 8px; letter-spacing: 1px;">Vence</div>
                                <div id="previewExp" class="text-white small font-monospace" style="font-size: 11px;">MM/YY</div>
                            </div>
                            <div class="col-3 text-end">
                                <div class="text-secondary small text-uppercase" style="font-size: 8px; letter-spacing: 1px;">CVV</div>
                                <div id="previewCvv" class="text-figma-cyan small font-monospace" style="font-size: 11px;">***</div>
                            </div>
                        </div>
                    </div>

                    <!-- Botón interactivo para ver/ocultar CVV y datos confidenciales -->
                    <div class="mb-4">
                        <button type="button" id="btnToggleDetails" class="btn btn-sm w-100 btn-outline-info text-figma-cyan border-opacity-25 rounded-3 py-2 d-flex align-items-center justify-content-center gap-2" style="border-color: #00DBE7;" onclick="toggleCardDetailsVisibility()">
                            <i class="bi bi-eye" id="toggleDetailsIcon"></i> <span id="toggleDetailsText">Mostrar número completo y CVV</span>
                        </button>
                    </div>

                    <!-- Lista detallada de atributos -->
                    <div class="d-flex flex-column gap-1" id="detailsListContainer">
                        <div class="detail-row">
                            <span class="detail-label">Alias</span>
                            <span id="detailAlias" class="detail-value text-white">Tarjeta</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Número de Tarjeta</span>
                            <span id="detailNumFull" class="detail-value font-monospace">•••• •••• •••• 0000</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Tipo</span>
                            <span id="detailTipo" class="detail-value">VIRTUAL</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Cuenta Asociada</span>
                            <span id="detailCuenta" class="detail-value">Viáticos</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Estado</span>
                            <span id="detailEstado" class="detail-value text-figma-cyan">Activa</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Titular</span>
                            <span id="detailTitular" class="detail-value">${sessionScope.usuarioLogueado ne null ? sessionScope.usuarioLogueado.nombre : 'Empleado'}</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Cargo / Depto</span>
                            <span id="detailCargoDepto" class="detail-value font-monospace">General</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Fecha de Expiración</span>
                            <span id="detailExp" class="detail-value font-monospace">MM/YY</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">CVV</span>
                            <span id="detailCvv" class="detail-value font-monospace text-figma-cyan">***</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Saldo Disponible</span>
                            <span id="detailSaldoDispon" class="detail-value text-figma-cyan font-monospace">$0.00</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Límite Asignado</span>
                            <span id="detailLimite" class="detail-value font-monospace">$0.00</span>
                        </div>

                        <!-- Barra de Uso de Límite -->
                        <div class="pt-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="detail-label">Uso de límite</span>
                                <span id="detailUsoPercent" class="detail-value text-figma-cyan font-monospace">0.0%</span>
                            </div>
                            <div class="progress-cyan">
                                <div id="detailProgressBar" class="progress-bar-cyan" style="width: 0.0%;"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </main>
</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>

<!-- Script interactivo de Selección de Tarjetas y Filtrado -->
<script>
    let showFullDetails = false;
    let currentSelectedCard = null;

    function formatMoney(amount) {
        const num = parseFloat(amount) || 0;
        return '$' + num.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }

    function formatCardNumber(num) {
        if (!num) return '•••• •••• •••• 0000';
        const clean = num.replace(/\s+/g, '');
        if (clean.length === 16) {
            return clean.match(/.{1,4}/g).join(' ');
        }
        return num;
    }

    function toggleCardDetailsVisibility() {
        showFullDetails = !showFullDetails;
        const icon = document.getElementById('toggleDetailsIcon');
        const text = document.getElementById('toggleDetailsText');

        if (showFullDetails) {
            icon.className = 'bi bi-eye-slash';
            text.textContent = 'Ocultar datos confidenciales';
        } else {
            icon.className = 'bi bi-eye';
            text.textContent = 'Mostrar número completo y CVV';
        }

        if (currentSelectedCard) {
            selectCard(currentSelectedCard);
        }
    }

    function selectCard(cardElement) {
        currentSelectedCard = cardElement;

        // Quitar clase seleccionada de todas las tarjetas
        document.querySelectorAll('.card-item-box').forEach(c => c.classList.remove('active-selected'));
        // Marcar la tarjeta actual como seleccionada
        cardElement.classList.add('active-selected');

        // Extraer atributos data
        const id = cardElement.getAttribute('data-id');
        const alias = cardElement.getAttribute('data-alias') || 'Tarjeta';
        const numfull = cardElement.getAttribute('data-numfull') || '';
        const nummasked = cardElement.getAttribute('data-nummasked') || '•••• •••• •••• 0000';
        const expiracion = cardElement.getAttribute('data-expiracion') || 'MM/YY';
        const cvv = cardElement.getAttribute('data-cvv') || '***';
        const tipo = cardElement.getAttribute('data-tipo') || 'VIRTUAL';
        const nombrecuenta = cardElement.getAttribute('data-nombrecuenta') || 'Cuenta Corporativa';
        const numcuenta = cardElement.getAttribute('data-numcuenta') || '';
        const titular = cardElement.getAttribute('data-titular') || '';
        const cargo = cardElement.getAttribute('data-cargo') || '';
        const departamento = cardElement.getAttribute('data-departamento') || '';
        const estado = cardElement.getAttribute('data-estado') || 'Activa';
        const isActive = cardElement.getAttribute('data-isactive') === 'true';
        const saldo = parseFloat(cardElement.getAttribute('data-saldo')) || 0;
        const limite = parseFloat(cardElement.getAttribute('data-limite')) || 0;

        // Actualizar vista previa en el mockup de la tarjeta
        const previewBadge = document.getElementById('previewBadge');
        if (previewBadge) {
            previewBadge.textContent = isActive ? 'ACTIVA' : 'INACTIVA';
            previewBadge.className = isActive ? 'badge-activa' : 'badge-inactiva';
        }

        const previewTipoBadge = document.getElementById('previewTipoBadge');
        if (previewTipoBadge) {
            previewTipoBadge.textContent = tipo;
        }

        document.getElementById('previewNumMasked').textContent = showFullDetails ? formatCardNumber(numfull) : nummasked;
        document.getElementById('previewTitular').textContent = titular;
        document.getElementById('previewExp').textContent = expiracion;
        document.getElementById('previewCvv').textContent = showFullDetails ? cvv : '***';

        // Actualizar filas detalladas
        document.getElementById('detailAlias').textContent = alias;
        document.getElementById('detailNumFull').textContent = showFullDetails ? formatCardNumber(numfull) : nummasked;
        document.getElementById('detailTipo').textContent = tipo;
        document.getElementById('detailCuenta').textContent = nombrecuenta + (numcuenta ? ' (' + numcuenta + ')' : '');

        const detailEstado = document.getElementById('detailEstado');
        if (detailEstado) {
            detailEstado.textContent = estado;
            detailEstado.className = isActive ? 'detail-value text-figma-cyan' : 'detail-value text-danger';
        }

        document.getElementById('detailTitular').textContent = titular;
        
        let cargoDeptoText = '';
        if (cargo && cargo !== 'Sin cargo') cargoDeptoText += cargo;
        if (departamento && departamento !== 'General') {
            if (cargoDeptoText) cargoDeptoText += ' / ';
            cargoDeptoText += departamento;
        }
        document.getElementById('detailCargoDepto').textContent = cargoDeptoText || 'General';

        document.getElementById('detailExp').textContent = expiracion;
        document.getElementById('detailCvv').textContent = showFullDetails ? cvv : '***';
        document.getElementById('detailSaldoDispon').textContent = formatMoney(saldo);
        document.getElementById('detailLimite').textContent = formatMoney(limite);

        // Calcular porcentaje de uso del límite (spent = limite - saldo)
        let percent = 0;
        if (limite > 0) {
            const spent = Math.max(0, limite - saldo);
            percent = (spent / limite) * 100;
            if (percent > 100) percent = 100;
        }

        const percentFormatted = percent.toFixed(1) + '%';
        document.getElementById('detailUsoPercent').textContent = percentFormatted;

        const progressBar = document.getElementById('detailProgressBar');
        if (progressBar) {
            progressBar.style.width = percentFormatted;
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        // Seleccionar automáticamente la primera tarjeta disponible
        const firstCard = document.querySelector('.card-item-box');
        if (firstCard) {
            selectCard(firstCard);
        }

        // Lógica de Filtrado
        const searchInput = document.getElementById("userSearchInput");
        const selectEstado = document.getElementById("userSelectEstado");
        const selectTipo = document.getElementById("userSelectTipo");
        const cardItems = document.querySelectorAll(".card-tarjeta-item");
        const noResults = document.getElementById("noUserResults");

        function filterUserCards() {
            const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : "";
            const selectedState = selectEstado ? selectEstado.value : "all";
            const selectedTipo = selectTipo ? selectTipo.value : "all";
            let visibleCount = 0;

            cardItems.forEach(item => {
                const alias = item.getAttribute("data-alias") || "";
                const cuenta = item.getAttribute("data-cuenta") || "";
                const numero = item.getAttribute("data-numero") || "";
                const estado = item.getAttribute("data-estado") || "";
                const tipo = item.getAttribute("data-tipo") || "";

                const matchesSearch = alias.includes(searchTerm) || cuenta.includes(searchTerm) || numero.includes(searchTerm);
                const matchesState = selectedState === "all" || estado === selectedState;
                const matchesTipo = selectedTipo === "all" || tipo === selectedTipo;

                if (matchesSearch && matchesState && matchesTipo) {
                    item.style.display = "";
                    visibleCount++;
                } else {
                    item.style.display = "none";
                }
            });

            if (noResults) {
                if (visibleCount === 0 && cardItems.length > 0) {
                    noResults.classList.remove("d-none");
                } else {
                    noResults.classList.add("d-none");
                }
            }
        }

        if (searchInput) searchInput.addEventListener("input", filterUserCards);
        if (selectEstado) selectEstado.addEventListener("change", filterUserCards);
        if (selectTipo) selectTipo.addEventListener("change", filterUserCards);
    });
</script>
</body>
</html>