<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    com.example.tarjetascorporativas.model.Usuario uLogueado = (com.example.tarjetascorporativas.model.Usuario) session.getAttribute("usuarioLogueado");
    if (uLogueado == null) {
        com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();
        java.util.List<com.example.tarjetascorporativas.model.Usuario> emps = uDao.getEmpleados();
        if (!emps.isEmpty()) {
            uLogueado = emps.get(0);
        } else {
            uLogueado = new com.example.tarjetascorporativas.model.Usuario();
            uLogueado.setIdUsuario(1L);
            uLogueado.setNombre("Empleado General");
            uLogueado.setCorreo("empleado@fintechcorp.com");
            uLogueado.setNombreCargo("Analista Corporativo");
            uLogueado.setNombreDepartamento("Finanzas");
            uLogueado.setRol("EMPLEADO");
        }
        session.setAttribute("usuarioLogueado", uLogueado);
    } else {
        // Garantizar que los nombres de Cargo y Departamento estén actualizados desde la BD
        if (uLogueado.getNombreCargo() == null || uLogueado.getNombreDepartamento() == null) {
            com.example.tarjetascorporativas.model.dao.UsuarioDao uDao = new com.example.tarjetascorporativas.model.dao.UsuarioDao();
            com.example.tarjetascorporativas.model.Usuario uCompleto = uDao.getById(uLogueado.getIdUsuario());
            if (uCompleto != null) {
                uLogueado = uCompleto;
                session.setAttribute("usuarioLogueado", uLogueado);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Configuración</title>

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
        .bg-figma-sidebar { background-color: #0C0E12 !important; }
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

        /* Estilización de Inputs oscuros */
        .form-control-dark {
            border: 1px solid rgba(255, 255, 255, 0.05);
            color: #ffffff;
            background-color: #1E2024;
        }
        .form-control-dark:focus {
            background-color: #1E2024;
            border-color: #00DBE7;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 219, 231, 0.15);
        }
        .form-control-dark:disabled, .form-control-dark[readonly] {
            background-color: #141619;
            color: #E2E2E8;
            border-color: rgba(255, 255, 255, 0.04);
            opacity: 0.9;
        }

        /* Botón de acción principal Cyan */
        .btn-figma-cyan {
            background-color: #00DBE7 !important;
            color: #002022 !important;
            font-weight: 700;
            border: none;
            transition: all 0.2s ease;
        }
        .btn-figma-cyan:hover {
            background-color: #00b4bf !important;
            box-shadow: 0 0 20px rgba(0, 219, 231, 0.4);
        }

        /* Contenedor informativo de seguridad */
        .security-info-box {
            background-color: rgba(40, 42, 44, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.05);
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

        <!-- CABECERA DE LA VISTA -->
        <div class="row mb-4 font-jakarta">
            <div class="col-12">
                <h2 class="fw-bold display-6 text-white mb-2">Configuración</h2>
                <p class="text-figma-muted m-0 fs-6">Administra tu identidad digital y protocolos de seguridad institucional.</p>
            </div>
        </div>

        <!-- MENSAJES DE ALERTA (ÉXITO / ERROR) -->
        <c:if test="${not empty sessionScope.mensajeExito}">
            <div class="alert alert-success alert-dismissible fade show bg-success bg-opacity-10 text-success border-success border-opacity-25 rounded-3 mb-4 font-jakarta" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.mensajeExito}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("mensajeExito"); %>
        </c:if>

        <c:if test="${not empty sessionScope.mensajeError}">
            <div class="alert alert-danger alert-dismissible fade show bg-danger bg-opacity-10 text-danger border-danger border-opacity-25 rounded-3 mb-4 font-jakarta" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.mensajeError}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("mensajeError"); %>
        </c:if>

        <!-- CONTENEDOR DE OPCIONES EN REJILLA -->
        <div class="row g-4 font-jakarta">

            <!-- COLUMNA IZQUIERDA: IDENTIDAD DIGITAL (DATOS REGISTRADOS DEL EMPLEADO) -->
            <div class="col-12 col-xl-7">
                <div class="card bg-figma-card rounded-4 p-4 h-100 border" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">

                    <!-- Bloque de Perfil / Avatar con Datos Dinámicos -->
                    <div class="d-flex align-items-center gap-4 mb-5">
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioLogueado.urlFoto}">
                                <img src="${sessionScope.usuarioLogueado.urlFoto}" alt="Avatar" class="rounded-circle border border-2 border-info object-fit-cover" style="width: 80px; height: 80px;">
                            </c:when>
                            <c:otherwise>
                                <div class="position-relative d-flex align-items-center justify-content-center bg-opacity-10 rounded-circle border border-2 border-info"
                                     style="width: 80px; height: 80px; background-color: rgba(0, 219, 231, 0.1);">
                                    <i class="bi bi-person text-figma-cyan" style="font-size: 2.5rem;"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div>
                            <h3 class="text-white h5 fw-semibold mb-1">${sessionScope.usuarioLogueado.nombre}</h3>
                            <span class="text-figma-cyan small fw-medium">
                                ${empty sessionScope.usuarioLogueado.nombreCargo ? 'Empleado' : sessionScope.usuarioLogueado.nombreCargo}
                                ${empty sessionScope.usuarioLogueado.nombreDepartamento ? '' : ' • '.concat(sessionScope.usuarioLogueado.nombreDepartamento)}
                            </span>
                        </div>
                    </div>

                    <!-- Campos de Identidad Dinámicos del Empleado (Read-Only) -->
                    <div class="row g-4">
                        <!-- Nombre Completo -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Nombre Completo</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none" value="${sessionScope.usuarioLogueado.nombre}" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Correo Electrónico -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Correo Electrónico</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="email" class="form-control form-control-dark py-2.5 shadow-none" value="${sessionScope.usuarioLogueado.correo}" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Número de Identificación (ID Empleado) -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Número de Identificación</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none font-monospace" value="EMP-<fmt:formatNumber value='${sessionScope.usuarioLogueado.idUsuario}' pattern='000' />" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Rol Institucional -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Rol Institucional</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none" value="${empty sessionScope.usuarioLogueado.rol ? 'EMPLEADO' : sessionScope.usuarioLogueado.rol}" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Cargo -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Cargo</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none" value="${empty sessionScope.usuarioLogueado.nombreCargo ? 'Sin cargo asignado' : sessionScope.usuarioLogueado.nombreCargo}" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Departamento -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Departamento</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none" value="${empty sessionScope.usuarioLogueado.nombreDepartamento ? 'Sin departamento asignado' : sessionScope.usuarioLogueado.nombreDepartamento}" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <!-- COLUMNA DERECHA: SEGURIDAD / CAMBIAR CONTRASEÑA -->
            <div class="col-12 col-xl-5">
                <div class="card bg-figma-card rounded-4 p-4 h-100 border" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">

                    <div class="d-flex align-items-center gap-2 mb-4">
                        <i class="bi bi-shield-lock text-figma-cyan fs-4"></i>
                        <h3 class="text-white h5 fw-semibold m-0">Cambiar Contraseña</h3>
                    </div>

                    <form class="d-flex flex-column gap-3" action="${pageContext.request.contextPath}/empleado/cambiar-password" method="POST">
                        <!-- Contraseña Actual -->
                        <div>
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Contraseña Actual</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="password" id="inputPassActual" name="passActual" class="form-control form-control-dark py-2.5 shadow-none border-end-0" placeholder="••••••••••••" required>
                                <button class="btn bg-figma-select text-figma-gray border-0 px-3" type="button" onclick="togglePassVisibility('inputPassActual', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Nueva Contraseña -->
                        <div>
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Nueva Contraseña</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="password" id="inputPassNueva" name="nuevaPassword" class="form-control form-control-dark py-2.5 shadow-none border-end-0" placeholder="••••••••••••" required>
                                <button class="btn bg-figma-select text-figma-gray border-0 px-3" type="button" onclick="togglePassVisibility('inputPassNueva', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Confirmar Nueva Contraseña -->
                        <div>
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Confirmar Nueva Contraseña</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="password" id="inputPassConfirm" name="confirmPassword" class="form-control form-control-dark py-2.5 shadow-none border-end-0" placeholder="••••••••••••" required>
                                <button class="btn bg-figma-select text-figma-gray border-0 px-3" type="button" onclick="togglePassVisibility('inputPassConfirm', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Botón de Envío -->
                        <div class="mt-3">
                            <button type="submit" class="btn btn-figma-cyan w-100 py-2.5 rounded-pill">
                                Actualizar Credenciales
                            </button>
                        </div>

                        <!-- Cuadro Informativo / Requerimientos -->
                        <div class="security-info-box rounded-3 p-3 d-flex gap-3 align-items-start mt-2">
                            <i class="bi bi-info-circle text-figma-cyan fs-5 mt-0.5"></i>
                            <p class="text-figma-muted small m-0 lh-base">
                                Tu contraseña debe tener al menos 8 caracteres e incluir al menos una letra y un número para mayor seguridad.
                            </p>
                        </div>
                    </form>

                </div>
            </div>

        </div>

    </main>
</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>

<script>
    function togglePassVisibility(inputId, btn) {
        const input = document.getElementById(inputId);
        const icon = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.className = 'bi bi-eye-slash';
        } else {
            input.type = 'password';
            icon.className = 'bi bi-eye';
        }
    }
</script>
</body>
</html>