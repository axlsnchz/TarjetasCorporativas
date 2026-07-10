<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Gestión de Tarjetas</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons LOCAL -->
    <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts: Inter & Plus Jakarta Sans -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* Estilos base indispensables (Colores y fuentes Figma) */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0C0E12;
            color: #E2E2E8;
        }

        .font-jakarta {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        /* Paleta de colores específicos de Figma unificados */
        .bg-figma-card { background-color: #14171C !important; }
        .bg-figma-sidebar { background-color: #0C0E12 !important; }
        .bg-figma-input { background-color: #0D0F14 !important; }
        .bg-figma-select { background-color: #1E2024 !important; }

        .text-figma-cyan { color: #00DBE7 !important; }
        .text-figma-muted { color: #B9CACB !important; }
        .text-figma-gray { color: #64748B !important; }

        /* Efecto de desenfoque Figma */
        .backdrop-blur {
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }

        /* Luces ambientales traseras (Mismo estilo que Panel Principal) */
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

        /* Ajustes de navegación idénticos al Panel Principal */
        .sidebar-link {
            color: #B9CACB;
            border-left: 4px solid transparent;
            transition: all 0.2s ease;
        }
        .sidebar-link:hover {
            color: #00DBE7;
            background: rgba(255, 255, 255, 0.02);
        }
        .sidebar-link.active {
            background: rgba(112, 0, 255, 0.12);
            border-left-color: #00DBE7;
            color: #00DBE7;
            font-weight: 500;
            box-shadow: -4px 0px 15px -2px rgba(0, 219, 231, 0.2);
        }

        /* Estilización de Inputs y Selects oscuros manteniendo el Look UI */
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
        .form-select-dark {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%236B7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
        }

        /* Responsividad para Header y Main Content en Móviles */
        @media (max-width: 767.98px) {
            .top-header {
                left: 0 !important;
            }
            main {
                margin-left: 0 !important;
                padding: 95px 20px 40px 20px !important;
            }
        }
    </style>
</head>
<body class="overflow-x-hidden min-vh-100">

<div class="d-flex min-vh-100 position-relative">
    <!-- Luz de fondo ambiental -->
    <div class="dashboard-glow" style="left: 30%; top: 20%;"></div>

    <!-- BARRA LATERAL (SIDEBAR) - Estandarizada y Responsiva -->
    <jsp:include page="sidebar.jsp" />

    <!-- CONTENIDO PRINCIPAL -->
    <main class="flex-grow-1 position-relative" style="margin-left: 260px; padding: 115px 40px 40px 40px; z-index: 1;">

        <!-- HEADER FIJO (Con botón de hamburguesa responsivo integrado) -->
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
                <h2 class="fw-bold display-6" style="color: #E1FDFF;">Gestión de Tarjetas</h2>
                <p class="text-figma-muted m-0 fs-6 opacity-75">Gestiona y da de alta tarjetas para tus cuentas institucionales.</p>
            </div>
        </div>

        <!-- BARRA DE BÚSQUEDA Y FILTRADO -->
        <div class="bg-figma-card rounded-4 p-3 mb-4 border backdrop-blur font-jakarta" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <form class="row g-3 align-items-end">
                <!-- Buscar Tarjeta -->
                <div class="col-12 col-md-8 col-lg-9">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">Buscar tarjeta</label>
                    <div class="input-group rounded-2 overflow-hidden">
                        <span class="input-group-text bg-figma-input border-0 text-secondary px-3"><i class="bi bi-credit-card"></i></span>
                        <input type="text" class="form-control form-control-dark bg-figma-input py-2 text-figma-muted border-0 shadow-none" placeholder="Alias de la tarjeta...">
                    </div>
                </div>
                <!-- Estado Select -->
                <div class="col-12 col-md-4 col-lg-3">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">Estado</label>
                    <select class="form-select form-select-dark bg-figma-select py-2 border-0 text-white shadow-none">
                        <option selected>Todos los estados</option>
                        <option value="1">Activas</option>
                        <option value="2">Inactivas</option>
                        <option value="3">Bloqueadas</option>
                    </select>
                </div>
            </form>
        </div>

        <!-- REJILLA PRINCIPAL DE CONTENIDO -->
        <div class="row g-4 font-jakarta">

            <!-- COLUMNA IZQUIERDA: Lista de Tarjetas (Empty State) -->
            <div class="col-12 col-xl-8">
                <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 min-vh-50 backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
                    <h3 class="fw-semibold text-white mb-5 fs-5">Mis tarjetas</h3>

                    <!-- Contenedor del Estado Vacío -->
                    <div class="d-flex flex-column align-items-center justify-content-center text-center my-auto py-5">
                        <div class="position-relative mb-4 text-secondary opacity-50">
                            <i class="bi bi-wallet2 display-1"></i>
                            <i class="bi bi-plus-circle-fill position-absolute bottom-0 end-0 text-figma-cyan fs-3 bg-dark rounded-circle"></i>
                        </div>
                        <h4 class="h5 text-light fw-normal mb-2">No tienes tarjetas registradas aún.</h4>
                        <p class="text-figma-muted small mx-auto" style="max-width: 380px;">Dales de alta para empezar a gestionar tus gastos institucionales.</p>
                    </div>
                </div>
            </div>

            <!-- COLUMNA DERECHA: Detalle Lateral (Empty State) -->
            <div class="col-12 col-xl-4">
                <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
                    <h3 class="fw-semibold text-white mb-5 fs-5">Detalles de la tarjeta</h3>

                    <!-- Contenedor del Estado Vacío del Detalle -->
                    <div class="d-flex flex-column align-items-center justify-content-center text-center my-auto py-5">
                        <div class="mb-4 text-secondary opacity-25">
                            <i class="bi bi-credit-card-2-front" style="font-size: 5rem;"></i>
                        </div>
                        <h4 class="h6 text-light fw-medium mb-2">Selecciona una tarjeta</h4>
                        <p class="text-figma-muted small mx-auto" style="max-width: 250px;">Los detalles de la tarjeta seleccionada se mostrarán aquí.</p>
                    </div>
                </div>
            </div>

        </div>

    </main>
</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>