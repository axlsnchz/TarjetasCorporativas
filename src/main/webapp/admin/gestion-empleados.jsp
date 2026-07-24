<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // Si la lista de empleados no está presente en el request (ej. acceso directo al JSP), la cargamos automáticamente
    if (request.getAttribute("listaEmpleados") == null) {
        com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();
        com.example.tarjetascorporativas.model.dao.DepartamentoDao dDao = new com.example.tarjetascorporativas.model.dao.DepartamentoDao();

        java.util.List<com.example.tarjetascorporativas.model.Usuario> lista = uDao.getTodosLosEmpleados();
        java.util.List<com.example.tarjetascorporativas.model.Departamento> deptos = dDao.getAll();

        long actCount = lista.stream().filter(com.example.tarjetascorporativas.model.Usuario::isActivo).count();

        java.util.Calendar calNow = java.util.Calendar.getInstance();
        int curMonth = calNow.get(java.util.Calendar.MONTH);
        int curYear = calNow.get(java.util.Calendar.YEAR);

        long nmCount = lista.stream().filter(u -> {
            if (u.getFechaCreacion() == null) return false;
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.setTime(u.getFechaCreacion());
            return cal.get(java.util.Calendar.MONTH) == curMonth && cal.get(java.util.Calendar.YEAR) == curYear;
        }).count();

        request.setAttribute("listaEmpleados", lista);
        request.setAttribute("totalEmpleados", lista.size());
        request.setAttribute("activosCount", actCount);
        request.setAttribute("deptosCount", deptos.size());
        request.setAttribute("nuevosMesCount", nmCount);
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Gestión de Empleados</title>

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
            border-radius: 28px;
        }
        .btn-figma-neon {
            background: #00F2FF;
            border-radius: 32px;
            color: #002022;
            font-family: 'Inter', sans-serif;
            font-weight: 700;
            letter-spacing: 0.04rem;
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
        .text-cyan-neon {
            color: #00DBE7 !important;
        }
        .tracking-widest-custom {
            letter-spacing: 0.08rem;
        }
        .font-jakarta {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .form-figma-search {
            background: #0D0F14 !important;
            border: 1px solid rgba(255, 255, 255, 0.05) !important;
            color: #F5F5F5 !important;
            border-radius: 8px !important;
            font-size: 0.85rem;
        }
        .text-muted {
            color: #BAC9CC !important;
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
            padding: 12px 16px !important;
            font-size: 14px !important;
        }
        .form-figma-input:focus {
            border-color: #00e5ff !important;
            box-shadow: 0 0 0 0.25rem rgba(0, 229, 255, 0.15) !important;
        }
        .form-figma-input::placeholder {
            color: #4b5563 !important;
        }
        .avatar-upload-box {
            width: 110px;
            height: 110px;
            background: rgba(11, 14, 20, 0.5);
            border: 2px solid #30363d;
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .avatar-badge-edit {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #00e5ff;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #0d1117;
        }
        .backdrop-blur {
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }
        .employee-row:hover {
            background: #1e222a !important;
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

    <!-- HEADER SUPERIOR GLOBAL VISIBLE -->
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

            <!-- Fila de Encabezado de Sección (Título y Acción) -->
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-4 mb-5">
                <div>
                    <h2 class="fw-semibold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Gestión de Empleados</h2>
                    <p class="text-muted m-0 mt-1" style="color: #B9CACB !important;">Administra y monitorea el acceso institucional de tu equipo.</p>
                </div>

                <!-- Botón que activa la ventana emergente Modal -->
                <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2 shadow-sm"
                        data-bs-toggle="modal" data-bs-target="#modalRegistrarEmpleado" onclick="prepararModalRegistrarEmpleado()">
                    <i class="bi bi-person-plus-fill fs-5"></i>
                    <span>Registrar Empleado</span>
                </button>
            </div>

            <!-- Grid de Tarjetas de Indicadores (Métricas Dinámicas) -->
            <div class="row g-4 mb-4">
                <!-- Total Empleados -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm d-flex justify-content-between align-items-center">
                        <div>
                            <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Total Empleados</span>
                            <h3 class="fw-semibold text-cyan-neon m-0 fs-2">${totalEmpleados}</h3>
                        </div>
                        <i class="bi bi-people-fill text-cyan-neon fs-2 opacity-75"></i>
                    </div>
                </div>
                <!-- Activos -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm d-flex justify-content-between align-items-center">
                        <div>
                            <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Activos</span>
                            <h3 class="fw-semibold text-cyan-neon m-0 fs-2">${activosCount}</h3>
                        </div>
                        <i class="bi bi-person-check-fill text-cyan-neon fs-2 opacity-75"></i>
                    </div>
                </div>
                <!-- Departamentos -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm d-flex justify-content-between align-items-center">
                        <div>
                            <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Departamentos</span>
                            <h3 class="fw-semibold text-cyan-neon m-0 fs-2">${deptosCount}</h3>
                        </div>
                        <i class="bi bi-building text-cyan-neon fs-2 opacity-75"></i>
                    </div>
                </div>
                <!-- Nuevos (Mes) -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm d-flex justify-content-between align-items-center">
                        <div>
                            <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Nuevos (Mes)</span>
                            <h3 class="fw-semibold text-cyan-neon m-0 fs-2">${nuevosMesCount}</h3>
                        </div>
                        <i class="bi bi-person-plus-fill text-cyan-neon fs-2 opacity-75"></i>
                    </div>
                </div>
            </div>

            <!-- Barra de Herramientas (Filtros y Búsqueda Interactiva) -->
            <div class="p-3 mb-4 rounded-4 shadow-sm" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">
                <div class="row g-3 align-items-center">
                    <!-- Buscador -->
                    <div class="col-12 col-md-8 col-lg-9 font-jakarta">
                        <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #BAC9CC !important;">Buscar Empleado</label>
                        <div class="position-relative">
                            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #BAC9CC;"></i>
                            <input type="text" id="searchEmpleadoInput" class="form-control form-figma-search ps-5 py-2" placeholder="Nombre o correo del empleado...">
                        </div>
                    </div>
                    <!-- Filtro Estado -->
                    <div class="col-12 col-md-4 col-lg-3 font-jakarta">
                        <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #BAC9CC !important;">Estado</label>
                        <select id="selectEstadoFilter" class="form-select form-figma-select py-2 shadow-none">
                            <option selected value="all">Todos los estados</option>
                            <option value="active">Activos</option>
                            <option value="inactive">Inactivos</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Contenedor de Tabla de Empleados -->
            <div class="row">
                <div class="col-12">
                    <div class="bg-figma-card p-4 p-md-5 d-flex flex-column shadow-lg font-jakarta" style="min-height: 400px; background: #14171C;">

                        <!-- ENCABEZADOS DE LA TABLA CONFIGURADOS EXACTAMENTE IGUAL A LA IMAGEN MUESTRA -->
                        <div class="row text-uppercase fw-bold pb-3 mb-4 border-bottom align-items-center d-none d-md-flex"
                             style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 10px; letter-spacing: 1.5px; border-color: rgba(255, 255, 255, 0.05) !important; color: #BAC9CC !important; background-color: transparent;">
                            <div class="col-md-3"><i class="bi bi-person me-1"></i>Empleado</div>
                            <div class="col-md-3"><i class="bi bi-envelope me-1"></i>Correo Electrónico</div>
                            <div class="col-md-2"><i class="bi bi-building me-1"></i>Departamento</div>
                            <div class="col-md-2"><i class="bi bi-info-circle me-1"></i>Estado</div>
                            <div class="col-md-2 text-end"><i class="bi bi-gear me-1"></i>Acciones</div>
                        </div>

                        <!-- LISTADO DINÁMICO DE EMPLEADOS -->
                        <c:choose>
                            <c:when test="${empty listaEmpleados}">
                                <!-- Estado Vacío -->
                                <div class="text-center my-auto py-5">
                                    <div class="d-inline-flex align-items-center justify-content-center border rounded-3 mb-4"
                                         style="width: 48px; height: 48px; border-color: rgba(255, 255, 255, 0.15) !important; color: rgba(255, 255, 255, 0.35);">
                                        <i class="bi bi-person-dash fs-4"></i>
                                    </div>
                                    <h5 class="fw-normal text-white mb-2" style="font-size: 1.4rem;">Aún no hay empleados registrados</h5>
                                    <p class="small text-muted m-0 mx-auto" style="max-width: 440px; color: #BAC9CC !important;">
                                        Haz clic en "Registrar Empleado" para agregar nuevos miembros al equipo.
                                    </p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div id="employeeListContainer" class="d-flex flex-column gap-2">
                                    <c:forEach var="emp" items="${listaEmpleados}">
                                        <div class="row align-items-center py-3 px-3 rounded-3 employee-row"
                                             data-nombre="${emp.nombre.toLowerCase()}"
                                             data-correo="${emp.correo.toLowerCase()}"
                                             data-estado="${emp.activo ? 'active' : 'inactive'}"
                                             style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04); transition: all 0.2s ease;">
                                            
                                            <!-- Empleado (Avatar, Nombre y Cargo) -->
                                            <div class="col-12 col-md-3 mb-2 mb-md-0 d-flex align-items-center gap-3">
                                                <div class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold overflow-hidden flex-shrink-0"
                                                     style="width: 40px; height: 40px; background: linear-gradient(135deg, #1e293b, #00dbe7); color: #0c0e12 !important; font-size: 14px;">
                                                    <c:choose>
                                                        <c:when test="${not empty emp.urlFoto}">
                                                            <img src="${emp.urlFoto}" alt="${emp.nombre}" class="w-100 h-100 object-fit-cover">
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${emp.nombre.substring(0, 1).toUpperCase()}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <div class="fw-semibold text-white" style="font-size: 0.95rem;">${emp.nombre}</div>
                                                    <div class="small" style="font-size: 0.78rem; color: #BAC9CC !important;">
                                                        ${empty emp.nombreCargo ? 'Empleado' : emp.nombreCargo}
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Correo Electrónico -->
                                            <div class="col-12 col-md-3 mb-2 mb-md-0 text-break" style="font-size: 0.85rem; color: #cbd5e1;">
                                                ${emp.correo}
                                            </div>

                                            <!-- Departamento -->
                                            <div class="col-12 col-md-2 mb-2 mb-md-0" style="font-size: 0.85rem; color: #cbd5e1;">
                                                ${empty emp.nombreDepartamento ? 'General' : emp.nombreDepartamento}
                                            </div>

                                            <!-- Estado Badge -->
                                            <div class="col-12 col-md-2 mb-2 mb-md-0">
                                                <c:choose>
                                                    <c:when test="${emp.activo}">
                                                        <span class="badge px-3 py-2 rounded-pill font-monospace"
                                                              style="background: rgba(0, 242, 255, 0.1); color: #00F2FF; border: 1px solid rgba(0, 242, 255, 0.3); font-size: 0.7rem; letter-spacing: 0.05rem;">
                                                            ACTIVO
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge px-3 py-2 rounded-pill font-monospace"
                                                              style="background: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); font-size: 0.7rem; letter-spacing: 0.05rem;">
                                                            INACTIVO
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Acciones -->
                                            <div class="col-12 col-md-2 text-md-end d-flex align-items-center justify-content-md-end gap-2">
                                                <!-- Icono Editar -->
                                                <button class="btn btn-sm text-muted p-1 border-0" type="button" title="Editar empleado"
                                                        data-bs-toggle="modal" data-bs-target="#modalRegistrarEmpleado"
                                                        data-id="${emp.idUsuario}"
                                                        data-nombre="<c:out value='${emp.nombre}'/>"
                                                        data-correo="<c:out value='${emp.correo}'/>"
                                                        data-depto="<c:out value='${emp.nombreDepartamento}'/>"
                                                        data-cargo="<c:out value='${emp.nombreCargo}'/>"
                                                        data-foto="<c:out value='${emp.urlFoto}'/>"
                                                        onclick="prepararModalEditarEmpleadoDesdeElemento(this)">
                                                    <i class="bi bi-pencil fs-6" style="color: #BAC9CC;"></i>
                                                </button>
                                                <!-- Dropdown de Acciones (3 puntos) -->
                                                <div class="dropdown">
                                                    <button class="btn btn-sm text-muted p-1 border-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bi bi-three-dots-vertical fs-5" style="color: #BAC9CC;"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark-custom py-2">
                                                        <c:choose>
                                                            <c:when test="${emp.activo}">
                                                                <li>
                                                                    <form action="${pageContext.request.contextPath}/admin/cambiar-estado-empleado" method="POST" class="m-0">
                                                                        <input type="hidden" name="idUsuario" value="${emp.idUsuario}">
                                                                        <input type="hidden" name="nuevoEstado" value="false">
                                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                                                            <i class="bi bi-power text-warning"></i>
                                                                            <span>Desactivar</span>
                                                                        </button>
                                                                    </form>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>
                                                                    <form action="${pageContext.request.contextPath}/admin/cambiar-estado-empleado" method="POST" class="m-0">
                                                                        <input type="hidden" name="idUsuario" value="${emp.idUsuario}">
                                                                        <input type="hidden" name="nuevoEstado" value="true">
                                                                        <button type="submit" class="dropdown-item d-flex align-items-center gap-2">
                                                                            <i class="bi bi-check-circle text-success"></i>
                                                                            <span>Activar</span>
                                                                        </button>
                                                                    </form>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Mensaje por si el filtro no encuentra resultados -->
                                <div id="emptyFilterStateBlock" class="text-center py-5 d-none">
                                    <i class="bi bi-search text-muted fs-3 mb-2 d-block"></i>
                                    <h6 class="text-muted">No se encontraron empleados coincidentes con la búsqueda</h6>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<!-- Ventana Emergente Modal Registrar Empleado -->
<jsp:include page="modal-registrar-empleado.jsp" />

<!-- Bootstrap 5 JS Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>

<!-- Script de filtrado interactivo -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById("searchEmpleadoInput");
        const selectEstado = document.getElementById("selectEstadoFilter");
        const rows = document.querySelectorAll(".employee-row");
        const emptyFilterBlock = document.getElementById("emptyFilterStateBlock");

        function filterTable() {
            const searchTerm = searchInput ? searchInput.value.toLowerCase().trim() : "";
            const selectedState = selectEstado ? selectEstado.value : "all";
            let visibleCount = 0;

            rows.forEach(row => {
                const name = row.getAttribute("data-nombre") || "";
                const email = row.getAttribute("data-correo") || "";
                const estado = row.getAttribute("data-estado") || "";

                const matchesSearch = name.includes(searchTerm) || email.includes(searchTerm);
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