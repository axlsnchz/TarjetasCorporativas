<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // Si las listas no están presentes en el request (ej. acceso directo al JSP), las cargamos automáticamente
    if (request.getAttribute("listaTarjetas") == null) {
        com.example.tarjetascorporativas.model.dao.TarjetaDao tDao = new com.example.tarjetascorporativas.model.dao.TarjetaDao();
        com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();
        com.example.tarjetascorporativas.model.dao.CuentaDao cDao = new com.example.tarjetascorporativas.model.dao.CuentaDao();

        java.util.List<com.example.tarjetascorporativas.model.Tarjeta> tarjetas = tDao.getTodasLasTarjetas();
        java.util.List<com.example.tarjetascorporativas.model.Usuario> empleados = uDao.getEmpleados();
        java.util.List<com.example.tarjetascorporativas.model.Cuenta> cuentas = cDao.getCuentasEmpleados();

        request.setAttribute("listaTarjetas", tarjetas);
        request.setAttribute("listaEmpleados", empleados);
        request.setAttribute("listaCuentas", cuentas);
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Gestión de Tarjetas</title>

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
      font-family: 'Plus Jakarta Sans', sans-serif;
      color: #E2E2E8;
      min-height: 100vh;
      overflow-y: scroll;
    }
    @media (min-width: 768px) {
      .main-content {
        margin-left: 260px;
      }
    }
    .bg-figma-card {
      background: #14171C;
      border: 1px solid rgba(255, 255, 255, 0.03);
      border-radius: 24px;
    }
    .btn-figma-neon {
      background: #00F2FF;
      border-radius: 32px;
      color: #002022;
      font-family: 'Inter', sans-serif;
      font-weight: 700;
      letter-spacing: 0.02rem;
      border: none;
      transition: all 0.2s ease;
    }
    .btn-figma-neon:hover {
      background: #00bfe7;
      color: #002022;
      transform: translateY(-1px);
    }
    .text-cyan-neon {
      color: #00DBE7 !important;
    }
    .font-inter {
      font-family: 'Inter', sans-serif;
    }
    .form-figma-search {
      background: #0D0F14 !important;
      border: 1px solid rgba(255, 255, 255, 0.05) !important;
      color: #F5F5F5 !important;
      border-radius: 8px !important;
      font-size: 0.85rem;
    }
    .form-figma-search::placeholder {
      color: #8BACB4;
    }
    .form-figma-select {
      background: #1E2024 url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%236B7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") no-repeat right 0.75rem center/10px 10px !important;
      border: 1px solid rgba(255, 255, 255, 0.05) !important;
      color: #FFFFFF !important;
      border-radius: 8px !important;
      font-size: 0.85rem;
    }
    .form-figma-input {
      background-color: #1E2024 !important;
      border: 1px solid rgba(255, 255, 255, 0.08) !important;
      color: #FFFFFF !important;
      caret-color: #00DBE7 !important;
      border-radius: 8px !important;
      font-size: 0.875rem;
    }
    .form-figma-input:focus {
      background-color: #1E2024 !important;
      color: #FFFFFF !important;
      border-color: #00DBE7 !important;
      box-shadow: 0 0 0 0.2rem rgba(0, 219, 231, 0.15) !important;
    }
    .text-muted {
      color: #BAC9CC !important;
    }
    .form-figma-search::placeholder {
      color: #8BACB4;
    }
    .form-figma-input::placeholder {
      color: #8BACB4 !important;
    }
    .backdrop-blur {
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
    }
    .card-row {
      transition: all 0.2s ease;
    }
    .card-row:hover {
      background: #1C2027 !important;
    }
    /* Estilos menú contextual Dropdown en tabla */
    .dropdown-menu-dark-custom {
      background-color: #14171C !important;
      border: 1px solid rgba(255, 255, 255, 0.1) !important;
      border-radius: 12px !important;
      box-shadow: 0 10px 25px rgba(0,0,0,0.5) !important;
    }
    .dropdown-menu-dark-custom .dropdown-item {
      color: #E2E2E8 !important;
      font-size: 0.85rem;
      padding: 8px 16px;
      transition: background 0.15s ease;
    }
    .dropdown-menu-dark-custom .dropdown-item:hover {
      background-color: rgba(0, 242, 255, 0.08) !important;
      color: #00F2FF !important;
    }
    .dropdown-menu-dark-custom .dropdown-item.text-danger:hover {
      background-color: rgba(239, 68, 68, 0.15) !important;
      color: #ef4444 !important;
    }
  </style>
</head>
<body>

