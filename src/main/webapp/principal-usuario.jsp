<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Panel Principal</title>

  <!-- Bootstrap 5 CSS LOCAL -->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons LOCAL -->
  <link href="assets/icons/bootstrap-icons.css" rel="stylesheet">

  <!-- Google Fonts: Inter -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <style>
    body {
      font-family: 'Inter', sans-serif;
      background-color: #0C0E12;
      color: #E2E2E8;
      min-height: 100vh;
      overflow-x: hidden;
    }

    /* Color Figma para textos secundarios */
    .text-figma-muted {
      color: #B9CACB !important;
    }

    /* Luces ambientales de fondo */
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

    /* Layout general */
    .wrapper {
      display: flex;
      min-height: 100vh;
    }

    /* BARRA LATERAL (Sidebar) */
    .sidebar {
      width: 260px;
      background-color: #0C0E12;
      border-right: 1px solid rgba(58, 73, 75, 0.15);
      backdrop-filter: blur(12px);
      position: fixed;
      top: 0;
      bottom: 0;
      left: 0;
      z-index: 100;
      padding: 32px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 100vh;
    }

    .sidebar-brand h1 {
      font-size: 2.2rem;
      font-weight: 700;
      color: #00DBE7;
      line-height: 1.1;
    }

    .sidebar-menu .nav-link-custom {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 24px;
      color: #B9CACB;
      text-decoration: none;
      font-size: 0.95rem;
      border-left: 4px solid transparent;
      transition: all 0.2s ease;
    }

    .sidebar-menu .nav-link-custom i {
      font-size: 1.2rem;
    }

    .sidebar-menu .nav-link-custom:hover {
      color: #00DBE7;
      background: rgba(255, 255, 255, 0.02);
    }

    .sidebar-menu .nav-link-custom.active {
      background: rgba(112, 0, 255, 0.12);
      border-left-color: #00DBE7;
      color: #00DBE7;
      font-weight: 500;
      box-shadow: -4px 0px 15px -2px rgba(0, 219, 231, 0.2);
    }

    .sidebar-footer {
      padding: 0 24px;
      width: 100%;
    }

    .btn-logout-custom {
      border: 1px solid #3B494C;
      color: #BAC9CC;
      background: transparent;
      border-radius: 8px;
      padding: 12px;
      font-size: 0.95rem;
      transition: all 0.2s ease;
      width: 100%;
      text-align: center;
    }

    .btn-logout-custom:hover {
      background: rgba(255, 255, 255, 0.05);
      color: #FFF;
      border-color: #5c6869;
    }

    /* CONTENIDO PRINCIPAL */
    .main-content {
      flex-grow: 1;
      margin-left: 260px;
      padding: 40px;
      position: relative;
      z-index: 1;
    }

    .top-profile-bar {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      margin-bottom: 30px;
    }

    .profile-icon {
      font-size: 1.8rem;
      color: #00DBE7;
      cursor: pointer;
    }

    /* TARJETAS */
    .dashboard-card {
      background: #14171C;
      border: 1px solid rgba(255, 255, 255, 0.06);
      border-radius: 24px;
      padding: 24px;
      backdrop-filter: blur(10px);
    }

    /* NUEVA TARJETA DE AVISO (Figma Style) */
    .notice-card {
      background: #001415;
      border: 1.5px solid rgba(0, 219, 231, 0.70);
      border-radius: 16px;
      padding: 28px;
      box-shadow: 0px 0px 28px -8px rgba(34, 211, 238, 0.40);
      height: 100%;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    /* Filtros */
    .pill-filter {
      padding: 6px 16px;
      font-size: 0.75rem;
      font-weight: 700;
      border-radius: 50px;
      cursor: pointer;
      border: none;
    }
    .pill-filter.inactive {
      background: #282A2E;
      color: #E2E2E8;
      border: 1px solid rgba(58, 73, 75, 0.30);
    }
    .pill-filter.active {
      background: #00F2FF;
      color: #00363A;
    }

    /* Buscador */
    .search-container-custom {
      position: relative;
      width: 100%;
    }
    .search-container-custom i {
      position: absolute;
      left: 16px;
      top: 50%;
      transform: translateY(-50%);
      color: #6B7280;
    }
    .search-input-custom {
      background: #0C0E12;
      border: 1px solid rgba(58, 73, 75, 0.25);
      border-radius: 50px;
      padding: 10px 16px 10px 42px;
      color: #E2E2E8;
      font-size: 0.9rem;
      width: 100%;
    }

    .empty-state-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      min-height: 240px;
    }
    .empty-state-icon {
      font-size: 3.5rem;
      color: #4B4B52;
      margin-bottom: 12px;
    }

    .days-row {
      display: flex;
      justify-content: space-between;
      padding: 0 10px;
      margin-top: 20px;
      border-top: 1px solid rgba(255, 255, 255, 0.05);
      padding-top: 16px;
    }
    .day-label {
      font-size: 0.65rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
    }
  </style>
</head>
<body>

