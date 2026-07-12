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
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;700&display=swap" rel="stylesheet">

  <style>
    body {
      background-color: #0c0e12;
      font-family: 'Plus Jakarta Sans', sans-serif;
      color: #E2E2E8;
      min-height: 100vh;
      /* SOLUCIÓN AL SALTO: Fuerza a mantener el espacio del scrollbar fijo en todas las pantallas */
      overflow-y: scroll;
    }
    @media (min-width: 768px) {
      .main-content {
        margin-left: 260px;
      }
    }
    .bg-figma-card {
      background: #14171C;
      border: 1px solid rgba(255, 255, 255, 0.03);
      border-radius: 24px;
    }
    .btn-figma-neon {
      background: #00F2FF;
      border-radius: 32px;
      color: #002022;
      font-family: 'Inter', sans-serif;
      font-weight: 700;
      letter-spacing: 0.02rem;
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
    .font-inter {
      font-family: 'Inter', sans-serif;
    }
    /* Estilos personalizados para los inputs alineados con Figma */
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

  <!-- HEADER SUPERIOR INCORPORADO -->
  <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
          style="height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
    <button class="btn d-md-none text-cyan-neon fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarAdmin" aria-controls="sidebarAdmin" aria-label="Abrir menú">
      <i class="bi bi-list"></i>
    </button>
    <i class="bi bi-person-circle text-cyan-neon fs-3 role-button" style="cursor: pointer;"></i>
  </header>

  <main class="flex-grow-1 p-4 p-md-5 pt-4">
    <div class="container-fluid p-0">

      <!-- Fila de Encabezado (Título y Acción Principal) -->
      <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-4 mb-4">
        <div>
          <h2 class="fw-bold text-white m-0 lh-sm" style="font-size: 2.6rem; color: #E1FDFF !important;">Gestión de Tarjetas</h2>
          <p class="m-0 mt-2" style="color: #64748B !important; font-weight: 500;">Control centralizado de tarjetas corporativas, límites y estados.</p>
        </div>

        <button class="btn btn-figma-neon px-4 py-2 d-inline-flex align-items-center gap-2 shadow-sm">
          <i class="bi bi-plus-lg fw-bold"></i>
          <span>Emitir Nueva Tarjeta</span>
        </button>
      </div>

      <!-- Barra de Herramientas y Filtros (Búsqueda, Estado y Tipo) -->
      <div class="p-3 mb-4 rounded-4 shadow-sm" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.03);">
        <div class="row g-3 align-items-center">
          <!-- Buscador -->
          <div class="col-12 col-md-6">
            <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #64748B;">Buscar tarjeta</label>
            <div class="position-relative">
              <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3" style="color: #475569;"></i>
              <input type="text" class="form-control form-figma-search ps-5 py-2" placeholder="Nombre del empleado o alias de la tarjeta...">
            </div>
          </div>
          <!-- Filtro Estado -->
          <div class="col-6 col-md-3">
            <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #64748B;">Estado</label>
            <select class="form-select form-figma-select py-2 shadow-none">
              <option selected value="all">Todos los estados</option>
              <option value="active">Activas</option>
              <option value="blocked">Bloqueadas</option>
            </select>
          </div>
          <!-- Filtro Tipo -->
          <div class="col-6 col-md-3">
            <label class="d-block text-uppercase fw-bold mb-1 tracking-wider" style="font-size: 0.625rem; color: #64748B;">Tipo</label>
            <select class="form-select form-figma-select py-2 shadow-none">
              <option selected value="all">Todos los tipos</option>
              <option value="physical">Física</option>
              <option value="virtual">Virtual</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Contenedor Principal (Estado Vacío) -->
      <div class="row">
        <div class="col-12">
          <div class="bg-figma-card p-4 p-md-5 d-flex flex-column shadow-lg font-inter text-center" style="min-height: 480px;">

            <!-- Bloque Central de Estado Vacío -->
            <div class="my-auto py-5">
              <!-- Icono de Tarjeta Estilizado -->
              <div class="position-relative d-inline-block mb-4">
                <div class="d-flex align-items-center justify-content-center border rounded-3"
                     style="width: 80px; height: 56px; border-color: #334155 !important; color: #334155;">
                  <i class="bi bi-credit-card-2-front fs-2"></i>
                </div>
                <span class="position-absolute bottom-0 end-0 translate-middle border border-dark rounded-circle bg-dark d-flex align-items-center justify-content-center"
                      style="width: 24px; height: 24px; margin-bottom: -10px; margin-right: -10px;">
                    <i class="bi bi-plus-circle-fill text-muted" style="font-size: 0.85rem;"></i>
                </span>
              </div>

              <!-- Mensajes -->
              <h4 class="fw-bold text-white mb-3" style="font-size: 1.5rem;">No hay tarjetas corporativas emitidas aún</h4>
              <p class="small mx-auto mb-4" style="max-width: 480px; color: #94A3B8; line-height: 1.6;">
                Para comenzar a controlar los límites y gastos de tu equipo, necesitas emitir tu primera tarjeta física o virtual.
              </p>

              <!-- Acción Secundaria Inside Card -->
              <button class="btn btn-figma-neon px-4 py-2 fw-semibold shadow-sm text-dark font-inter" style="font-size: 0.875rem;">
                Emitir Nueva Tarjeta
              </button>
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