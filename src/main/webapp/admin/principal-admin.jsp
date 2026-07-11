<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Resumen General</title>

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
        .bg-figma-neon {
            background: #00F2FF;
            border-radius: 28px;
            color: #006A71;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .text-cyan-neon {
            color: #00DBE7;
        }
        .tracking-widest-custom {
            letter-spacing: 0.08rem;
        }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<jsp:include page="sidebar-admin.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-content d-flex flex-column min-vh-100">

    <main class="flex-grow-1 p-4 p-md-5">
        <div class="container-fluid p-0">

            <!-- Fila de Título y Avatar Superior -->
            <div class="d-flex justify-content-between align-items-center mb-5">
                <h2 class="fw-semibold text-white m-0" style="font-size: 2.6rem;">Resumen General</h2>

                <div class="d-flex align-items-center gap-3">
                    <!-- HEADER FIJO (Con botón de hamburguesa responsivo integrado) -->
                    <div class="position-fixed top-0 end-0 top-header d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
                         style="left: 260px; height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
                        <button class="btn d-md-none text-figma-cyan fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarUsuario" aria-controls="sidebarUsuario" aria-label="Abrir menú">
                            <i class="bi bi-list"></i>
                        </button>
                        <i class="bi bi-person-circle text-figma-cyan fs-3 role-button" style="cursor: pointer;"></i>
                    </div>
                    <!-- Avatar estilizado como el icono lineal de Figma -->
                    <div class="d-flex align-items-center justify-content-center border rounded-circle"
                         style="width: 42px; height: 42px; border-color: #00DBE7 !important; color: #00DBE7;">
                        <i class="bi bi-person-circle fs-4"></i>
                    </div>
                </div>
            </div>

            <!-- Bloque de Tarjetas Informativas -->
            <div class="row g-4 mb-5">
                <!-- Balance Corporativo -->
                <div class="col-xl-8 col-lg-12">
                    <div class="p-4 p-md-5 bg-figma-card h-100 d-flex flex-column justify-content-between">
                        <div>
                            <span class="d-block fw-bold text-muted tracking-widest-custom mb-3" style="font-size: 0.75rem; color: #BACAC5 !important;">BALANCE TOTAL CORPORATIVO</span>
                            <div class="d-flex align-items-baseline gap-2 mb-4">
                                <h3 class="display-4 fw-bold m-0 text-white">$0.0</h3>
                                <span class="fs-4 fw-semibold text-cyan-neon">MXN</span>
                            </div>
                        </div>

                        <!-- Sub-métricas horizontales limpias -->
                        <div class="row g-3 pt-3">
                            <div class="col-4">
                                <span class="d-block text-uppercase fw-bold text-muted small tracking-wider mb-1" style="font-size: 0.65rem;">Cuentas Activas</span>
                                <span class="fs-4 fw-bold text-white">0</span>
                            </div>
                            <div class="col-4">
                                <span class="d-block text-uppercase fw-bold text-muted small tracking-wider mb-1" style="font-size: 0.65rem;">Tarjetas Emitidas</span>
                                <span class="fs-4 fw-bold text-white">0</span>
                            </div>
                            <div class="col-4">
                                <span class="d-block text-uppercase fw-bold text-muted small tracking-wider mb-1" style="font-size: 0.65rem;">Valor en Tránsito</span>
                                <span class="fs-4 fw-bold text-cyan-neon">$0.0</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Límite de Crédito Corporativo -->
                <div class="col-xl-4 col-lg-12">
                    <div class="p-4 p-md-5 bg-figma-neon h-100 d-flex flex-column justify-content-between" style="min-height: 240px;">
                        <div>
                            <h4 class="fw-bold tracking-wider lh-sm m-0" style="font-size: 2.1rem; font-family: 'Plus Jakarta Sans', sans-serif;">LÍMITE DE <br>CRÉDITO</h4>
                        </div>
                        <div>
                            <span class="fs-3 fw-bold d-block mb-3" style="font-family: 'Plus Jakarta Sans', sans-serif;">0% Utilizado</span>
                            <div class="progress bg-dark bg-opacity-10" style="height: 6px; border-radius: 9999px;">
                                <div class="progress-bar" role="progressbar" style="width: 0%; background-color: #006A71;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cabecera de Transacciones -->
            <div class="row mb-3">
                <div class="col-12 d-flex justify-content-between align-items-center">
                    <h4 class="fs-4 fw-semibold text-white m-0">Últimas transacciones</h4>

                    <!-- Selector de Filtrado -->
                    <div class="d-flex align-items-center gap-2">
                        <span class="text-muted d-none d-sm-inline" style="font-size: 0.75rem;">Filtrar todas las transacciones</span>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-dark dropdown-toggle px-3 border-0 text-white-50" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="background: #14161c; font-size: 0.85rem;">
                                Todas
                            </button>
                            <ul class="dropdown-menu dropdown-menu-dark">
                                <li><a class="dropdown-item active" href="#">Todas</a></li>
                                <li><a class="dropdown-item" href="#">Completadas</a></li>
                                <li><a class="dropdown-item" href="#">Fallidas</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contenedor Oscuro de la Tabla y Estado Vacío -->
            <div class="row">
                <div class="col-12">
                    <div class="bg-figma-card p-4 p-md-5 d-flex flex-column shadow-lg" style="min-height: 400px; background: #111317;">

                        <!-- Encabezados integrados exactamente dentro del contenedor -->
                        <div class="row text-uppercase fw-bold text-muted pb-3 mb-5 border-bottom" style="font-size: 0.65rem; letter-spacing: 1.5px; border-color: rgba(255,255,255,0.04) !important; opacity: 0.6;">
                            <div class="col-3 text-start">Concepto</div>
                            <div class="col-3 text-center">Fecha</div>
                            <div class="col-3 text-center">Estado</div>
                            <div class="col-3 text-end">Monto</div>
                        </div>

                        <!-- Bloque Central de Estado Vacío -->
                        <div class="text-center my-auto py-4">
                            <div class="d-inline-flex align-items-center justify-content-center border rounded-3 mb-4"
                                 style="width: 48px; height: 48px; border-color: rgba(255, 255, 255, 0.15) !important; color: rgba(255, 255, 255, 0.25);">
                                <i class="bi bi-question-lg fs-4"></i>
                            </div>
                            <h5 class="fw-normal text-white-50 mb-2" style="font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.3rem;">Aún no hay transacciones registradas</h5>
                            <p class="small text-muted m-0 mx-auto" style="max-width: 420px; font-family: 'Plus Jakarta Sans', sans-serif;">Aún no se han agregado datos para mostrar en esta vista.</p>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<!-- Bootstrap 5 JavaScript Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>