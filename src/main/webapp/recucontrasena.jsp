<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Recuperar Contrase&ntilde;a</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons (CDN + Fallback Local) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="${pageContext.request.contextPath}/assets/icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0C0E12;
        }

        .bg-figma-dark { background-color: #0C0E12 !important; }
        .bg-figma-card { background-color: rgba(30, 32, 36, 0.50) !important; }
        .bg-figma-form { background-color: #111318 !important; }
        .bg-figma-input { background-color: #1A1C20 !important; }
        .text-figma-cyan { color: #00DBE7 !important; }
        .text-figma-muted { color: #B9CACB !important; }

        .backdrop-blur {
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
        }

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

<!-- Contenedor Principal -->
<div class="row g-0 rounded-5 overflow-hidden w-100 position-relative backdrop-blur bg-figma-card border border-white border-opacity-10"
     style="max-width: 1100px; box-shadow: 0px 25px 50px -12px rgba(0, 242, 255, 0.05); z-index: 1;">

    <!-- COLUMNA IZQUIERDA: Branding unificado -->
    <div class="col-lg-6 bg-figma-dark position-relative overflow-hidden d-flex flex-column justify-content-between p-5 text-center">
        <div class="banner-glow-1"></div>
        <div class="banner-glow-2"></div>

        <div class="my-auto position-relative" style="z-index: 1;">
            <div class="rounded-3 d-flex align-items-center justify-content-center mx-auto mb-4 text-dark fs-1"
                 style="width: 80px; height: 80px; background-color: #00DBE7; box-shadow: 0px 0px 25px rgba(0, 242, 255, 0.6);">
                <i class="bi bi-building-columns-fill"></i>
            </div>

            <h1 class="display-5 fw-bold mb-3 text-figma-cyan">FinTech Corp</h1>
            <p class="mx-auto mb-5 text-figma-muted" style="max-width: 380px; font-size: 0.95rem; line-height: 1.6;">
                Administraci&oacute;n y control centralizado de fondos corporativos para equipos de trabajo.
            </p>
        </div>

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

    <!-- COLUMNA DERECHA: Formulario de Recuperación -->
    <div class="col-lg-6 bg-figma-form p-4 p-sm-5 d-flex flex-column justify-content-center">
        <div class="mx-auto w-100" style="max-width: 400px;">

            <!-- Alertas de Alerta/Error/Éxito -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 bg-danger bg-opacity-25 text-danger rounded-3 p-3 mb-4 small d-flex align-items-center gap-2">
                    <i class="bi bi-exclamation-triangle-fill fs-5"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <c:if test="${not empty mensajeExito}">
                <div class="alert alert-success border-0 bg-success bg-opacity-25 text-success rounded-3 p-3 mb-4 small d-flex align-items-center gap-2">
                    <i class="bi bi-check-circle-fill fs-5"></i>
                    <span>${mensajeExito}</span>
                </div>
            </c:if>

            <c:choose>
                <%-- PASO 2: Ingresar Código y Nueva Contraseña --%>
                <c:when test="${paso eq 'validar'}">
                    <div class="mb-4">
                        <h2 class="fw-semibold mb-2 text-light" style="font-size: 1.5rem;">Restablecer Contrase&ntilde;a</h2>
                        <p class="text-figma-muted small" style="line-height: 1.5;">
                            Ingresa el c&oacute;digo de 6 caracteres enviado a tu correo y tu nueva clave de acceso.
                        </p>
                    </div>

                    <form action="recuperar-password" method="POST">
                        <input type="hidden" name="accion" value="cambiar_password">
                        <input type="hidden" name="correo" value="${correo}">

                        <!-- CÓDIGO DE VERIFICACIÓN -->
                        <div class="mb-3">
                            <label class="text-figma-muted fw-bold small mb-2 d-block" style="letter-spacing: 0.8px; font-size: 0.75rem;">C&Oacute;DIGO DE VERIFICACI&Oacute;N</label>
                            <div class="input-group rounded-2 overflow-hidden border-0 border-bottom border-2" style="border-color: #3A494B !important;">
                                <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted"><i class="bi bi-key"></i></span>
                                <input type="text" name="codigo" class="form-control border-0 py-3 bg-figma-input text-white shadow-none text-uppercase tracking-widest fw-bold" placeholder="X7K2P9" required maxlength="10" style="font-size: 1rem; letter-spacing: 3px;">
                            </div>
                        </div>

                        <!-- NUEVA CONTRASEÑA -->
                        <div class="mb-3">
                            <label class="text-figma-muted fw-bold small mb-2 d-block" style="letter-spacing: 0.8px; font-size: 0.75rem;">NUEVA CONTRASE&Ntilde;A</label>
                            <div class="input-group rounded-2 overflow-hidden border-0 border-bottom border-2" style="border-color: #3A494B !important;">
                                <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted"><i class="bi bi-lock"></i></span>
                                <input type="password" name="nuevaPassword" class="form-control border-0 py-3 bg-figma-input text-white shadow-none" placeholder="M&iacute;nimo 8 caracteres (1 letra, 1 número)" required style="font-size: 0.95rem;">
                            </div>
                        </div>

                        <!-- CONFIRMAR CONTRASEÑA -->
                        <div class="mb-4">
                            <label class="text-figma-muted fw-bold small mb-2 d-block" style="letter-spacing: 0.8px; font-size: 0.75rem;">CONFIRMAR CONTRASE&Ntilde;A</label>
                            <div class="input-group rounded-2 overflow-hidden border-0 border-bottom border-2" style="border-color: #3A494B !important;">
                                <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" name="confirmarPassword" class="form-control border-0 py-3 bg-figma-input text-white shadow-none" placeholder="Confirma tu nueva contraseña" required style="font-size: 0.95rem;">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-info rounded-pill w-100 py-3 fw-bold d-flex align-items-center justify-content-center gap-2 mt-4 text-dark"
                                style="background-color: #00F2FF; border: none; box-shadow: 0px 0px 20px rgba(0, 242, 255, 0.4);">
                            Actualizar Contrase&ntilde;a <i class="bi bi-check2-circle"></i>
                        </button>
                    </form>
                </c:when>

                <%-- PASO 1: Solicitar Código --%>
                <c:otherwise>
                    <div class="mb-4">
                        <h2 class="fw-semibold mb-2 text-light" style="font-size: 1.5rem;">Recuperar contrase&ntilde;a</h2>
                        <p class="text-figma-muted small" style="line-height: 1.5;">
                            Ingresa tu correo electr&oacute;nico para recibir un c&oacute;digo de verificaci&oacute;n de seguridad.
                        </p>
                    </div>

                    <form action="recuperar-password" method="POST">
                        <input type="hidden" name="accion" value="solicitar_codigo">

                        <div class="mb-4">
                            <label class="text-figma-muted fw-bold small mb-2 d-block" style="letter-spacing: 0.8px; font-size: 0.75rem;">CORREO ELECTR&Oacute;NICO</label>
                            <div class="input-group rounded-2 overflow-hidden border-0 border-bottom border-2" style="border-color: #3A494B !important;">
                                <span class="input-group-text border-0 px-3 bg-figma-input text-figma-muted"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="correo" value="${param.correo}" class="form-control border-0 py-3 bg-figma-input text-white shadow-none" placeholder="nombre@fintechcorp.com" required style="font-size: 0.95rem;">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-info rounded-pill w-100 py-3 fw-bold d-flex align-items-center justify-content-center gap-2 mt-4 text-dark"
                                style="background-color: #00F2FF; border: none; box-shadow: 0px 0px 20px rgba(0, 242, 255, 0.4);">
                            Enviar C&oacute;digo <i class="bi bi-arrow-right"></i>
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>

            <a href="login.jsp" class="btn btn-outline-info rounded-pill w-100 py-3 fw-bold d-flex align-items-center justify-content-center gap-2 mt-3 text-figma-cyan"
               style="border-color: #00F2FF !important; background: transparent; font-size: 1rem;"
               onmouseover="this.style.backgroundColor='rgba(0, 242, 255, 0.08)'"
               onmouseout="this.style.backgroundColor='transparent'">
                <i class="bi bi-arrow-left"></i> Volver al Inicio
            </a>

            <div class="mt-5 pt-3 border-top border-secondary border-opacity-25"></div>

        </div>
    </div>

</div>

<!-- Bootstrap Bundle JS LOCAL -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>