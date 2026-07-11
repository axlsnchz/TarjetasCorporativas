<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Panel Principal</title>

  <!-- Bootstrap 5 CSS LOCAL -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons LOCAL -->
  <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">

  <!-- Google Fonts: Inter -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <style>
    /* Estilos base indispensables (Colores y fuentes Figma) */
    body {
      font-family: 'Inter', sans-serif;
      background-color: #0C0E12;
      color: #E2E2E8;
    }

    /* Paleta de colores específicos de Figma */
    .bg-figma-card { background-color: #14171C !important; }
    .bg-figma-sidebar { background-color: #0C0E12 !important; }
    .text-figma-cyan { color: #00DBE7 !important; }
    .text-figma-muted { color: #B9CACB !important; }

    /* Tarjeta de Aviso especial con Glow */
    .bg-figma-notice {
      background-color: #001415 !important;
      border: 1.5px solid rgba(0, 219, 231, 0.70) !important;
      box-shadow: 0px 0px 28px -8px rgba(34, 211, 238, 0.40);
    }

    /* Efecto de desenfoque Figma (No nativo en Bootstrap) */
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

    /* Ajustes de hover específicos para el menú del Sidebar */
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

  <!-- BARRA LATERAL (SIDEBAR) - Offcanvas en móvil, Fijo en desktop -->
  <jsp:include page="sidebar.jsp" />

  <!-- CONTENIDO PRINCIPAL -->
  <main class="flex-grow-1 position-relative" style="margin-left: 260px; padding: 115px 40px 40px 40px; z-index: 1;">

    <!-- HEADER FIJO (Top Profile Bar) -->
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
        <h2 class="fw-bold display-6" style="color: #E1FDFF;">Panel Principal</h2>
      </div>
    </div>

    <!-- SECCIÓN SUPERIOR: Saldo Total + Aviso -->
    <div class="row g-4 mb-4 align-items-stretch">
      <!-- Saldo Total -->
      <div class="col-xl-4 col-lg-5">
        <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 d-flex flex-column justify-content-center backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
            <span class="text-uppercase fw-bold mb-1 text-figma-cyan small" style="letter-spacing: 1.2px;">
              Saldo total
            </span>
          <h3 class="display-5 fw-bold m-0 text-white">$0.0</h3>
        </div>
      </div>

      <!-- Panel de Aviso Reemplazado -->
      <div class="col-xl-8 col-lg-7">
        <div class="card bg-figma-notice rounded-4 p-4 h-100 d-flex flex-column justify-content-center">
          <h4 class="fw-bold text-white mb-2 fs-5">Bienvenido a FinTech Corp</h4>
          <p class="m-0 small" style="color: #CBD5E1; line-height: 1.6;">
            Actualmente tu perfil no tiene cuentas corporativas asignadas. Tu administrador est&aacute; en
            proceso de configurar tus accesos. En breve podr&aacute;s ver tus cuentas, saldos y tarjetas
            disponibles aqu&iacute;.
          </p>
        </div>
      </div>
    </div>

    <!-- SECCIÓN INTERMEDIA: Gasto Semanal y Transacciones -->
    <div class="row g-4 mb-4">
      <!-- Gráfico Gasto Semanal -->
      <div class="col-lg-7">
        <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 d-flex flex-column justify-content-between backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
          <div class="d-flex justify-content-between align-items-start mb-4">
            <div>
              <h4 class="fw-semibold text-white m-0 fs-5">Gasto semanal</h4>
              <p class="text-figma-muted m-0 small">An&aacute;lisis de los &uacute;ltimos 7 d&iacute;as</p>
            </div>
            <div class="d-flex gap-2">
              <button class="btn btn-sm rounded-pill px-3 fw-bold btn-dark text-light border border-secondary small" style="font-size: 0.75rem; background: #282A2E;">Diario</button>
              <button class="btn btn-sm rounded-pill px-3 fw-bold btn-info text-dark small" style="font-size: 0.75rem; background: #00F2FF;">Semanal</button>
            </div>
          </div>

          <!-- Estado Vacío del Gráfico -->
          <div class="d-flex flex-column align-items-center justify-content-center text-center py-5">
            <i class="bi bi-graph-up-arrow display-4 mb-2" style="color: #4B4B52;"></i>
            <p class="text-figma-muted m-0 small" style="line-height: 1.5;">
              A&uacute;n no se han agregado datos para<br>mostrar en esta vista.
            </p>
          </div>

          <!-- Días de la semana -->
          <div class="d-flex justify-content-between border-top pt-3 mt-3" style="border-color: rgba(255, 255, 255, 0.05) !important;">
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Lun</span>
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Mar</span>
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Mi&eacute;</span>
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Jue</span>
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Vie</span>
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">S&aacute;b</span>
            <span class="text-uppercase text-figma-muted fw-bold" style="font-size: 0.65rem; letter-spacing: 1px;">Dom</span>
          </div>
        </div>
      </div>

      <!-- Transacciones Recientes -->
      <div class="col-lg-5">
        <div class="card bg-figma-card border-0 rounded-4 p-4 h-100 d-flex flex-column backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
          <!-- Buscador Integrado -->
          <div class="mb-4 position-relative w-100">
            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #6B7280;"></i>
            <input type="text" class="form-control text-white border border-secondary rounded-pill ps-5 py-2 bg-figma-sidebar"
                   placeholder="Buscar transacciones..." style="border-color: rgba(58, 73, 75, 0.25) !important; font-size: 0.9rem;">
          </div>

          <h4 class="fw-semibold text-white mb-4 fs-5">Transacciones recientes</h4>

          <!-- Estado Vacío de Transacciones -->
          <div class="d-flex flex-column align-items-center justify-content-center text-center my-auto py-4">
            <i class="bi bi-wallet2 display-4 mb-2" style="color: #4B4B52;"></i>
            <p class="text-figma-muted m-0 small" style="line-height: 1.5;">
              A&uacute;n no se han agregado datos para<br>mostrar en esta vista.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- SECCIÓN INFERIOR: Historial de Cuenta -->
    <div class="row">
      <div class="col-12">
        <div class="card bg-figma-card border-0 rounded-4 p-4 text-center backdrop-blur" style="border: 1px solid rgba(255, 255, 255, 0.06) !important;">
          <div class="mb-2 text-figma-cyan fs-4">
            <i class="bi bi-bank"></i>
          </div>
          <h5 class="fw-semibold text-white m-0 fs-6">Historial de cuenta</h5>
          <p class="text-figma-muted m-0 small">Descargar estados mensuales</p>
        </div>
      </div>
    </div>

  </main>
</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>