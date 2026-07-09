<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Transferencias</title>

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

        @media (min-width: 768px) {
            nav {
                position: fixed !important;
                top: 0;
                start: 0;
                height: 100vh;
            }
        }

        .font-jakarta {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        /* Paleta de colores específicos de Figma unificados */
        .bg-figma-card { background-color: #14171C !important; }
        .bg-figma-sidebar { background-color: #0C0E12 !important; }
        .bg-figma-input { background-color: #0D0F14 !important; }
        .bg-figma-select { background-color: #1E2024 !important; }

        text-figma-cyan { color: #00DBE7 !important; }
        .text-figma-muted { color: #B9CACB !important; }
        .text-figma-gray { color: #64748B !important; }

        /* Efecto de desenfoque Figma */
        .backdrop-blur {
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }

        /* Luces ambientales traseras */
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

        /* Ajustes de navegación estandarizados */
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

        /* Estilización de Inputs y Selects oscuros */
        .form-control-dark, .form-select-dark {
            border: 1px solid rgba(255, 255, 255, 0.05);
            color: #ffffff;
            background-color: #1E2024;
        }
        .form-control-dark:focus, .form-select-dark:focus {
            background-color: #1E2024;
            border-color: #00DBE7;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(0, 219, 231, 0.15);
        }
        .form-select-dark {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%236B7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
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
    <div class="dashboard-glow" style="left: 25%; top: 15%;"></div>

    <!-- BARRA LATERAL (SIDEBAR) - Estandarizada y Responsiva -->
    <nav class="offcanvas-md offcanvas-start bg-figma-sidebar border-end py-4 backdrop-blur shadow"
         id="sidebarUsuario" tabindex="-1" aria-labelledby="sidebarUsuarioLabel"
         style="width: 260px; border-color: rgba(58, 73, 75, 0.15) !important; z-index: 1050;">

        <!-- Botón de cierre para móvil -->
        <div class="offcanvas-header d-md-none justify-content-end px-4 pt-2 pb-0">
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" data-bs-target="#sidebarUsuario" aria-label="Close"></button>
        </div>

        <div class="w-100">
            <!-- Brand / Logo -->
            <div class="px-4 mb-5">
                <h1 class="fw-bold lh-1 text-figma-cyan display-6">FinTech<br>Corp</h1>
                <div class="text-uppercase text-figma-muted fw-bold small tracking-wider" style="font-size: 0.7rem; letter-spacing: 0.6px;">
                    Banca Institucional
                </div>
            </div>

            <!-- Menú de navegación unificado -->
            <div class="d-flex flex-column gap-1 mt-4">
                <a href="principal-usuario.jsp" class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
                    <i class="bi bi-grid-1x2-fill fs-5"></i> <span>Panel principal</span>
                </a>
                <a href="gestion-cuentas-usuario.jsp" class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
                    <i class="bi bi-bank fs-5"></i> <span>Cuentas</span>
                </a>
                <a href="gestion-tarjetas-usuario.jsp" class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
                    <i class="bi bi-credit-card fs-5"></i> <span>Tarjetas</span>
                </a>
                <!-- Ítem Activo en esta vista -->
                <a href="gestion-transferencia-usuario.jsp" class="sidebar-link active d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
                    <i class="bi bi-arrow-left-right fs-5"></i> <span>Transferencias</span>
                </a>
                <a href="configuracion-usuario.jsp" class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
                    <i class="bi bi-gear fs-5"></i> <span>Configuración</span>
                </a>
            </div>
        </div>

        <!-- Botón de Cerrar Sesión -->
        <div class="px-4 w-100">
            <button class="btn w-100 py-2 text-center text-secondary border border-secondary bg-transparent rounded-3"
                    style="color: #BAC9CC !important; border-color: #3B494C !important;">
                Cerrar Sesión
            </button>
        </div>
    </nav>

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

        <!-- SECCIÓN: NUEVA TRANSFERENCIA -->
        <div class="card bg-figma-card rounded-4 p-4 mb-5 border font-jakarta" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <h2 class="fw-bold h3 text-white mb-4 font-jakarta">Nueva Transferencia</h2>

            <form class="row g-4">
                <!-- Cuenta Origen -->
                <div class="col-12 col-md-4">
                    <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Cuenta Origen</label>
                    <div class="input-group rounded-2 overflow-hidden">
                        <span class="input-group-text bg-figma-select border-0 text-figma-cyan px-3"><i class="bi bi-wallet2"></i></span>
                        <select class="form-select form-select-dark bg-figma-select py-2 border-0 shadow-none text-white fs-6">
                            <option selected disabled>Seleccionar cuenta de origen</option>
                            <option value="1">Cuenta Principal Corporativa</option>
                            <option value="2">Fondo de Contingencias</option>
                        </select>
                    </div>
                </div>

                <!-- Número de cuenta del empleado -->
                <div class="col-12 col-md-8">
                    <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Número de cuenta del empleado</label>
                    <div class="input-group rounded-2 overflow-hidden">
                        <span class="input-group-text border-0 text-secondary px-3" style="background-color: #1E2024;"><i class="bi bi-person-badge"></i></span>
                        <input type="text" class="form-control form-control-dark py-2 text-white border-0 shadow-none fs-6" placeholder="Nombre del empleado o DNI...">
                    </div>
                </div>

                <!-- Importe -->
                <div class="col-12 col-md-4">
                    <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Importe</label>
                    <div class="input-group rounded-2 overflow-hidden border border-secondary border-opacity-25">
                        <span class="input-group-text border-0 text-figma-cyan fw-bold fs-4 px-3" style="background-color: #0D0F14;">$</span>
                        <input type="text" class="form-control py-3 text-secondary border-0 shadow-none fw-bold fs-4" style="background-color: #0D0F14;" placeholder="0.00">
                    </div>
                </div>

                <!-- Concepto de Transferencia -->
                <div class="col-12 col-md-8">
                    <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Concepto de Transferencia</label>
                    <input type="text" class="form-control form-control-dark py-3 text-white border-0 shadow-none fs-6" placeholder="Ej: Pago de nómina extraordinario, Dietas...">
                </div>

                <!-- Botón de Ejecución -->
                <div class="col-12 mt-4">
                    <button type="submit" class="btn btn-figma-cyan w-100 py-3 rounded-pill d-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-shield-check fs-5"></i> Ejecutar Transferencia Segura
                    </button>
                </div>
            </form>
        </div>

        <!-- SECCIÓN: HISTORIAL DE TRANSFERENCIAS -->
        <div class="row mb-3">
            <div class="col-12">
                <h3 class="fw-semibold text-white fs-4 font-jakarta">Historial de Transferencias</h3>
            </div>
        </div>

        <!-- Barra de filtros del Historial -->
        <div class="bg-figma-card rounded-4 p-3 mb-4 border backdrop-blur font-jakarta" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <form class="row g-3 align-items-end">
                <!-- Buscar Titular -->
                <div class="col-12 col-md-6 col-lg-6">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">Buscar Titular</label>
                    <div class="input-group rounded-2 overflow-hidden">
                        <span class="input-group-text bg-figma-input border-0 text-secondary px-3"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control form-control-dark bg-figma-input py-2 text-figma-muted border-0 shadow-none" placeholder="Nombre del empleado...">
                    </div>
                </div>
                <!-- Estado -->
                <div class="col-12 col-md-3 col-lg-3">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">Estado</label>
                    <select class="form-select form-select-dark bg-figma-select py-2 border-0 text-white shadow-none">
                        <option selected>Todos los estados</option>
                        <option value="1">Completadas</option>
                        <option value="2">Pendientes</option>
                        <option value="3">Rechazadas</option>
                    </select>
                </div>
                <!-- Tipo -->
                <div class="col-12 col-md-3 col-lg-3">
                    <label class="text-figma-gray fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 10px; letter-spacing: 1px;">Tipo</label>
                    <select class="form-select form-select-dark bg-figma-select py-2 border-0 text-white shadow-none">
                        <option selected>Todos los tipos</option>
                        <option value="1">Nómina</option>
                        <option value="2">Dietas</option>
                        <option value="3">Otros</option>
                    </select>
                </div>
            </form>
        </div>

        <!-- Tabla / Estado Vacío Historial -->
        <div class="card bg-figma-card border-0 rounded-4 overflow-hidden backdrop-blur font-jakarta" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <div class="table-responsive">
                <table class="table table-dark table-borderless m-0 align-middle">
                    <thead>
                    <tr class="border-bottom border-secondary border-opacity-10 text-figma-gray fw-bold small" style="font-size: 10px; letter-spacing: 1.5px;">
                        <th class="py-3 px-4" style="width: 25%;">EMPLEADO</th>
                        <th class="py-3 px-3" style="width: 20%;">ID DE TRANSACCIÓN</th>
                        <th class="py-3 px-3" style="width: 15%;">FECHA Y HORA</th>
                        <th class="py-3 px-3" style="width: 25%;">CONCEPTO</th>
                        <th class="py-3 px-4 text-end" style="width: 15%;">IMPORTE</th>
                    </tr>
                    </thead>
                </table>
            </div>

            <!-- Contenedor Empty State -->
            <div class="d-flex flex-column align-items-center justify-content-center text-center py-5 my-4">
                <div class="mb-3 text-secondary opacity-25">
                    <i class="bi bi-file-earmark-text" style="font-size: 3.5rem;"></i>
                </div>
                <h4 class="h5 text-light fw-normal mb-2">Aún no hay transferencias registradas</h4>
                <p class="text-figma-muted small mx-auto mb-3" style="max-width: 400px;">Aún no se han agregado datos para mostrar en esta vista.</p>
                <a href="#" class="text-figma-cyan text-decoration-none small fw-medium">Ir a Nueva Transferencia.</a>
            </div>
        </div>

    </main>
</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>