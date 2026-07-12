<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Extraemos de forma limpia el nombre exacto del archivo JSP en ejecución
    String uri = request.getRequestURI();
    String currentPage = uri.substring(uri.lastIndexOf("/") + 1).toLowerCase();
%>

<!-- Estilos específicos del Sidebar de Administración -->
<style>
    #sidebarAdmin {
        height: 100vh !important;
        width: 260px;
        background-color: #0c0e12 !important;
        border-right: 1px solid rgba(58, 73, 75, 0.15) !important;
        z-index: 1050;
    }

    .sidebar-link {
        color: #B9CACB !important;
        transition: all 0.2s ease;
        border-left: 4px solid transparent;
        font-weight: 500;
    }

    .sidebar-link:hover {
        color: #00DBE7 !important;
        background: rgba(0, 219, 231, 0.05);
    }

    /* Prioridad absoluta al estado activo real */
    .sidebar-link.active {
        color: #00DBE7 !important;
        background: rgba(112, 0, 255, 0.20) !important;
        border-left: 4px solid #00DBE7 !important;
        font-weight: 600 !important;
    }

    @media (min-width: 768px) {
        #sidebarAdmin {
            position: fixed !important;
            top: 0;
            left: 0;
        }
    }
</style>

<nav class="offcanvas-md offcanvas-start d-flex flex-column py-4 shadow"
     id="sidebarAdmin" tabindex="-1" aria-labelledby="sidebarAdminLabel">

    <!-- Botón de cierre para versión móvil -->
    <div class="offcanvas-header d-md-none justify-content-end px-4 pt-2 pb-0">
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" data-bs-target="#sidebarAdmin" aria-label="Close"></button>
    </div>

    <div class="w-100">
        <!-- Brand / Logo Corporativo -->
        <div class="px-4 mb-5">
            <h1 class="fw-bold lh-1 text-info display-6" style="color: #00DBE7 !important; font-family: 'Inter', sans-serif;">FinTech<br>Corp</h1>
            <div class="text-uppercase fw-bold small tracking-wider" style="font-size: 0.7rem; letter-spacing: 0.6px; color: #B9CACB; opacity: 0.6;">
                Banca Institucional
            </div>
        </div>

        <!-- Menú de navegación con detección precisa mediante finalización de cadena -->
        <div class="d-flex flex-column gap-1 mt-4">
            <a href="principal-admin.jsp"
               class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= (currentPage.endsWith("principal-admin.jsp") || currentPage.contains("resumen")) ? "active" : "" %>">
                <i class="bi bi-grid-1x2-fill fs-5"></i> <span>Panel principal</span>
            </a>

            <a href="gestion-empleados.jsp"
               class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= currentPage.endsWith("gestion-empleados.jsp") ? "active" : "" %>">
                <i class="bi bi-people-fill fs-5"></i> <span>Empleados</span>
            </a>

            <a href="gestion-cuentas.jsp"
               class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= currentPage.endsWith("gestion-cuentas.jsp") ? "active" : "" %>">
                <i class="bi bi-bank fs-5"></i> <span>Cuentas</span>
            </a>

            <a href="gestion-tarjetas.jsp"
               class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= currentPage.endsWith("gestion-tarjetas.jsp") ? "active" : "" %>">
                <i class="bi bi-credit-card fs-5"></i> <span>Tarjetas</span>
            </a>
        </div>
    </div>

    <!-- Botón de Cerrar Sesión inferior -->
    <div class="px-4 w-100 mt-auto">
        <button class="btn w-100 py-2 text-center bg-transparent rounded-3"
                style="color: #BAC9CC !important; border: 1px solid #3B494C !important;">
            Cerrar Sesión
        </button>
    </div>
</nav>