<!-- SIDEBAR -->
<jsp:include page="sidebar-admin.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-content d-flex flex-column min-vh-100">

  <!-- HEADER SUPERIOR -->
  <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
          style="height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
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

      <!-- Fila de Encabezado (Título y Acción Principal) -->
      <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-4 mb-4">
        <div>
          <h2 class="fw-bold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Gestión de Tarjetas</h2>
          <p class="m-0 mt-2" style="color: #BAC9CC !important; font-weight: 500;">Control centralizado de tarjetas corporativas, límites y estados.</p>
        </div>

        <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2 shadow-sm"
                data-bs-toggle="modal" data-bs-target="#modalEmitirTarjeta" onclick="prepararModalEmitirTarjeta()">
          <i class="bi bi-plus-lg fw-bold"></i>
          <span>Emitir Nueva Tarjeta</span>
        </button>
      </div>

      <!-- Barra de Herramientas y Filtros (Búsqueda, Estado y Tipo) -->
      <div class="p-3 mb-4 rounded-4 shadow-sm" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">
        <div class="row g-3 align-items-center">
          <!-- Buscador -->
          <div class="col-12 col-md-6">
            <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #BAC9CC !important;">Buscar tarjeta</label>
            <div class="position-relative">
              <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #BAC9CC;"></i>
              <input type="text" id="searchTarjetaInput" class="form-control form-figma-search ps-5 py-2" placeholder="Nombre del empleado o alias de la tarjeta...">
            </div>
          </div>
          <!-- Filtro Estado -->
          <div class="col-6 col-md-3">
            <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #BAC9CC !important;">Estado</label>
            <select id="selectEstadoFilter" class="form-select form-figma-select py-2 shadow-none">
              <option selected value="all">Todos los estados</option>
              <option value="active">Activas</option>
              <option value="blocked">Inactivas</option>
            </select>
          </div>
          <!-- Filtro Tipo -->
          <div class="col-6 col-md-3">
            <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #BAC9CC !important;">Tipo</label>
            <select id="selectTipoFilter" class="form-select form-figma-select py-2 shadow-none">
              <option selected value="all">Todos los tipos</option>
              <option value="FISICA">Física</option>
              <option value="VIRTUAL">Virtual</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Contenedor Principal (Tabla de Tarjetas o Estado Vacío) -->
      <div class="row">
        <div class="col-12">
          <div class="bg-figma-card p-4 p-md-5 d-flex flex-column shadow-lg font-inter" style="min-height: 480px;">

            <c:choose>
              <c:when test="${empty listaTarjetas}">
                <!-- Bloque Central de Estado Vacío -->
                <div class="my-auto py-5 text-center">
                  <div class="position-relative d-inline-block mb-4">
                    <div class="d-flex align-items-center justify-content-center border rounded-3"
                         style="width: 80px; height: 56px; border-color: #334155 !important; color: #334155;">
                      <i class="bi bi-credit-card-2-front fs-2"></i>
                    </div>
                    <span class="position-absolute bottom-0 end-0 translate-middle border border-dark rounded-circle bg-dark d-flex align-items-center justify-content-center"
                          style="width: 24px; height: 24px; margin-bottom: -10px; margin-right: -10px;">
                        <i class="bi bi-plus-circle-fill text-muted" style="font-size: 0.85rem;"></i>
                    </span>
                  </div>

                  <h4 class="fw-bold text-white mb-3" style="font-size: 1.5rem;">No hay tarjetas corporativas emitidas aún</h4>
                  <p class="small mx-auto mb-4" style="max-width: 480px; color: #BAC9CC !important; line-height: 1.6;">
                    Para comenzar a controlar los límites y gastos de tu equipo, necesitas emitir tu primera tarjeta física o virtual.
                  </p>

                  <button class="btn btn-figma-neon px-4 py-2 fw-semibold shadow-sm text-dark font-inter"
                          style="font-size: 0.875rem;" data-bs-toggle="modal" data-bs-target="#modalEmitirTarjeta">
                    Emitir Nueva Tarjeta
                  </button>
                </div>
              </c:when>

              <c:otherwise>
                <!-- ENCABEZADOS DE LA TABLA EXACTOS DE FIGMA -->
                <div class="row text-uppercase fw-bold pb-3 mb-3 border-bottom align-items-center d-none d-md-flex"
                     style="font-size: 11px; letter-spacing: 1px; border-color: rgba(255, 255, 255, 0.05) !important; color: #BAC9CC !important;">
                  <div class="col-md-3"><i class="bi bi-person me-1"></i>TITULAR & DETALLES</div>
                  <div class="col-md-2"><i class="bi bi-tag me-1"></i>ALIAS</div>
                  <div class="col-md-2"><i class="bi bi-bank me-1"></i>CUENTA</div>
                  <div class="col-md-2"><i class="bi bi-credit-card-2-front me-1"></i>TIPO</div>
                  <div class="col-md-2"><i class="bi bi-info-circle me-1"></i>ESTADO</div>
                  <div class="col-md-1 text-end"><i class="bi bi-gear me-1"></i>ACCIONES</div>
                </div>

                <!-- LISTADO DINÁMICO DE TARJETAS -->
                <div id="cardListContainer" class="d-flex flex-column gap-2">
                  <c:forEach var="tj" items="${listaTarjetas}">
                    <div class="row align-items-center py-3 px-3 rounded-3 card-row"
                         data-titular="${empty tj.nombreEmpleado ? 'empleado' : tj.nombreEmpleado.toLowerCase()}"
                         data-alias="${empty tj.alias ? '' : tj.alias.toLowerCase()}"
                         data-estado="${tj.activo ? 'active' : 'blocked'}"
                         data-tipo="${empty tj.tipoTarjeta ? 'VIRTUAL' : tj.tipoTarjeta.toUpperCase()}"
                         style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">

                      <!-- TITULAR & DETALLES -->
                      <div class="col-12 col-md-3 mb-2 mb-md-0 d-flex align-items-center gap-3">
                        <div class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold overflow-hidden flex-shrink-0"
                             style="width: 40px; height: 40px; background: linear-gradient(135deg, #1e293b, #00dbe7); color: #0c0e12 !important; font-size: 14px;">
                          <c:choose>
                            <c:when test="${not empty tj.urlFoto}">
                              <img src="${tj.urlFoto}" alt="${tj.nombreEmpleado}" class="w-100 h-100 object-fit-cover">
                            </c:when>
                            <c:otherwise>
                              ${empty tj.nombreEmpleado ? 'T' : tj.nombreEmpleado.substring(0, 1).toUpperCase()}
                            </c:otherwise>
                          </c:choose>
                        </div>
                        <div>
                          <div class="fw-semibold text-white" style="font-size: 0.95rem;">
                            ${empty tj.nombreEmpleado ? 'Sin Asignar' : tj.nombreEmpleado}
                          </div>
                          <div class="small" style="font-size: 0.78rem; color: #BAC9CC !important;">
                            <c:out value="${tj.nombreCargo}" default="Cargo" /> • <c:out value="${tj.nombreDepartamento}" default="Corporativo" />
                          </div>
                        </div>
                      </div>

                      <!-- ALIAS -->
                      <div class="col-12 col-md-2 mb-2 mb-md-0 text-white font-monospace" style="font-size: 0.875rem;">
                        <c:out value="${tj.alias}" default="Tarjeta" />
                      </div>

                      <!-- CUENTA -->
                      <div class="col-12 col-md-2 mb-2 mb-md-0 text-uppercase fw-semibold" style="font-size: 0.85rem; color: #CBD5E1;">
                        <c:out value="${tj.nombreCuenta}" default="PRINCIPAL" />
                      </div>

                      <!-- TIPO -->
                      <div class="col-12 col-md-2 mb-2 mb-md-0 d-flex align-items-center gap-2" style="font-size: 0.85rem; color: #CBD5E1;">
                        <c:choose>
                          <c:when test="${tj.tipoTarjeta eq 'FISICA'}">
                            <i class="bi bi-credit-card-2-front fs-6 text-cyan-neon"></i>
                            <span>Física</span>
                          </c:when>
                          <c:otherwise>
                            <i class="bi bi-phone fs-6 text-cyan-neon"></i>
                            <span>Virtual</span>
                          </c:otherwise>
                        </c:choose>
                      </div>

                      <!-- ESTADO BADGE -->
                      <div class="col-12 col-md-2 mb-2 mb-md-0">
                        <c:choose>
                          <c:when test="${tj.activo}">
                            <span class="badge px-3 py-1.5 rounded-pill font-monospace"
                                  style="background: rgba(0, 242, 255, 0.12); color: #00F2FF; border: 1px solid rgba(0, 242, 255, 0.3); font-size: 0.68rem; letter-spacing: 0.05rem;">
                              ACTIVA
                            </span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge px-3 py-1.5 rounded-pill font-monospace"
                                  style="background: rgba(239, 68, 68, 0.12); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); font-size: 0.68rem; letter-spacing: 0.05rem;">
                              INACTIVA
                            </span>
                          </c:otherwise>
                        </c:choose>
                      </div>

                      <!-- ACCIONES MENU -->
                      <div class="col-12 col-md-1 text-end d-flex align-items-center justify-content-end gap-2">
                        <!-- Icono Editar -->
                        <button class="btn btn-sm text-muted p-1 border-0" type="button" title="Editar tarjeta" data-bs-toggle="modal" data-bs-target="#modalEmitirTarjeta"
                                onclick="prepararModalEditarTarjeta('${tj.idTarjeta}', '${tj.idEmpleado}', '${tj.idCuenta}', '${tj.tipoTarjeta}', '${tj.alias}', '${tj.numeroTarjeta}', '${tj.cvv}', '${tj.fechaExpiracion}')">
                          <i class="bi bi-pencil fs-6" style="color: #BAC9CC;"></i>
                        </button>
                        <!-- Dropdown de Acciones -->
                        <div class="dropdown">
                          <button class="btn btn-sm text-muted p-1 border-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-three-dots-vertical fs-5" style="color: #BAC9CC;"></i>
                          </button>
                          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark-custom py-2">
                            <c:choose>
                              <c:when test="${tj.activo}">
                                <li>
                                  <form action="${pageContext.request.contextPath}/admin/cambiar-estado-tarjeta" method="POST" class="m-0">
                                    <input type="hidden" name="idTarjeta" value="${tj.idTarjeta}">
                                    <input type="hidden" name="accion" value="desactivar">
                                    <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                      <i class="bi bi-power text-warning"></i>
                                      <span>Desactivar</span>
                                    </button>
                                  </form>
                                </li>
                              </c:when>
                              <c:otherwise>
                                <li>
                                  <form action="${pageContext.request.contextPath}/admin/cambiar-estado-tarjeta" method="POST" class="m-0">
                                    <input type="hidden" name="idTarjeta" value="${tj.idTarjeta}">
                                    <input type="hidden" name="accion" value="activar">
                                    <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                      <i class="bi bi-check-circle text-success"></i>
                                      <span>Activar</span>
                                    </button>
                                  </form>
                                </li>
                              </c:otherwise>
                            </c:choose>
                            <li><hr class="dropdown-divider my-1" style="border-color: rgba(255, 255, 255, 0.08);"></li>
                            <li>
                              <form action="${pageContext.request.contextPath}/admin/cambiar-estado-tarjeta" method="POST" class="m-0">
                                <input type="hidden" name="idTarjeta" value="${tj.idTarjeta}">
                                <input type="hidden" name="accion" value="dar_de_baja">
                                <button type="submit" class="dropdown-item text-danger d-flex align-items-center gap-2">
                                  <i class="bi bi-x-circle"></i>
                                  <span>Dar de baja</span>
                                </button>
                              </form>
                            </li>
                          </ul>
                        </div>
                      </div>

                    </div>
                  </c:forEach>
                </div>

                <!-- Mensaje sin resultados por filtro -->
                <div id="emptyTarjetaFilterBlock" class="text-center py-5 d-none">
                  <i class="bi bi-search text-muted fs-3 mb-2 d-block"></i>
                  <h6 class="text-muted">No se encontraron tarjetas coincidentes con la búsqueda</h6>
                </div>
              </c:otherwise>
            </c:choose>

          </div>
        </div>
      </div>

    </div>
  </main>
