<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Configurar Nueva Cuenta</title>

  <!-- Bootstrap 5 CSS LOCAL -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons LOCAL -->
  <link href="../assets/icons/bootstrap-icons.css" rel="stylesheet">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">

  <style>
    body {
      background-color: #0c0e12;
      font-family: 'Inter', sans-serif;
      color: #e1fdff;
      min-height: 100vh;
    }
    @media (min-width: 768px) {
      .main-content {
        margin-left: 260px;
      }
    }

    /* Tarjetas estilo Figma */
    .bg-figma-card {
      background: #14171c;
      border: 1px solid #2d333d;
      border-radius: 20px;
    }
    .employee-info-box {
      background: #0b0e11;
      border-radius: 12px;
      border: 1px solid #1e2024;
    }

    /* Etiquetas */
    .form-label-figma {
      color: #bac9cc;
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.6px;
      margin-bottom: 8px;
      display: block;
      font-family: 'Plus Jakarta Sans', sans-serif;
    }

    /* Inputs y Selects */
    .form-figma-input {
      background-color: #1e2024 !important;
      border: 1px solid rgba(255, 255, 255, 0.1) !important;
      color: #ffffff !important;
      border-radius: 8px !important;
      padding: 12px 16px !important;
      font-size: 15px !important;
      transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }
    .form-figma-input:focus {
      border-color: #00e5ff !important;
      box-shadow: 0 0 0 0.25rem rgba(0, 229, 255, 0.15) !important;
    }
    .form-figma-input::placeholder {
      color: #9ca3af !important;
    }

    /* Inputs con Icono */
    .input-icon-wrapper {
      position: relative;
    }
    .input-icon-wrapper i {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #bac9cc;
      font-size: 16px;
    }
    .input-icon-wrapper .form-figma-input {
      padding-left: 42px !important;
    }

    /* Colores y Badges */
    .text-cyan-neon {
      color: #00e5ff !important;
    }
    .badge-active-neon {
      background: rgba(0, 229, 255, 0.10);
      border: 1px solid rgba(0, 229, 255, 0.20);
      color: #00e5ff;
      font-family: 'JetBrains Mono', monospace;
      font-size: 11px;
      font-weight: 700;
      padding: 3px 10px;
      border-radius: 20px;
    }

    /* Botones */
    .btn-figma-neon {
      background: #00e5ff;
      border-radius: 32px;
      color: #002022;
      font-weight: 700;
      border: none;
      padding: 12px 36px;
      font-size: 16px;
      transition: all 0.2s ease;
    }
    .btn-figma-neon:hover {
      background: #00bfe7;
      color: #002022;
      transform: translateY(-1px);
    }
    .btn-outline-figma-cancel {
      background: transparent;
      border-radius: 32px;
      color: #bac9cc;
      font-weight: 700;
      border: 1px solid #2d333d;
      padding: 12px 36px;
      font-size: 16px;
      text-decoration: none;
      transition: all 0.2s ease;
    }
    .btn-outline-figma-cancel:hover {
      background: rgba(255, 255, 255, 0.05);
      color: #ffffff;
    }

    .backdrop-blur {
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
    }
  </style>
</head>
<body>

<!-- SIDEBAR INTEGRADO -->
<jsp:include page="sidebar-admin.jsp" />

