<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%
    if (request.getAttribute("listaCuentas") == null) {
        com.example.tarjetascorporativas.model.Usuario user = (com.example.tarjetascorporativas.model.Usuario) session.getAttribute("usuarioLogueado");
        com.example.tarjetascorporativas.model.dao.CuentaDao cDao = new com.example.tarjetascorporativas.model.dao.CuentaDao();
        com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();

        java.util.List<com.example.tarjetascorporativas.model.Cuenta> ctas;
        if (user != null) {
            ctas = cDao.getByEmpleadoId(user.getIdUsuario());
        } else {
            java.util.List<com.example.tarjetascorporativas.model.Usuario> emps = uDao.getEmpleados();
            if (!emps.isEmpty()) {
                ctas = cDao.getByEmpleadoId(emps.get(0).getIdUsuario());
            } else {
                ctas = new java.util.ArrayList<>();
            }
        }
        request.setAttribute("listaCuentas", ctas);
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Mis Cuentas</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons LOCAL -->
    <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">
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
        .text-figma-gray { color: #64748B !important; }

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

        /* Estilizado de las Tarjetas de Cuenta */
        .account-card {
            background: #14171C;
            border: 1px solid #30363d;
            border-radius: 16px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }
        .account-card:hover {
            border-color: rgba(0, 219, 231, 0.5);
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }
        .account-card.active-selected {
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
                <h2 class="fw-bold display-6 font-jakarta" style="color: #E1FDFF;">Mis Cuentas</h2>
                <p class="text-figma-muted m-0 fs-6 opacity-75">Maneja tus cuentas corporativas y los fondos proporcionados por la empresa</p>
            </div>
        </div>

        <!-- BARRA DE BÚSQUEDA Y FILTRADO -->
        <div class="bg-figma-card rounded-4 p-3 mb-4 border backdrop-blur font-jakarta" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <div class="row g-3 align-items-end">
                <!-- Buscar Cuenta -->
                <div class="col-12 col-md-8 col-lg-9">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">BUSCAR CUENTA</label>
                    <div class="input-group rounded-2 overflow-hidden">
                        <span class="input-group-text bg-figma-input border-0 text-secondary px-3"><i class="bi bi-search"></i></span>
                        <input type="text" id="userSearchInput" class="form-control form-control-dark bg-figma-input py-2 text-figma-muted border-0 shadow-none" placeholder="Nombre de la cuenta...">
                    </div>
                </div>
                <!-- Estado Select -->
                <div class="col-12 col-md-4 col-lg-3">
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

            <!-- COLUMNA IZQUIERDA: Grid de Tarjetas de Cuentas -->
            <div class="col-12 col-xl-8">
                <c:choose>
                    <c:when test="${empty listaCuentas}">
                        <!-- Estado Vacío -->
                        <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 min-vh-50 backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
                            <h3 class="fw-semibold text-white mb-5 fs-5">Mis cuentas</h3>
                            <div class="d-flex flex-column align-items-center justify-content-center text-center my-auto py-5">
                                <div class="position-relative mb-4 text-secondary opacity-25">
                                    <i class="bi bi-folder-fill" style="font-size: 5.5rem;"></i>
                                    <i class="bi bi-bar-chart-fill position-absolute text-figma-cyan fs-4" style="bottom: 12px; right: 22px;"></i>
                                </div>
                                <h4 class="h5 text-light fw-normal mb-2">Aún no tienes cuentas asignadas.</h4>
                                <p class="text-figma-muted small mx-auto" style="max-width: 380px;">Ponte en contacto con el administrador para que asigne tus fondos corporativos.</p>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3" id="cardsGridContainer">
                            <c:forEach var="cta" items="${listaCuentas}" varStatus="status">
                                <!-- Cálculo de números enmascarados e indicadores -->
                                <c:set var="numRaw" value="${cta.numeroCuenta}" />
                                <c:set var="lastFour" value="${fn:length(numRaw) >= 4 ? fn:substring(numRaw, fn:length(numRaw) - 4, fn:length(numRaw)) : '0000'}" />

                                <c:set var="limite" value="${cta.limiteAsignado ne null ? cta.limiteAsignado : 0}" />
                                <c:set var="saldo" value="${cta.saldo ne null ? cta.saldo : 0}" />

                                <div class="col-12 col-md-6 col-lg-4 account-card-item"
                                     data-nombre="${cta.nombreCuenta.toLowerCase()}"
                                     data-estado="${cta.activo ? 'active' : 'inactive'}">

                                    <div class="account-card ${status.first ? 'active-selected' : ''}"
                                         onclick="selectAccountCard(this)"
                                         data-id="${cta.idCuenta}"
                                         data-numfull="${cta.numeroCuenta}"
                                         data-nummasked="ACCT •••• ${lastFour}"
                                         data-nombre="${cta.nombreCuenta}"
                                         data-descripcion="${cta.descripcion}"
                                         data-estado="${cta.activo ? 'Activa' : 'Inactiva'}"
                                         data-isactive="${cta.activo}"
                                         data-titular="${empty cta.nombreEmpleado ? sessionScope.usuarioLogueado.nombre : cta.nombreEmpleado}"
                                         data-limite="${limite}"
                                         data-saldo="${saldo}">

                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <div class="icon-box-cyan">
                                                <i class="bi bi-person-fill fs-5"></i>
                                            </div>
                                            <span class="${cta.activo ? 'badge-activa' : 'badge-inactiva'}">
                                                    ${cta.activo ? 'ACTIVA' : 'INACTIVA'}
                                            </span>
                                        </div>

                                        <h4 class="fw-semibold text-white mb-1 fs-5">${cta.nombreCuenta}</h4>
                                        <div class="text-secondary small font-monospace mb-3" style="font-size: 11px;">ACCT •••• ${lastFour}</div>

                                        <div class="mb-3">
                                            <span class="fs-4 fw-bold text-figma-cyan">$<fmt:formatNumber value="${saldo}" pattern="#,##0.00" /></span>
                                            <span class="small text-secondary font-monospace ms-1">MXN</span>
                                        </div>

                                        <div class="text-figma-muted small" style="font-size: 12px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 10px;">
                                                ${cta.descripcion}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Bloque filtro sin resultados -->
                        <div id="noUserResults" class="text-center py-5 d-none">
                            <i class="bi bi-search text-muted fs-3 mb-2 d-block"></i>
                            <h6 class="text-muted">No se encontraron cuentas que coincidan con la búsqueda</h6>
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

            <!-- COLUMNA DERECHA: Detalle Lateral (Panel de Cuenta Seleccionada) -->
            <div class="col-12 col-xl-4">
                <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">

                    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom border-secondary border-opacity-10">
                        <h3 class="fw-semibold text-white fs-5 m-0">Detalles de la cuenta</h3>
                        <span class="badge" style="background: rgba(0, 219, 231, 0.1); color: #00DBE7; border: 1px solid rgba(0, 219, 231, 0.3); font-size: 10px;">
                            Cuenta seleccionada
                        </span>
                    </div>

                    <!-- Mini vista previa de la tarjeta seleccionada -->
                    <div class="p-3 mb-4 rounded-3" style="background: #0d0f14; border: 1px solid #30363d;" id="previewCardBox">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div class="icon-box-cyan" style="width: 36px; height: 36px;">
                                <i class="bi bi-person-fill fs-6"></i>
                            </div>
                            <span id="previewBadge" class="badge-activa">ACTIVA</span>
                        </div>
                        <h5 id="previewTitle" class="fw-bold text-white mb-1 fs-5">Viáticos</h5>
                        <div id="previewMasked" class="text-secondary small font-monospace mb-2" style="font-size: 11px;">ACCT •••• 4920</div>
                        <div class="mb-2">
                            <span id="previewSaldo" class="fs-4 fw-bold text-figma-cyan">$1,450.00</span>
                            <span class="small text-secondary font-monospace ms-1">MXN</span>
                        </div>
                        <div id="previewDesc" class="text-figma-muted small" style="font-size: 12px;">Cuenta de gastos</div>
                    </div>

                    <!-- Lista detallada de atributos -->
                    <div class="d-flex flex-column gap-1" id="detailsListContainer">
                        <div class="detail-row">
                            <span class="detail-label">Número de cuenta</span>
                            <span id="detailNumFull" class="detail-value font-monospace">CA-#001</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Cuenta</span>
                            <span id="detailNombre" class="detail-value">Viáticos</span>
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
                            <span class="detail-label">Límite asignado</span>
                            <span id="detailLimite" class="detail-value font-monospace">$10,000.00</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Saldo disponible</span>
                            <span id="detailSaldoDispon" class="detail-value text-figma-cyan font-monospace">$8,450.00</span>
                        </div>

                        <!-- Barra de Uso de Límite -->
                        <div class="pt-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="detail-label">Uso de límite</span>
                                <span id="detailUsoPercent" class="detail-value text-figma-cyan font-monospace">15.5%</span>
                            </div>
                            <div class="progress-cyan">
                                <div id="detailProgressBar" class="progress-bar-cyan" style="width: 15.5%;"></div>
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
    function formatMoney(amount) {
        const num = parseFloat(amount) || 0;
        return '$' + num.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }

    function selectAccountCard(cardElement) {
        // Quitar clase seleccionada de todas las tarjetas
        document.querySelectorAll('.account-card').forEach(c => c.classList.remove('active-selected'));
        // Marcar la tarjeta actual como seleccionada
        cardElement.classList.add('active-selected');

        // Extraer atributos data
        const id = cardElement.getAttribute('data-id');
        const numfull = cardElement.getAttribute('data-numfull') || 'CA-#001';
        const nummasked = cardElement.getAttribute('data-nummasked') || 'ACCT •••• 0000';
        const nombre = cardElement.getAttribute('data-nombre') || 'Cuenta';
        const descripcion = cardElement.getAttribute('data-descripcion') || '';
        const estado = cardElement.getAttribute('data-estado') || 'Activa';
        const isActive = cardElement.getAttribute('data-isactive') === 'true';
        const titular = cardElement.getAttribute('data-titular') || '';
        const limite = parseFloat(cardElement.getAttribute('data-limite')) || 0;
        const saldo = parseFloat(cardElement.getAttribute('data-saldo')) || 0;

        // Actualizar vista previa en el panel derecho
        const previewBadge = document.getElementById('previewBadge');
        if (previewBadge) {
            previewBadge.textContent = isActive ? 'ACTIVA' : 'INACTIVA';
            previewBadge.className = isActive ? 'badge-activa' : 'badge-inactiva';
        }
        document.getElementById('previewTitle').textContent = nombre;
        document.getElementById('previewMasked').textContent = nummasked;
        document.getElementById('previewSaldo').textContent = formatMoney(saldo);
        document.getElementById('previewDesc').textContent = descripcion;

        // Actualizar filas detalladas
        document.getElementById('detailNumFull').textContent = numfull;
        document.getElementById('detailNombre').textContent = nombre;

        const detailEstado = document.getElementById('detailEstado');
        if (detailEstado) {
            detailEstado.textContent = estado;
            detailEstado.className = isActive ? 'detail-value text-figma-cyan' : 'detail-value text-danger';
        }

        document.getElementById('detailTitular').textContent = titular;
        document.getElementById('detailLimite').textContent = formatMoney(limite);
        document.getElementById('detailSaldoDispon').textContent = formatMoney(saldo);

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
        const firstCard = document.querySelector('.account-card');
        if (firstCard) {
            selectAccountCard(firstCard);
        }

        // Lógica de Filtrado
        const searchInput = document.getElementById("userSearchInput");
        const selectEstado = document.getElementById("userSelectEstado");
        const cardItems = document.querySelectorAll(".account-card-item");
        const noResults = document.getElementById("noUserResults");

        function filterUserAccounts() {
            const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : "";
            const selectedState = selectEstado ? selectEstado.value : "all";
            let visibleCount = 0;

            cardItems.forEach(item => {
                const name = item.getAttribute("data-nombre") || "";
                const estado = item.getAttribute("data-estado") || "";

                const matchesSearch = name.includes(searchTerm);
                const matchesState = selectedState === "all" || estado === selectedState;

                if (matchesSearch && matchesState) {
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

        if (searchInput) searchInput.addEventListener("input", filterUserAccounts);
        if (selectEstado) selectEstado.addEventListener("change", filterUserAccounts);
    });
</script>
</body>
</html>