</div>

<!-- Modal Ventana Emergente para Emitir Tarjeta -->
<jsp:include page="modal-emitir-tarjeta.jsp" />

<!-- Bootstrap 5 JS Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>

<!-- Script de Filtrado Interactivo -->
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("searchTarjetaInput");
    const selectEstado = document.getElementById("selectEstadoFilter");
    const selectTipo = document.getElementById("selectTipoFilter");
    const rows = document.querySelectorAll(".card-row");
    const emptyFilterBlock = document.getElementById("emptyTarjetaFilterBlock");

    function filterTable() {
      const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : "";
      const selectedState = selectEstado ? selectEstado.value : "all";
      const selectedTipo = selectTipo ? selectTipo.value : "all";
      let visibleCount = 0;

      rows.forEach(row => {
        const titular = row.getAttribute("data-titular") || "";
        const alias = row.getAttribute("data-alias") || "";
        const estado = row.getAttribute("data-estado") || "";
        const tipo = row.getAttribute("data-tipo") || "";

        const matchesSearch = titular.includes(searchTerm) || alias.includes(searchTerm);
        const matchesState = selectedState === "all" || estado === selectedState;
        const matchesTipo = selectedTipo === "all" || tipo === selectedTipo;

        if (matchesSearch && matchesState && matchesTipo) {
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
    if (selectTipo) selectTipo.addEventListener("change", filterTable);
  });
</script>

</body>
</html>