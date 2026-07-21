<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
  // Si la lista de cuentas no está presente en el request (acceso directo al JSP), la cargamos automáticamente
  if (request.getAttribute("listaCuentas") == null) {
    com.example.tarjetascorporativas.model.dao.CuentaDao cDao = new com.example.tarjetascorporativas.model.dao.CuentaDao();
    com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();

    java.util.List<com.example.tarjetascorporativas.model.Cuenta> cuentas = cDao.getCuentasEmpleados();
    java.util.List<com.example.tarjetascorporativas.model.Usuario> empleados = uDao.getEmpleados();
    com.example.tarjetascorporativas.model.Cuenta concentradora = cDao.getCuentaConcentradora();
    java.math.BigDecimal saldoConcentradora = (concentradora != null && concentradora.getSaldo() != null) ? concentradora.getSaldo() : java.math.BigDecimal.ZERO;

    long actCount = cuentas.stream().filter(com.example.tarjetascorporativas.model.Cuenta::isActivo).count();

    request.setAttribute("listaCuentas", cuentas);
    request.setAttribute("listaEmpleados", empleados);
    request.setAttribute("cuentasActivasCount", actCount);
    request.setAttribute("saldoConcentradora", saldoConcentradora);
  }
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Gestión de Cuentas</title>

  <!-- Bootstrap 5 CSS LOCAL -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons LOCAL -->
  <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;700&display=swap" rel="stylesheet">

  <style>
    body {
      background-color: #111318;
      font-family: 'Inter', sans-serif;
      color: #B9CACB;
      min-height: 100vh;
    }
    @media (min-width: 768px) {
      .main-content {
        margin-left: 260px;
      }
    }
    .bg-figma-card {
      background: #14171C;
      border: 1px solid #3B494C;
      border-radius: 16px;
      position: relative;
      overflow: hidden;
    }
    .card-glow-effect {
      position: absolute;
      width: 256px;
      height: 256px;
      right: -50px;
      top: -80px;
      background: rgba(0, 229, 255, 0.05);
      box-shadow: 64px 64px 64px rgba(0, 229, 255, 0.05);
      border-radius: 9999px;
      filter: blur(32px);
      pointer-events: none;
    }
    .btn-figma-neon {
      background: #00E5FF;
      border-radius: 32px;
      color: #002022;
      font-family: 'Inter', sans-serif;
      font-weight: 700;
      border: none;
      transition: all 0.2s ease;
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
      padding: 8px 20px;
      transition: all 0.2s ease;
    }
    .btn-outline-figma-neon:hover {
      background: rgba(0, 229, 255, 0.1);
      color: #00e5ff;
    }
    .text-cyan-neon {
      color: #00DBE7 !important;
    }
    .font-plus-jakarta {
      font-family: 'Plus Jakarta Sans', sans-serif;
    }
    .form-figma-search {
      background: #0D0F14 !important;
      border: 1px solid rgba(255, 255, 255, 0.05) !important;
      color: #F5F5F5 !important;
      border-radius: 8px !important;
      font-size: 0.85rem;
    }
    .form-figma-search::placeholder {
      color: #475569;
    }
    .form-figma-select {
      background: #1E2024 url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%236B7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") no-repeat right 0.75rem center/10px 10px !important;
      border: 1px solid rgba(255, 255, 255, 0.05) !important;
      color: #FFFFFF !important;
      border-radius: 8px !important;
      font-size: 0.85rem;
    }
    .form-label-figma {
      color: #ffffff;
      font-size: 10px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin-bottom: 8px;
      display: block;
    }
    .form-figma-input {
      background-color: #1e2024 !important;
      border: 1px solid #30363d !important;
      color: #ffffff !important;
      border-radius: 8px !important;
      padding: 10px 14px !important;
      font-size: 14px !important;
    }
    .form-figma-input:focus {
      border-color: #00e5ff !important;
      box-shadow: 0 0 0 0.25rem rgba(0, 229, 255, 0.15) !important;
    }

    .table-figma-dark {
      --bs-table-bg: transparent !important;
      --bs-table-color: #E2E2E8 !important;
      background-color: transparent !important;
      color: #E2E2E8 !important;
    }
    .table-figma-dark td, .table-figma-dark tr {
      background-color: transparent !important;
      color: #E2E2E8 !important;
      border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
      padding: 14px 20px !important;
    }
    .account-row:hover td {
      background-color: #1E222A !important;
    }

    .dropdown-menu-dark-figma {
      background-color: #14171C !important;
      border: 1px solid #30363D !important;
      border-radius: 12px !important;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5) !important;
      padding: 6px !important;
      min-width: 150px !important;
      z-index: 1050 !important;
    }
    .dropstart .dropdown-menu-dark-figma {
      margin-right: 8px !important;
    }
    .dropdown-menu-dark-figma .dropdown-item {
      color: #E2E2E8 !important;
      border-radius: 8px !important;
      font-size: 13px !important;
      font-weight: 500 !important;
      padding: 8px 12px !important;
      transition: all 0.15s ease !important;
      background: transparent !important;
    }
    .dropdown-menu-dark-figma .dropdown-item:hover,
    .dropdown-menu-dark-figma .dropdown-item:focus {
      background-color: rgba(255, 255, 255, 0.08) !important;
      color: #FFFFFF !important;
    }
    .dropdown-menu-dark-figma .dropdown-item.text-danger {
      color: #EF4444 !important;
    }
    .dropdown-menu-dark-figma .dropdown-item.text-danger:hover {
      background-color: rgba(239, 68, 68, 0.15) !important;
      color: #EF4444 !important;
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

  <!-- HEADER SUPERIOR GLOBAL -->
  <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
          style="height: 75px; background: rgba(17, 19, 24, 0.85); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
    <button class="btn d-md-none text-cyan-neon fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarAdmin" aria-controls="sidebarAdmin" aria-label="Abrir menú">
      <i class="bi bi-list"></i>
    </button>
    <i class="bi bi-person-circle text-cyan-neon fs-3 role-button" style="cursor: pointer;"></i>
  </header>

  <main class="flex-grow-1 p-4 p-md-5 pt-4">
    <div class="container-fluid p-0">

      <!-- Mensajes Alerta Feedback -->
      <c:if test="${not empty sessionScope.mensajeExito}">
        <div class="alert alert-success alert-dismissible fade show border-0 text-white mb-4 shadow-sm" style="background: rgba(16, 185, 129, 0.2); border-left: 4px solid #10b981 !important;" role="alert">
          <i class="bi bi-check-circle-fill me-2 text-success"></i> ${sessionScope.mensajeExito}
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("mensajeExito"); %>
      </c:if>

      <c:if test="${not empty sessionScope.mensajeError}">
        <div class="alert alert-danger alert-dismissible fade show border-0 text-white mb-4 shadow-sm" style="background: rgba(239, 68, 68, 0.2); border-left: 4px solid #ef4444 !important;" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2 text-danger"></i> ${sessionScope.mensajeError}
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("mensajeError"); %>
      </c:if>

      <!-- Encabezado de la Vista -->
      <div class="mb-4">
        <h2 class="fw-bold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Gestión de Cuentas</h2>
        <p class="m-0 mt-2 text-muted" style="color: #B9CACB !important;">Resumen de fondos operativos y beneficios institucionales.</p>
      </div>

      <!-- Fila superior: Tarjetas de Acciones Principales -->
      <div class="row g-4 mb-4">
        <!-- Tarjeta: Crear Cuenta -->
        <div class="col-12 col-lg-7">
          <div class="bg-figma-card p-4 h-100 d-flex flex-column justify-content-between">
            <div class="card-glow-effect"></div>

            <div class="row align-items-center g-3">
              <div class="col-12 col-sm-7 col-md-8">
                <h3 class="font-plus-jakarta fw-normal mb-2" style="color: #C3F5FF; font-size: 1.85rem;">Crear Nueva Cuenta</h3>
                <p class="small text-muted mb-0" style="color: #BAC9CC !important; line-height: 1.5;">
                  Inicia la asignación de cuentas corporativas (viáticos, bonos, combustible) a los empleados.
                </p>
              </div>
              <!-- Icono Estilizado -->
              <div class="col-12 col-sm-5 col-md-4 text-end d-none d-sm-block">
                <div class="d-inline-flex align-items-center justify-content-center rounded-4 border border-info border-opacity-10 shadow-sm mx-auto"
                     style="width: 110px; height: 110px; background: rgba(0, 229, 255, 0.03); color: #00E5FF;">
                  <i class="bi bi-wallet2 display-4 opacity-50"></i>
                </div>
              </div>
            </div>

            <!-- Indicador estadístico inferior y botón -->
            <div class="d-flex justify-content-between align-items-end mt-4">
              <div>
                <div class="text-muted small fw-medium" style="color: #BAC9CC !important; font-size: 0.9rem;">Cuentas Activas</div>
                <div class="fw-bold text-white fs-3 font-plus-jakarta mt-1">${cuentasActivasCount}</div>
              </div>
              <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2"
                      data-bs-toggle="modal" data-bs-target="#modalRegistrarCuenta"
                      onclick="prepararModalRegistrarCuenta()">
                <i class="bi bi-plus-circle-fill fs-5"></i>
                <span>Crear Cuenta</span>
              </button>
            </div>
          </div>
        </div>

        <!-- Tarjeta: Depositar a Empleados -->
        <div class="col-12 col-lg-5">
          <div class="bg-figma-card p-4 h-100 d-flex flex-column justify-content-between">
            <div class="card-glow-effect"></div>

            <div>
              <h3 class="font-plus-jakarta fw-normal mb-2 mt-2" style="color: #C3F5FF; font-size: 1.85rem; line-height: 1.2;">
                Deposita a las cuentas<br>de los empleados
              </h3>
              <p class="small text-muted mb-0" style="color: #BAC9CC !important; line-height: 1.4;">
                Transfiere fondos de manera inmediata desde la Cuenta Concentradora a cualquier empleado.
              </p>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4">
              <span class="text-muted small">Total Cuentas: <strong class="text-white">${listaCuentas.size()}</strong></span>
              <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2"
                      data-bs-toggle="modal" data-bs-target="#modalDepositarEmpleado"
                      onclick="abrirModalDepositoGeneral()">
                <i class="bi bi-arrow-down-circle-fill fs-5"></i>
                <span>Depositar Fondos</span>
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Barra de Filtros y Búsqueda -->
      <div class="p-3 mb-4 rounded-4" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">
        <div class="row g-3 align-items-center">
          <div class="col-12 col-md-8">
            <label class="d-block text-uppercase fw-bold mb-1 font-plus-jakarta" style="font-size: 0.625rem; color: #64748B; letter-spacing: 1px;">Buscar Titular o Cuenta</label>
            <div class="position-relative">
              <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #475569;"></i>
              <input type="text" id="searchCuentaInput" class="form-control form-figma-search ps-5 py-2" placeholder="Buscar por empleado o nombre de cuenta...">
            </div>
          </div>
          <div class="col-12 col-md-4">
            <label class="d-block text-uppercase fw-bold mb-1 font-plus-jakarta" style="font-size: 0.625rem; color: #64748B; letter-spacing: 1px;">Estado</label>
            <select id="selectEstadoCuentaFilter" class="form-select form-figma-select py-2 shadow-none">
              <option selected value="all">Todos los estados</option>
              <option value="active">Activas</option>
              <option value="inactive">Inactivas</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Contenedor de la Tabla -->
      <div class="bg-figma-card overflow-hidden shadow-lg" style="min-height: 350px;">
        <c:choose>
          <c:when test="${empty listaCuentas}">
            <!-- Bloque de Estado Vacío dentro del contenedor -->
            <div class="d-flex flex-column align-items-center justify-content-center text-center font-plus-jakarta py-5 px-3" style="min-height: 250px; background: #14171C;">
              <div class="mb-3 d-flex align-items-center justify-content-center border rounded-3"
                   style="width: 44px; height: 44px; border-color: #3B494C !important; color: #64748B;">
                <i class="bi bi-file-earmark-text fs-4"></i>
              </div>
              <h5 class="fw-normal text-white mb-2" style="font-size: 1.4rem;">Aún no hay cuentas registradas</h5>
              <p class="small text-muted mb-0" style="color: #737373 !important;">
                Haz clic en "Crear Cuenta" para asignar una nueva cuenta corporativa a un empleado.
              </p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-responsive">
              <table class="table table-borderless table-figma-dark m-0 align-middle">
                <thead class="table-figma-header">
                <tr>
                  <th style="width: 32%;">EMPLEADO</th>
                  <th style="width: 25%;">CUENTA</th>
                  <th style="width: 20%; text-align: right;">SALDO ACTUAL</th>
                  <th style="width: 13%; text-align: center;">ESTADO</th>
                  <th style="width: 10%; text-align: right;">ACCIONES</th>
                </tr>
                </thead>
                <tbody id="accountTableBody">
                <c:forEach var="cta" items="${listaCuentas}">
                  <c:if test="${cta.idEmpleado != null && cta.numeroCuenta != 'ACCT-CONCENTRADORA' && cta.numeroCuenta != 'ACCT-MATRIZ' && !cta.nombreCuenta.toLowerCase().contains('concentradora') && !cta.nombreCuenta.toLowerCase().contains('matriz')}">
                    <tr class="account-row"
                        data-titular="${empty cta.nombreEmpleado ? '' : cta.nombreEmpleado.toLowerCase()}"
                        data-cuenta="${cta.nombreCuenta.toLowerCase()}"
                        data-estado="${cta.activo ? 'active' : 'inactive'}">
                      <td>
                        <div class="d-flex align-items-center gap-3">
                          <div class="rounded-circle d-flex align-items-center justify-content-center flex-shrink-0"
                               style="width: 36px; height: 36px; background: rgba(0, 229, 255, 0.1); color: #00E5FF; border: 1px solid rgba(0, 229, 255, 0.2);">
                            <i class="bi bi-person-fill fs-6"></i>
                          </div>
                          <div>
                            <div class="fw-semibold text-white">${empty cta.nombreEmpleado ? 'Empleado' : cta.nombreEmpleado}</div>
                            <div class="small text-muted" style="font-size: 11px; color: #64748B !important;">${cta.numeroCuenta}</div>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div class="fw-bold text-white text-uppercase" style="letter-spacing: 0.5px;">${cta.nombreCuenta}</div>
                        <div class="small text-muted" style="font-size: 11px; color: #64748B !important;">${cta.descripcion}</div>
                      </td>
                      <td style="text-align: right;" class="font-monospace text-cyan-neon fw-bold fs-6">
                        $<fmt:formatNumber value="${cta.saldo}" pattern="#,##0.00" />
                      </td>
                      <td style="text-align: center;">
                        <c:choose>
                          <c:when test="${cta.activo}">
                          <span class="badge px-3 py-1 rounded-pill font-monospace"
                                style="background: rgba(0, 229, 255, 0.1); color: #00E5FF; border: 1px solid rgba(0, 229, 255, 0.3); font-size: 10px; letter-spacing: 0.5px;">
                            ACTIVO
                          </span>
                          </c:when>
                          <c:otherwise>
                          <span class="badge px-3 py-1 rounded-pill font-monospace"
                                style="background: rgba(239, 68, 68, 0.15); color: #EF4444; border: 1px solid rgba(239, 68, 68, 0.3); font-size: 10px; letter-spacing: 0.5px;">
                            INACTIVO
                          </span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td style="text-align: right;">
                        <div class="d-flex align-items-center justify-content-end gap-2">
                          <!-- Icono Editar -->
                          <button class="btn btn-sm text-muted p-1 border-0" type="button" title="Editar cuenta"
                                  data-bs-toggle="modal" data-bs-target="#modalRegistrarCuenta"
                                  onclick="prepararModalEditarCuenta('${cta.idCuenta}', '${cta.idEmpleado}', '${cta.nombreCuenta}', '${cta.descripcion}', '${cta.limiteAsignado}')">
                            <i class="bi bi-pencil fs-6" style="color: #64748B;"></i>
                          </button>
                          <!-- Dropdown de Acciones -->
                          <div class="dropstart d-inline-block">
                            <button class="btn btn-sm text-muted border-0 p-1 shadow-none" type="button" data-bs-toggle="dropdown" data-bs-popper-config='{"strategy":"fixed", "modifiers": [{"name": "offset", "options": {"offset": [0, 8]}}, {"name": "flip", "enabled": false}]}' aria-expanded="false" title="Opciones">
                              <i class="bi bi-three-dots-vertical fs-5" style="color: #94A3B8;"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-dark-figma">
                              <c:if test="${cta.activo}">
                                <li>
                                  <button type="button" class="dropdown-item d-flex align-items-center gap-2"
                                          data-bs-toggle="modal" data-bs-target="#modalDepositarEmpleado"
                                          onclick="prepararModalDeposito('${cta.idCuenta}', '${empty cta.nombreEmpleado ? 'Empleado' : cta.nombreEmpleado}', '${cta.nombreCuenta}')">
                                    <i class="bi bi-arrow-down-circle fs-6 text-cyan-neon"></i>
                                    <span>Depositar Fondos</span>
                                  </button>
                                </li>
                              </c:if>
                              <c:choose>
                                <c:when test="${cta.activo}">
                                  <li>
                                    <form action="${pageContext.request.contextPath}/admin/cambiar-estado-cuenta" method="POST" class="m-0">
                                      <input type="hidden" name="idCuenta" value="${cta.idCuenta}">
                                      <input type="hidden" name="accion" value="desactivar">
                                      <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                        <i class="bi bi-power fs-6"></i>
                                        <span>Desactivar</span>
                                      </button>
                                    </form>
                                  </li>
                                </c:when>
                                <c:otherwise>
                                  <li>
                                    <form action="${pageContext.request.contextPath}/admin/cambiar-estado-cuenta" method="POST" class="m-0">
                                      <input type="hidden" name="idCuenta" value="${cta.idCuenta}">
                                      <input type="hidden" name="accion" value="activar">
                                      <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                        <i class="bi bi-power fs-6 text-cyan-neon"></i>
                                        <span>Activar</span>
                                      </button>
                                    </form>
                                  </li>
                                </c:otherwise>
                              </c:choose>
                              <li>
                                <form action="${pageContext.request.contextPath}/admin/cambiar-estado-cuenta" method="POST" class="m-0"
                                      onsubmit="return confirm('¿Estás seguro de dar de baja la cuenta \'${cta.nombreCuenta}\'? El saldo disponible ($<fmt:formatNumber value="${cta.saldo}" pattern="#,##0.00"/>) se devolverá a la Cuenta Concentradora.');">
                                  <input type="hidden" name="idCuenta" value="${cta.idCuenta}">
                                  <input type="hidden" name="accion" value="dar_de_baja">
                                  <button type="submit" class="dropdown-item d-flex align-items-center gap-2 text-danger">
                                    <i class="bi bi-x-lg fs-6"></i>
                                    <span>Dar de baja</span>
                                  </button>
                                </form>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </c:if>
                </c:forEach>
                </tbody>
              </table>
            </div>

            <!-- Estado filtrado vacío -->
            <div id="emptyAccountFilterStateBlock" class="text-center py-5 d-none">
              <i class="bi bi-search text-muted fs-3 mb-2 d-block"></i>
              <h6 class="text-muted">No se encontraron cuentas coincidentes con la búsqueda</h6>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </div>
  </main>
</div>

<!-- Modales de Cuentas -->
<jsp:include page="modal-registrar-cuenta.jsp" />
<jsp:include page="modal-depositar-empleado.jsp" />

<!-- Bootstrap 5 JS Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>

<!-- Script de filtrado interactivo para Cuentas -->
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("searchCuentaInput");
    const selectEstado = document.getElementById("selectEstadoCuentaFilter");
    const rows = document.querySelectorAll(".account-row");
    const emptyFilterBlock = document.getElementById("emptyAccountFilterStateBlock");

    function filterTable() {
      const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : "";
      const selectedState = selectEstado ? selectEstado.value : "all";
      let visibleCount = 0;

      rows.forEach(row => {
        const titular = row.getAttribute("data-titular") || "";
        const cuenta = row.getAttribute("data-cuenta") || "";
        const estado = row.getAttribute("data-estado") || "";

        const matchesSearch = titular.includes(searchTerm) || cuenta.includes(searchTerm);
        const matchesState = selectedState === "all" || estado === selectedState;

        if (matchesSearch && matchesState) {
          row.style.display = "";
          visibleCount++;
        } else {
          row.style.display = "none";
        }
      });

      if (emptyFilterBlock) {
        if (visibleCount === 0 && rows.length > 0) {
          emptyFilterBlock.classList.remove("d-none");
        } else {
          emptyFilterBlock.classList.add("d-none");
        }
      }
    }

    if (searchInput) searchInput.addEventListener("input", filterTable);
    if (selectEstado) selectEstado.addEventListener("change", filterTable);
  });
</script>
</body>
</html>