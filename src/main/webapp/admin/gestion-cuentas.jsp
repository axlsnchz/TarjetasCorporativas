<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Gestión de Cuentas</title>

  <!-- Bootstrap 5 CSS LOCAL -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons LOCAL -->
  <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;700&display=swap" rel="stylesheet">

  <style>
    body {
      background-color: #111318;
      font-family: 'Inter', sans-serif;
      color: #B9CACB;
      min-height: 100vh;
    }
    @media (min-width: 768px) {
      .main-content {
        margin-left: 260px;
      }
    }
    .bg-figma-card {
      background: #14171C;
      border: 1px solid #3B494C;
      border-radius: 16px;
      position: relative;
      overflow: hidden;
    }
    .card-glow-effect {
      position: absolute;
      width: 256px;
      height: 256px;
      right: -50px;
      top: -80px;
      background: rgba(0, 229, 255, 0.05);
      box-shadow: 64px 64px 64px rgba(0, 229, 255, 0.05);
      border-radius: 9999px;
      filter: blur(32px);
      pointer-events: none;
    }
    .btn-figma-neon {
      background: #00E5FF;
      border-radius: 32px;
      color: #002022;
      font-family: 'Inter', sans-serif;
      font-weight: 700;
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
    .font-plus-jakarta {
      font-family: 'Plus Jakarta Sans', sans-serif;
    }
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

    /* CORRECCIÓN DE COLOR AQUÍ: Forzamos el fondo oscuro directo a los headers */
    .table-figma-header th {
      font-family: 'Plus Jakarta Sans', sans-serif;
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      color: #64748B !important;
      background-color: #14171C !important;
      border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
      padding: 16px 24px;
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

  <!-- HEADER SUPERIOR GLOBAL -->
  <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
          style="height: 75px; background: rgba(17, 19, 24, 0.85); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
    <button class="btn d-md-none text-cyan-neon fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarAdmin" aria-controls="sidebarAdmin" aria-label="Abrir menú">
      <i class="bi bi-list"></i>
    </button>
    <i class="bi bi-person-circle text-cyan-neon fs-3 role-button" style="cursor: pointer;"></i>
  </header>

  <main class="flex-grow-1 p-4 p-md-5 pt-4">
    <div class="container-fluid p-0">

      <!-- Encabezado de la Vista -->
      <div class="mb-4">
        <h2 class="fw-bold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Gestión de Cuentas</h2>
        <p class="m-0 mt-2 text-muted" style="color: #B9CACB !important;">Resumen de fondos operativos y beneficios institucionales.</p>
      </div>

      <!-- Fila superior: Tarjetas de Acciones Principales -->
      <div class="row g-4 mb-4">
        <!-- Tarjeta: Añadir Nuevo Talento -->
        <div class="col-12 col-lg-7">
          <div class="bg-figma-card p-4 h-100 d-flex flex-column justify-content-between">
            <div class="card-glow-effect"></div>

            <div class="row align-items-center g-3">
              <div class="col-12 col-sm-7 col-md-8">
                <h3 class="font-plus-jakarta fw-normal mb-2" style="color: #C3F5FF; font-size: 1.85rem;">Añadir Nuevo Talento</h3>
                <p class="small text-muted mb-0" style="color: #BAC9CC !important; line-height: 1.5;">
                  Inicia el proceso de creación de cuenta fintech para nuevos empleados de la organización.
                </p>
              </div>
              <!-- Icono de Reemplazo Estilizado -->
              <div class="col-12 col-sm-5 col-md-4 text-end d-none d-sm-block">
                <div class="d-inline-flex align-items-center justify-content-center rounded-4 border border-info border-opacity-10 shadow-sm mx-auto"
                     style="width: 110px; height: 110px; background: rgba(0, 229, 255, 0.03); color: #00E5FF;">
                  <i class="bi bi-person-badge-fill display-4 opacity-50"></i>
                </div>
              </div>
            </div>

            <!-- Indicador estadístico inferior y botón -->
            <div class="d-flex justify-content-between align-items-end mt-4">
              <div>
                <div class="text-muted small fw-medium" style="color: #BAC9CC !important; font-size: 0.9rem;">Cuentas Activas</div>
                <div class="fw-bold text-white fs-3 font-plus-jakarta mt-1">0</div>
              </div>
              <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2">
                <i class="bi bi-person-plus-fill fs-5"></i>
                <span>Crear Cuenta</span>
              </button>
            </div>
          </div>
        </div>

        <!-- Tarjeta: Depositar a cuentas -->
        <div class="col-12 col-lg-5">
          <div class="bg-figma-card p-4 h-100 d-flex flex-column justify-content-between">
            <div class="card-glow-effect"></div>

            <div>
              <h3 class="font-plus-jakarta fw-normal mb-2 mt-2" style="color: #C3F5FF; font-size: 1.85rem; line-height: 1.2;">
                Deposita a las cuentas<br>de los empleados
              </h3>
            </div>

            <div class="text-end mt-4">
              <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2">
                <i class="bi bi-cash-stack fs-5"></i>
                <span>Depositar</span>
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Barra de Filtros y Búsqueda -->
      <div class="p-3 mb-4 rounded-4" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">
        <div class="row g-3 align-items-center">
          <div class="col-12 col-md-8">
            <label class="d-block text-uppercase fw-bold mb-1 font-plus-jakarta" style="font-size: 0.625rem; color: #64748B; letter-spacing: 1px;">Buscar Titular</label>
            <div class="position-relative">
              <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #475569;"></i>
              <input type="text" class="form-control form-figma-search ps-5 py-2" placeholder="Nombre del empleado...">
            </div>
          </div>
          <div class="col-12 col-md-4">
            <label class="d-block text-uppercase fw-bold mb-1 font-plus-jakarta" style="font-size: 0.625rem; color: #64748B; letter-spacing: 1px;">Estado</label>
            <select class="form-select form-figma-select py-2 shadow-none">
              <option selected value="all">Todos los estados</option>
              <option value="active">Activo</option>
              <option value="inactive">Inactivo</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Contenedor de la Tabla -->
      <div class="bg-figma-card overflow-hidden shadow-lg">
        <div class="table-responsive">
          <table class="table table-borderless m-0 align-middle">
            <thead class="table-figma-header">
            <tr>
              <th style="width: 28%;">Empleado</th>
              <th style="width: 22%; text-align: center;">Cuenta</th>
              <th style="width: 18%; text-align: center;">Saldo Actual</th>
              <th style="width: 16%;">Estado</th>
              <th style="width: 16%; text-align: right;">Acciones</th>
            </tr>
            </thead>
            <tbody>
            <!-- Las filas dinámicas irán aquí sin alterar el color superior -->
            </tbody>
          </table>
        </div>

        <!-- Bloque de Estado Vacío dentro del contenedor -->
        <div class="d-flex flex-column align-items-center justify-content-center text-center font-plus-jakarta py-5 px-3" style="min-height: 220px; background: #14171C;">
          <div class="mb-3 d-flex align-items-center justify-content-center border rounded-3"
               style="width: 44px; height: 44px; border-color: #3B494C !important; color: #64748B;">
            <i class="bi bi-file-earmark-text fs-4"></i>
          </div>
          <h5 class="fw-normal text-white mb-2" style="font-size: 1.4rem;">Aún no hay cuentas registradas</h5>
          <p class="small text-muted mb-0" style="color: #737373 !important;">
            Aún no se han agregado datos para mostrar en esta vista.
          </p>
        </div>
      </div>

    </div>
  </main>
</div>

<!-- Bootstrap 5 JS Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>