<!-- CONTENEDOR PRINCIPAL -->
<div class="main-content d-flex flex-column min-vh-100">

  <!-- HEADER SUPERIOR -->
  <header class="sticky-top w-100 d-flex justify-content-between justify-content-md-end align-items-center px-4 backdrop-blur"
          style="height: 75px; background: rgba(12, 14, 18, 0.75); border-bottom: 1px solid rgba(58, 73, 75, 0.15); z-index: 99;">
    <button class="btn d-md-none text-cyan-neon fs-3 p-0 border-0" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarAdmin" aria-controls="sidebarAdmin" aria-label="Abrir menú">
      <i class="bi bi-list"></i>
    </button>
    <i class="bi bi-person-circle text-cyan-neon fs-3 role-button" style="cursor: pointer;"></i>
  </header>

  <main class="flex-grow-1 p-4 p-md-5 pt-4 d-flex justify-content-center">
    <div class="container-fluid p-0" style="max-width: 850px;">

      <!-- Header de Sección -->
      <div class="mb-4">
        <h2 class="fw-semibold text-white m-0 lh-sm" style="font-size: 2.25rem; color: #E1FDFF !important;">
          Configurar Nueva Cuenta
        </h2>
        <p class="m-0 mt-2" style="color: #BAC9CC; font-size: 16px;">
          Selecciona al colaborador y define el identificador de su nueva cuenta corporativa.
        </p>
      </div>

      <!-- Contenedor del Formulario -->
      <form action="${pageContext.request.contextPath}/crear-cuenta" method="POST">
        <div class="bg-figma-card p-4 p-md-5 shadow-lg mb-4">

          <!-- 1. Empleado Responsable -->
          <div class="mb-4">
            <label class="form-label-figma">EMPLEADO RESPONSABLE</label>

            <!-- Select Dropdown -->
            <select class="form-select form-figma-input mb-3" name="empleadoId" required>
              <option value="" selected disabled>Seleccionar empleado</option>
              <option value="1">Alejandro Valdivia — Ciberseguridad</option>
              <option value="2">María Gómez — Finanzas</option>
            </select>

            <!-- Tarjeta Informativa del Empleado Seleccionado -->
            <div class="employee-info-box p-3 p-md-4">
              <div class="d-flex align-items-center gap-3">
                <div class="position-relative flex-shrink-0">
                  <i class="bi bi-person-circle text-cyan-neon display-5"></i>
                </div>
                <div class="flex-grow-1">
                  <div class="d-flex justify-content-between align-items-center">
                    <h5 class="m-0 fw-medium text-cyan-neon fs-5">Nombre del empleado</h5>
                    <i class="bi bi-patch-check-fill text-cyan-neon fs-5"></i>
                  </div>
                  <p class="mb-0 small" style="color: #BAC9CC;">Cargo • ID</p>

                  <hr class="my-3" style="border-color: #2D333D;">

                  <div class="d-flex justify-content-between align-items-center pt-1">
                    <div>
                      <span class="d-block form-label-figma m-0" style="font-size: 9px;">CUENTAS ACTIVAS</span>
                      <span class="fw-medium text-white small">N Cuentas</span>
                    </div>
                    <div class="text-end">
                      <span class="d-block form-label-figma m-0" style="font-size: 9px;">ESTADO</span>
                      <span class="badge badge-active-neon">ACTIVO</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 2. Nombre de la Cuenta -->
          <div class="mb-4">
            <label class="form-label-figma">NOMBRE DE LA CUENTA</label>
            <div class="input-icon-wrapper">
              <i class="bi bi-credit-card"></i>
              <input type="text" name="nombreCuenta" class="form-control form-figma-input" placeholder="Ej.  Viáticos Operativos" required>
            </div>
            <small class="d-block mt-2 fw-bold" style="color: #BAC9CC; font-size: 10px; letter-spacing: 0.8px;">
              ESTE NOMBRE SERÁ VISIBLE EN LOS EXTRACTOS Y REPORTES DE GESTIÓN.
            </small>
          </div>

          <!-- 3. Descripción Breve de la Cuenta -->
          <div class="mb-4">
            <label class="form-label-figma">DESCRIPCIÓN BREVE DE LA CUENTA</label>
            <div class="input-icon-wrapper">
              <i class="bi bi-card-text"></i>
              <input type="text" name="descripcion" class="form-control form-figma-input" placeholder="Ej.  Asignación mensual">
            </div>
          </div>

          <!-- 4. Límite para la Cuenta -->
          <div class="mb-2">
            <label class="form-label-figma">SELECCIONAR LÍMITE PARA LA CUENTA</label>
            <div class="input-icon-wrapper">
              <i class="bi bi-currency-dollar"></i>
              <input type="number" step="0.01" name="limite" class="form-control form-figma-input" placeholder="Ej. 10000" required>
            </div>
          </div>

        </div>

        <!-- Botones de Acción -->
        <div class="d-flex flex-column flex-sm-row justify-content-start align-items-center gap-3">
          <button type="submit" class="btn btn-figma-neon w-100 w-sm-auto d-inline-flex align-items-center justify-content-center gap-2">
            <span>Crear y Asignar Cuenta</span>
            <i class="bi bi-chevron-right"></i>
          </button>
          <a href="${pageContext.request.contextPath}/cuentas" class="btn btn-outline-figma-cancel w-100 w-sm-auto text-center">
            Cancelar
          </a>
        </div>
      </form>

    </div>
  </main>
</div>

<!-- Bootstrap 5 JS Bundle LOCAL -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>

</body>
</html>