<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Configuración</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons LOCAL -->
    <link href="assets/icons/bootstrap-icons.css" rel="stylesheet">

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
            color: #8A999A;
            border-color: rgba(255, 255, 255, 0.02);
            opacity: 0.8;
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
    </style>
</head>
<body class="overflow-x-hidden min-vh-100">

<div class="d-flex min-vh-100 position-relative">
    <!-- Luz de fondo ambiental -->
    <div class="dashboard-glow" style="left: 30%; top: 20%;"></div>

    <!-- BARRA LATERAL (SIDEBAR) - Estandarizada -->
    <nav class="bg-figma-sidebar border-end position-fixed top-0 start-0 vh-100 d-flex flex-column justify-content-between py-4 backdrop-blur"
         style="width: 260px; border-color: rgba(58, 73, 75, 0.15) !important; z-index: 100;">

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
                <a href="transferencias-usuario.jsp" class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
                    <i class="bi bi-arrow-left-right fs-5"></i> <span>Transferencias</span>
                </a>
                <!-- Ítem Activo en esta vista -->
                <a href="configuracion-usuario.jsp" class="sidebar-link active d-flex align-items-center gap-3 px-4 py-3 text-decoration-none">
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

        <!-- HEADER FIJO -->
        <div class="position-fixed top-0 end-0 d-flex justify-content-end align-items-center px-4 backdrop-blur"
             style="left: 260px; height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
            <i class="bi bi-person-circle text-figma-cyan fs-3 role-button" style="cursor: pointer;"></i>
        </div>

        <!-- CABECERA DE LA VISTA -->
        <div class="row mb-5 font-jakarta">
            <div class="col-12">
                <h2 class="fw-bold display-6 text-white mb-2">Configuración</h2>
                <p class="text-figma-muted m-0 fs-6">Administra tu identidad digital y protocolos de seguridad institucional.</p>
            </div>
        </div>

        <!-- CONTENEDOR DE OPCIONES EN REJILLA -->
        <div class="row g-4 font-jakarta">

            <!-- COLUMNA IZQUIERDA: IDENTIDAD DIGITAL (READ-ONLY) -->
            <div class="col-12 col-xl-7">
                <div class="card bg-figma-card rounded-4 p-4 h-100 border" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">

                    <!-- Bloque de Perfil / Avatar -->
                    <div class="d-flex align-items-center gap-4 mb-5">
                        <div class="position-relative d-flex align-items-center justify-content-center bg-opacity-10 rounded-circle border border-2 border-info"
                             style="width: 80px; height: 80px; background-color: rgba(0, 219, 231, 0.1);">
                            <i class="bi bi-person text-figma-cyan" style="font-size: 2.5rem;"></i>
                        </div>
                        <div>
                            <h3 class="text-white h5 fw-semibold mb-1">Nombre del empleado</h3>
                            <span class="text-figma-cyan small fw-medium">Cargo / Rol Institucional</span>
                        </div>
                    </div>

                    <!-- Campos de Identidad Fijos -->
                    <div class="row g-4">
                        <!-- Nombre Completo -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Nombre Completo</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none" value="Nombre Completo Registrado" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Correo Electrónico -->
                        <div class="col-12 col-md-6">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Correo Electrónico</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="email" class="form-control form-control-dark py-2.5 shadow-none" value="ej.correo@gmail.com" readonly>
                                <span class="input-group-text bg-figma-input border-0 text-figma-gray px-3"><i class="bi bi-lock-fill"></i></span>
                            </div>
                        </div>

                        <!-- Número de Identificación -->
                        <div class="col-12">
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Número de Identificación</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="text" class="form-control form-control-dark py-2.5 shadow-none" value="ID generada automáticamente por el sistema" readonly>
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

                    <form class="d-flex flex-column gap-3">
                        <!-- Contraseña Actual -->
                        <div>
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Contraseña Actual</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="password" class="form-control form-control-dark py-2.5 shadow-none border-end-0" placeholder="••••••••••••">
                            </div>
                        </div>

                        <!-- Nueva Contraseña -->
                        <div>
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Nueva Contraseña</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="password" class="form-control form-control-dark py-2.5 shadow-none border-end-0" placeholder="••••••••••••">
                                <button class="btn bg-figma-select text-figma-gray border-0 px-3" type="button">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Confirmar Nueva Contraseña -->
                        <div>
                            <label class="text-figma-muted fw-bold small text-uppercase mb-2 d-block tracking-wider" style="font-size: 11px;">Confirmar Nueva Contraseña</label>
                            <div class="input-group rounded-2 overflow-hidden">
                                <input type="password" class="form-control form-control-dark py-2.5 shadow-none border-end-0" placeholder="••••••••••••">
                                <button class="btn bg-figma-select text-figma-gray border-0 px-3" type="button">
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
<script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>