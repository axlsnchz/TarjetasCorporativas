<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTech Corp - Inicio de Sesi&oacute;n</title>

  <!-- Bootstrap 5 CSS LOCAL -->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons LOCAL -->
  <link href="assets/icons/bootstrap-icons.css" rel="stylesheet">

  <!-- Google Fonts: Inter -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

  <style>
    /* Estilos estructurales y tipografía base */
    body {
      font-family: 'Inter', sans-serif;
      background-color: #0C0E12;
    }

    /* Paleta de colores específicos del Figma */
    .bg-figma-dark { background-color: #0C0E12 !important; }
    .bg-figma-card { background-color: rgba(30, 32, 36, 0.50) !important; }
    .bg-figma-form { background-color: #111318 !important; }
    .bg-figma-input { background-color: #1A1C20 !important; }
    .text-figma-cyan { color: #00DBE7 !important; }
    .text-figma-muted { color: #B9CACB !important; }

    /* Efectos Figma avanzados (No nativos en Bootstrap) */
    .backdrop-blur {
      backdrop-filter: blur(16px);
      -webkit-backdrop-filter: blur(16px);
    }

    /* Resplandores y luces ambientales traseras */
    .bg-glow-purple {
      position: absolute; width: 600px; height: 600px; left: 50%; top: 10%;
      background: rgba(112, 0, 255, 0.04); filter: blur(120px); border-radius: 50%; z-index: 0;
    }
    .bg-glow-cyan {
      position: absolute; width: 500px; height: 500px; left: 20%; top: 30%;
      background: rgba(0, 242, 255, 0.04); filter: blur(120px); border-radius: 50%; z-index: 0;
    }
    .banner-glow-1 {
      position: absolute; width: 300px; height: 300px; left: -100px; top: -100px;
      background: rgba(0, 242, 255, 0.08); filter: blur(70px); border-radius: 50%;
    }
    .banner-glow-2 {
      position: absolute; width: 300px; height: 300px; right: -100px; bottom: -100px;
      background: rgba(112, 0, 255, 0.08); filter: blur(70px); border-radius: 50%;
    }
  </style>
</head>
<body class="d-flex justify-content-center align-items-center min-vh-100 p-3 p-md-4 overflow-x-hidden position-relative">

<!-- Efectos de Fondo Ambientales -->
<div class="bg-glow-purple"></div>
<div class="bg-glow-cyan"></div>

<!-- Contenedor de la Tarjeta Principal (Totalmente Bootstrap) -->
<div class="row g-0 rounded-5 overflow-hidden w-100 position-relative backdrop-blur bg-figma-card border border-white border-opacity-10"
     style="max-width: 1100px; box-shadow: 0px 25px 50px -12px rgba(0, 242, 255, 0.05); z-index: 1;">

  <!-- COLUMNA IZQUIERDA: Branding e Info -->
  <div class="col-lg-6 bg-figma-dark position-relative overflow-hidden d-flex flex-column justify-content-between p-5 text-center">
    <div class="banner-glow-1"></div>
    <div class="banner-glow-2"></div>

    <div class="my-auto position-relative" style="z-index: 1;">
      <!-- Logo Principal con Brillo Figma -->
      <div class="rounded-3 d-flex align-items-center justify-content-center mx-auto mb-4 text-dark fs-1"
           style="width: 80px; height: 80px; background-color: #00DBE7; box-shadow: 0px 0px 25px rgba(0, 242, 255, 0.6);">
        <i class="bi bi-building-columns-fill"></i>
      </div>

      <h1 class="display-5 fw-bold mb-3 text-figma-cyan">FinTech Corp</h1>
      <p class="mx-auto mb-5 text-figma-muted style-normal" style="max-width: 380px; font-size: 0.95rem; line-height: 1.6;">
        Administraci&oacute;n y control centralizado de fondos corporativos para equipos de trabajo.
      </p>
    </div>

    <!-- Fila de Características (Usando Cards de Bootstrap limpias) -->
    <div class="row g-2 position-relative w-100 mx-0 mt-4" style="z-index: 1;">
      <div class="col-4">
        <div class="card border border-info border-opacity-25 bg-transparent text-figma-cyan rounded-3 p-3 text-center fw-bold small" style="letter-spacing: 1px; font-size: 0.75rem;">
          <i class="bi bi-shield-lock mb-1 fs-5 d-block"></i> CONTROL
        </div>
      </div>
      <div class="col-4">
        <div class="card border border-info border-opacity-25 bg-transparent text-figma-cyan rounded-3 p-3 text-center fw-bold small" style="letter-spacing: 1px; font-size: 0.75rem;">
          <i class="bi bi-sliders mb-1 fs-5 d-block"></i> FLEXIBLE
        </div>
      </div>
      <div class="col-4">
        <div class="card border border-info border-opacity-25 bg-transparent text-figma-cyan rounded-3 p-3 text-center fw-bold small" style="letter-spacing: 1px; font-size: 0.75rem;">
          <i class="bi bi-check-circle mb-1 fs-5 d-block"></i> EFICIENCIA
        </div>
      </div>
    </div>
  </div>

  <!-- COLUMNA DERECHA: Formulario de Login -->
  <div class="col-lg-6 bg-figma-form p-4 p-sm-5 d-flex flex-column justify-content-center">
    <div class="mx-auto w-100" style="max-width: 400px;">

      <div class="mb-4">
        <h2 class="fw-semibold mb-2 text-light" style="font-size: 1.5rem;">Bienvenido</h2>
        <p class="text-figma-muted small" style="line-height: 1.5;">
          Ingrese sus credenciales para acceder a su portal de gesti&oacute;n empresarial.
        </p>
      </div>

      <form>
        <!-- Input Correo Electrónico -->
        <div class="mb-4">
          <label class="text-figma-muted fw-bold small mb-2 d-block" style="letter-spacing: 0.8px; font-size: 0.75rem;">CORREO ELECTR&Oacute;NICO</label>
          <div class="input-group rounded-2 overflow-hidden border-0 border-bottom border-2" style="border-color: #3A494B !important;">
            <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted"><i class="bi bi-envelope"></i></span>
            <input type="email" class="form-control border-0 py-3 bg-figma-input text-white shadow-none" placeholder="nombre@ejemplo.com" required style="font-size: 0.95rem;">
          </div>
        </div>

        <!-- Input Contraseña -->
        <div class="mb-4">
          <div class="d-flex justify-content-between align-items-center mb-2">
            <label class="text-figma-muted fw-bold small m-0" style="letter-spacing: 0.8px; font-size: 0.75rem;">CONTRASE&Ntilde;A</label>
            <a href="recucontrasena.jsp" class="text-figma-cyan fw-bold text-decoration-none small" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">Olvid&eacute; mi contrase&ntilde;a</a>
          </div>
          <div class="input-group rounded-2 overflow-hiddepn border-0 border-bottom border-2" style="border-color: #3A494B !important;">
            <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted"><i class="bi bi-lock"></i></span>
            <input type="password" class="form-control border-0 py-3 bg-figma-input text-white shadow-none" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" required style="font-size: 0.95rem;">
            <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted" style="cursor: pointer;"><i class="bi bi-eye"></i></span>
          </div>
        </div>

        <!-- Botón de Acción Principal Cyan -->
        <button type="submit" class="btn btn-info rounded-pill w-100 py-3 fw-bold d-flex align-items-center justify-content-center gap-2 mt-4 text-dark"
                style="background-color: #00F2FF; border: none; box-shadow: 0px 0px 20px rgba(0, 242, 255, 0.4);">
          Iniciar Sesi&oacute;n <i class="bi bi-arrow-right"></i>
        </button>
      </form>

      <div class="mt-5 pt-3 border-top border-secondary border-opacity-25"></div>

    </div>
  </div>

</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>