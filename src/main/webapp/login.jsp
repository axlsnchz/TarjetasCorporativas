<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTech Corp - Inicio de Sesi&oacute;n</title>

    <!-- Bootstrap 5 CSS LOCAL -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons LOCAL -->
    <link href="assets/icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0C0E12;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Fondos difuminados del Layout principal (Glows) */
        .bg-glow-purple {
            position: absolute;
            width: 600px;
            height: 600px;
            left: 50%;
            top: 10%;
            background: rgba(112, 0, 255, 0.04);
            filter: blur(120px);
            border-radius: 50%;
            z-index: 0;
        }

        .bg-glow-cyan {
            position: absolute;
            width: 500px;
            height: 500px;
            left: 20%;
            top: 30%;
            background: rgba(0, 242, 255, 0.04);
            filter: blur(120px);
            border-radius: 50%;
            z-index: 0;
        }

        /* Contenedor Principal Estilo Tarjeta Glassmorphism */
        .login-card {
            background: rgba(30, 32, 36, 0.50);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 32px;
            backdrop-filter: blur(16px);
            box-shadow: 0px 25px 50px -12px rgba(0, 242, 255, 0.05);
            overflow: hidden;
            z-index: 1;
            max-width: 1100px;
            width: 100%;
        }

        /* Columna Izquierda (Banner Informativo) */
        .banner-side {
            background-color: #0C0E12;
            position: relative;
            overflow: hidden;
        }

        .banner-glow-1 {
            position: absolute;
            width: 300px;
            height: 300px;
            left: -100px;
            top: -100px;
            background: rgba(0, 242, 255, 0.08);
            filter: blur(70px);
            border-radius: 50%;
        }

        .banner-glow-2 {
            position: absolute;
            width: 300px;
            height: 300px;
            right: -100px;
            bottom: -100px;
            background: rgba(112, 0, 255, 0.08);
            filter: blur(70px);
            border-radius: 50%;
        }

        /* Logo Principal con Brillo */
        .logo-box {
            width: 80px;
            height: 80px;
            background: #00DBE7;
            color: #0C0E12;
            font-size: 2.5rem;
            box-shadow: 0px 0px 25px rgba(0, 242, 255, 0.6);
        }

        /* Mini Tarjetas Inferiores */
        .feature-card {
            background: rgba(30, 32, 36, 0.4);
            border: 1px solid rgba(0, 242, 255, 0.15);
            border-radius: 12px;
            padding: 14px;
            text-align: center;
            color: #00DBE7;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .feature-card i {
            font-size: 1.25rem;
            display: block;
            margin-bottom: 6px;
        }

        /* Columna Derecha (Formulario) */
        .form-side {
            background-color: #111318;
        }

        .form-label-custom {
            color: #B9CACB;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.8px;
        }

        .forgot-link {
            color: #00DBE7;
            font-size: 0.75rem;
            font-weight: 700;
            text-decoration: none;
        }
        .forgot-link:hover {
            text-decoration: underline;
        }

        /* Inputs Personalizados */
        .input-group-custom {
            background-color: #1A1C20;
            border: 1px solid #3A494B;
            border-bottom: 2px solid #3A494B;
            border-radius: 6px;
            display: flex;
            align-items: center;
            padding: 0 16px;
        }

        .input-group-custom i {
            color: #B9CACB;
            font-size: 1.1rem;
        }

        .input-group-custom .form-control {
            background: transparent;
            border: none;
            color: #E2E2E8;
            padding: 14px 12px;
            font-size: 0.95rem;
        }

        .input-group-custom .form-control:focus {
            box-shadow: none;
            outline: none;
        }

        .input-group-custom .form-control::placeholder {
            color: #5c6869;
        }

        /* Botón Principal Cyan */
        .btn-cyan-glow {
            background-color: #00F2FF;
            color: #002022;
            font-weight: 700;
            font-size: 1rem;
            padding: 14px;
            border-radius: 32px;
            border: none;
            box-shadow: 0px 0px 20px rgba(0, 242, 255, 0.4);
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center p-3 p-md-4">

<!-- Efectos de Fondo Ambientales -->
<div class="bg-glow-purple"></div>
<div class="bg-glow-cyan"></div>

<!-- Contenedor de la Tarjeta Principal -->
<div class="login-card row g-0">

    <!-- COLUMNA IZQUIERDA: Branding e Info -->
    <div class="col-lg-6 banner-side d-flex flex-column justify-content-between p-5 text-center">
        <div class="banner-glow-1"></div>
        <div class="banner-glow-2"></div>

        <div class="my-auto position-relative z-1">
            <!-- Icono/Logo Institucional -->
            <div class="logo-box rounded-3 d-flex align-items-center justify-content-center mx-auto mb-4">
                <i class="bi bi-building-columns-fill"></i>
            </div>

            <h1 class="display-5 fw-bold mb-3" style="color: #00DBE7;">FinTech Corp</h1>

            <!-- Texto serio, realista e inmersivo -->
            <p class="mx-auto mb-5" style="color: #B9CACB; max-width: 380px; font-size: 0.95rem; line-height: 1.6;">
                Administraci&oacute;n y control centralizado de fondos corporativos para equipos de trabajo.
            </p>
        </div>

        <!-- Fila de Características (Valores del Negocio Reales) -->
        <div class="row g-2 position-relative z-1 w-100 mx-0 mt-4">
            <div class="col-4">
                <div class="feature-card">
                    <i class="bi bi-shield-lock"></i>
                    CONTROL
                </div>
            </div>
            <div class="col-4">
                <div class="feature-card">
                    <i class="bi bi-sliders"></i>
                    FLEXIBLE
                </div>
            </div>
            <div class="col-4">
                <div class="feature-card">
                    <i class="bi bi-check-circle"></i>
                    EFICIENCIA
                </div>
            </div>
        </div>
    </div>

    <!-- COLUMNA DERECHA: Formulario de Login -->
    <div class="col-lg-6 form-side p-4 p-sm-5 d-flex flex-column justify-content-center">
        <div class="mx-auto w-100" style="max-width: 400px;">

            <div class="mb-4">
                <h2 class="fw-semibold mb-2" style="color: #E2E2E8; font-size: 1.5rem;">Bienvenido</h2>
                <p style="color: #B9CACB; font-size: 0.95rem; line-height: 1.5;">
                    Ingrese sus credenciales para acceder a su portal de gesti&oacute;n empresarial.
                </p>
            </div>

            <form>
                <!-- Input Correo Electrónico -->
                <div class="mb-4">
                    <label class="form-label-custom mb-2 d-block">CORREO ELECTR&Oacute;NICO</label>
                    <div class="input-group-custom">
                        <i class="bi bi-envelope"></i>
                        <input type="email" class="form-control" placeholder="nombre@ejemplo.com" required>
                    </div>
                </div>

                <!-- Input Contraseña -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <label class="form-label-custom m-0">CONTRASE&Ntilde;A</label>
                        <!-- Enlace actualizado con el nombre exacto de tu archivo JSP -->
                        <a href="recucontrasena.jsp" class="forgot-link">Olvid&eacute; mi contrase&ntilde;a</a>
                    </div>
                    <div class="input-group-custom">
                        <i class="bi bi-lock"></i>
                        <input type="password" class="form-control" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" required>
                        <i class="bi bi-eye ms-2" style="cursor: pointer;"></i>
                    </div>
                </div>

                <!-- Botón de Acción -->
                <button type="submit" class="btn btn-cyan-glow w-100 d-flex align-items-center justify-content-center gap-2 mt-2">
                    Iniciar Sesi&oacute;n <i class="bi bi-arrow-right"></i>
                </button>
            </form>

            <div class="mt-5 pt-3" style="border-top: 1px solid rgba(58, 73, 75, 0.30);"></div>

        </div>
    </div>

</div>

<script src="assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>