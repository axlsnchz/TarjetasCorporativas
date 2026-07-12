<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Gestión de Empleados</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons LOCAL -->
    <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">
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
        .tracking-widest-custom {
            letter-spacing: 0.08rem;
        }
        .font-jakarta {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        /* Custom styles for inputs aligned with Figma */
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

    <!-- HEADER SUPERIOR GLOBAL (Corregido e Incorporado) -->
    <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
            style="height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
        <button class="btn d-md-none text-cyan-neon fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarAdmin" aria-controls="sidebarAdmin" aria-label="Abrir menú">
            <i class="bi bi-list"></i>
        </button>
        <i class="bi bi-person-circle text-cyan-neon fs-3 role-button" style="cursor: pointer;"></i>
    </header>

    <main class="flex-grow-1 p-4 p-md-5 pt-4">
        <div class="container-fluid p-0">

            <!-- Fila de Encabezado de Sección (Título y Acción) -->
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-4 mb-5">
                <div>
                    <h2 class="fw-semibold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Gestión de Empleados</h2>
                    <p class="text-muted m-0 mt-1" style="color: #B9CACB !important;">Administra y monitorea el acceso institucional de tu equipo.</p>
                </div>

                <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2 shadow-sm">
                    <i class="bi bi-person-plus-fill fs-5"></i>
                    <span>Registrar Empleado</span>
                </button>
            </div>

            <!-- Grid de Tarjetas de Indicadores (Métricas) -->
            <div class="row g-4 mb-4">
                <!-- Total Empleados -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm">
                        <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Total Empleados</span>
                        <h3 class="fw-semibold text-cyan-neon m-0 fs-2">0</h3>
                    </div>
                </div>
                <!-- Activos -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm">
                        <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Activos</span>
                        <h3 class="fw-semibold text-cyan-neon m-0 fs-2">0</h3>
                    </div>
                </div>
                <!-- Departamentos -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm">
                        <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Departamentos</span>
                        <h3 class="fw-semibold text-cyan-neon m-0 fs-2">0</h3>
                    </div>
                </div>
                <!-- Nuevos (Mes) -->
                <div class="col-sm-6 col-xl-3">
                    <div class="p-4 bg-figma-card shadow-sm">
                        <span class="d-block fw-bold text-muted text-uppercase tracking-widest-custom mb-2" style="font-size: 0.75rem; color: #B9CACB !important;">Nuevos (Mes)</span>
                        <h3 class="fw-semibold text-cyan-neon m-0 fs-2">0</h3>
                    </div>
                </div>
            </div>

            <!-- Barra de Herramientas (Filtros y Búsqueda) -->
            <div class="p-3 mb-4 rounded-4 shadow-sm" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">
                <div class="row g-3 align-items-center">
                    <!-- Buscador -->
                    <div class="col-10 col-md-8 col-lg-9 font-jakarta">
                        <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #64748B;">Buscar Empleado</label>
                        <div class="position-relative">
                            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #475569;"></i>
                            <input type="text" class="form-control form-figma-search ps-5 py-2" placeholder="Nombre del empleado...">
                        </div>
                    </div>
                    <!-- Filtro Estado -->
                    <div class="col-2 col-md-4 col-lg-3 font-jakarta">
                        <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #64748B;">Estado</label>
                        <select class="form-select form-figma-select py-2 shadow-none">
                            <option selected value="all">Todos los estados</option>
                            <option value="active">Activos</option>
                            <option value="inactive">Inactivos</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Contenedor de Tabla con Estado Vacío -->
            <div class="row">
                <div class="col-12">
                    <div class="bg-figma-card p-4 p-md-5 d-flex flex-column shadow-lg font-jakarta" style="min-height: 400px; background: #14171C;">

                        <!-- Encabezados de la Tabla CORREGIDOS (Color idéntico a los inputs y sin opacidad opaca) -->
                        <div class="row text-uppercase fw-bold pb-3 mb-5 border-bottom align-items-center d-none d-md-flex"
                             style="font-size: 0.68rem; letter-spacing: 1.5px; border-color: rgba(255,255,255,0.06) !important; color: #F5F5F5 !important;">
                            <div class="col-md-3">Empleado</div>
                            <div class="col-md-3">Correo Electrónico</div>
                            <div class="col-md-2">Departamento</div>
                            <div class="col-md-2">Estado</div>
                            <div class="col-md-2 text-end">Acciones</div>
                        </div>

                        <!-- Bloque Central de Estado Vacío -->
                        <div class="text-center my-auto py-5">
                            <div class="d-inline-flex align-items-center justify-content-center border rounded-3 mb-4"
                                 style="width: 48px; height: 48px; border-color: rgba(255, 255, 255, 0.15) !important; color: rgba(255, 255, 255, 0.35);">
                                <i class="bi bi-person-dash fs-4"></i>
                            </div>
                            <h5 class="fw-normal text-white mb-2" style="font-size: 1.4rem;">Aún no hay empleados registrados</h5>
                            <p class="small text-muted m-0 mx-auto" style="max-width: 440px; color: #737373 !important;">
                                Aún no se han agregado datos para mostrar en esta vista.
                            </p>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<!-- Bootstrap 5 JS Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>