<div class="wrapper">
  <div class="dashboard-glow" style="left: 30%; top: 20%;"></div>

  <!-- BARRA LATERAL (SIDEBAR) -->
  <nav class="sidebar">
    <div class="w-100">
      <div class="sidebar-brand px-4 mb-4">
        <h1>FinTech<br>Corp</h1>
        <div class="text-uppercase text-figma-muted" style="font-size: 0.7rem; letter-spacing: 0.6px; font-weight: 700;">
          Banca Institucional
        </div>
      </div>

      <div class="sidebar-menu mt-5">
        <a href="#" class="nav-link-custom active">
          <i class="bi bi-grid-1x2-fill"></i> Panel principal
        </a>
        <a href="#" class="nav-link-custom">
          <i class="bi bi-bank"></i> Cuentas
        </a>
        <a href="#" class="nav-link-custom">
          <i class="bi bi-credit-card"></i> Tarjetas
        </a>
        <a href="#" class="nav-link-custom">
          <i class="bi bi-arrow-left-right"></i> Transferencias
        </a>
        <a href="#" class="nav-link-custom">
          <i class="bi bi-gear"></i> Configuraci&oacute;n
        </a>
      </div>
    </div>

    <div class="sidebar-footer">
      <button class="btn-logout-custom">
        Cerrar Sesi&oacute;n
      </button>
    </div>
  </nav>

  <!-- CONTENIDO PRINCIPAL -->
  <main class="main-content">

    <div class="top-profile-bar">
      <i class="bi bi-person-circle profile-icon"></i>
    </div>

    <div class="row mb-4">
      <div class="col-12">
        <h2 class="fw-bold" style="color: #E1FDFF; font-size: 2.5rem;">Panel Principal</h2>
      </div>
    </div>

    <!-- SECCIÓN SUPERIOR: Saldo Total + Aviso Reemplazado -->
    <div class="row g-4 mb-4 align-items-stretch">
      <!-- Saldo Total -->
      <div class="col-xl-4 col-lg-5">
        <div class="dashboard-card h-100 d-flex flex-column justify-content-center">
            <span class="text-uppercase fw-bold mb-1" style="color: #00DBE7; font-size: 0.75rem; letter-spacing: 1.2px;">
              Saldo total
            </span>
          <h3 class="display-5 fw-bold m-0 text-white">$0.0</h3>
        </div>
      </div>

      <!-- Panel de Aviso (Sustituto de viáticos, gasolina y bonos) -->
      <div class="col-xl-8 col-lg-7">
        <div class="notice-card">
          <h4 class="fw-bold text-white mb-2" style="font-size: 1.4rem;">Bienvenido a FinTech Corp</h4>
          <p class="m-0" style="color: #CBD5E1; font-size: 0.9rem; line-height: 1.6;">
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
        <div class="dashboard-card h-100 d-flex flex-column justify-content-between">
          <div class="d-flex justify-content-between align-items-start mb-4">
            <div>
              <h4 class="fw-semibold text-white m-0" style="font-size: 1.35rem;">Gasto semanal</h4>
              <p class="text-figma-muted m-0" style="font-size: 0.95rem;">An&aacute;lisis de los &uacute;ltimos 7 d&iacute;as</p>
            </div>
            <div class="d-flex gap-2">
              <button class="pill-filter inactive">Diario</button>
              <button class="pill-filter active">Semanal</button>
            </div>
          </div>

          <div class="empty-state-container">
            <i class="bi bi-graph-up-arrow empty-state-icon"></i>
            <p class="text-figma-muted" style="font-size: 0.95rem; line-height: 1.5;">
              A&uacute;n no se han agregado datos para<br>mostrar en esta vista.
            </p>
          </div>

          <div class="days-row">
            <span class="day-label text-figma-muted">Lun</span>
            <span class="day-label text-figma-muted">Mar</span>
            <span class="day-label text-figma-muted">Mi&eacute;</span>
            <span class="day-label text-figma-muted">Jue</span>
            <span class="day-label text-figma-muted">Vie</span>
            <span class="day-label text-figma-muted">S&aacute;b</span>
            <span class="day-label text-figma-muted">Dom</span>
          </div>
        </div>
      </div>

      <!-- Transacciones Recientes -->
      <div class="col-lg-5">
        <div class="dashboard-card h-100 d-flex flex-column">
          <div class="mb-3">
            <div class="search-container-custom">
              <i class="bi bi-search"></i>
              <input type="text" class="search-input-custom" placeholder="Buscar transacciones...">
            </div>
          </div>

          <h4 class="fw-semibold text-white mb-4" style="font-size: 1.35rem;">Transacciones recientes</h4>

          <div class="empty-state-container my-auto">
            <i class="bi bi-wallet2 empty-state-icon"></i>
            <p class="text-figma-muted" style="font-size: 0.95rem; line-height: 1.5;">
              A&uacute;n no se han agregado datos para<br>mostrar en esta vista.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- SECCIÓN INFERIOR: Historial de Cuenta -->
    <div class="row">
      <div class="col-12">
        <div class="dashboard-card text-center py-4">
          <div class="mb-2" style="font-size: 1.5rem; color: #00DBE7;">
            <i class="bi bi-bank"></i>
          </div>
          <h5 class="fw-semibold text-white m-0" style="font-size: 1rem;">Historial de cuenta</h5>
          <p class="text-figma-muted m-0 small">Descargar estados mensuales</p>
        </div>
      </div>
    </div>

  </main>
</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>