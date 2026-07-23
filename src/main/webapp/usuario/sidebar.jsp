<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Detecta automáticamente la URL actual para activar el botón correcto
  String uri = request.getRequestURI();
%>

<!-- Estilos específicos y correcciones del Sidebar centralizados -->
<style>
  #sidebarUsuario {
    height: 100vh !important;
    width: 260px;
    border-color: rgba(58, 73, 75, 0.15) !important;
    z-index: 1050;
  }
  @media (min-width: 768px) {
    #sidebarUsuario {
      position: fixed !important;
      top: 0;
      left: 0;
    }
  }
</style>

<nav class="offcanvas-md offcanvas-start bg-figma-sidebar border-end d-flex flex-column py-4 backdrop-blur shadow"
     id="sidebarUsuario" tabindex="-1" aria-labelledby="sidebarUsuarioLabel">

  <!-- Botón de cierre para móvil -->
  <div class="offcanvas-header d-md-none justify-content-end px-4 pt-2 pb-0">
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" data-bs-target="#sidebarUsuario" aria-label="Close"></button>
  </div>

  <div class="w-100">
    <!-- Brand / Logo -->
    <div class="px-4 mb-4">
      <div class="d-flex align-items-center gap-3 mb-1">
        <div class="rounded-3 d-flex align-items-center justify-content-center text-dark flex-shrink-0"
             style="width: 44px; height: 44px; background-color: #00DBE7; box-shadow: 0px 0px 18px rgba(0, 242, 255, 0.6);">
          <i class="bi bi-building-columns-fill fs-3" style="color: #002022;"></i>
        </div>
        <div>
          <h1 class="fw-bold lh-1 text-figma-cyan m-0" style="font-size: 1.4rem;">FinTech Corp</h1>
          <div class="text-uppercase text-figma-muted fw-bold small tracking-wider mt-1" style="font-size: 0.65rem; letter-spacing: 0.6px;">
            Banca Institucional
          </div>
        </div>
      </div>
    </div>

    <!-- Menú de navegación unificado con lógica automática de 'active' -->
    <div class="d-flex flex-column gap-1 mt-4">
      <a href="principal-usuario.jsp"
         class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= uri.contains("principal-usuario.jsp") ? "active" : "" %>">
        <i class="bi bi-grid-1x2-fill fs-5"></i> <span>Panel principal</span>
      </a>

      <a href="gestion-cuentas-usuario.jsp"
         class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= uri.contains("gestion-cuentas-usuario.jsp") ? "active" : "" %>">
        <i class="bi bi-bank fs-5"></i> <span>Cuentas</span>
      </a>

      <a href="gestion-tarjetas-usuario.jsp"
         class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= uri.contains("gestion-tarjetas-usuario.jsp") ? "active" : "" %>">
        <i class="bi bi-credit-card fs-5"></i> <span>Tarjetas</span>
      </a>

      <a href="gestion-transferencia-usuario.jsp"
         class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= uri.contains("gestion-transferencia-usuario.jsp") ? "active" : "" %>">
        <i class="bi bi-arrow-left-right fs-5"></i> <span>Transferencias</span>
      </a>

      <a href="configuracion-usuario.jsp"
         class="sidebar-link d-flex align-items-center gap-3 px-4 py-3 text-decoration-none <%= uri.contains("configuracion-usuario.jsp") ? "active" : "" %>">
        <i class="bi bi-gear fs-5"></i> <span>Configuración</span>
      </a>
    </div>
  </div>

  <!-- Botón de Cerrar Sesión empujado al fondo -->
  <div class="px-4 w-100 mt-auto">
    <a href="${pageContext.request.contextPath}/login?accion=logout" class="btn w-100 py-2 text-center text-secondary border border-secondary bg-transparent rounded-3 text-decoration-none d-flex align-items-center justify-content-center gap-2"
       style="color: #BAC9CC !important; border-color: #3B494C !important;">
      <i class="bi bi-box-arrow-right fs-5"></i> <span>Cerrar Sesión</span>
    </a>
  </div>
</nav>