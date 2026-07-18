<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Modal Bootstrap 5 para Crear Nueva Cuenta -->
<div class="modal fade" id="modalRegistrarCuenta" tabindex="-1" aria-labelledby="modalRegistrarCuentaLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background: #0d1117; border: 1px solid #30363d; border-radius: 16px; color: #E2E2E8;">
            
            <div class="modal-header border-bottom-0 pb-0 pt-4 px-4">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <h4 class="modal-title fw-semibold text-white m-0 lh-sm" id="modalRegistrarCuentaLabel" style="font-size: 1.8rem; color: #E1FDFF !important;">Crear Nueva Cuenta Corporativa</h4>
                    </div>
                    <p class="text-muted m-0 mt-1 small" style="color: #B9CACB !important;">
                        Asigna fondos y límites financieros a un empleado. 
                        <span class="badge font-monospace ms-1" style="background: rgba(0, 229, 255, 0.1); color: #00E5FF; border: 1px solid rgba(0, 229, 255, 0.3);">
                            Disponible Concentradora: $<fmt:formatNumber value="${saldoConcentradora}" pattern="#,##0.00"/> MXN
                        </span>
                    </p>
                </div>
                <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">
                <form action="${pageContext.request.contextPath}/admin/registrar-cuenta" method="POST" id="formRegistrarCuenta">
                    <div class="bg-figma-card p-4 rounded-3 shadow-lg" style="background: #14171C; border: 1px solid #30363d;">
                        <div class="row g-3">

                            <!-- Seleccionar Empleado (Titular) -->
                            <div class="col-12 col-md-6 mb-2">
                                <label class="form-label-figma">EMPLEADO / TITULAR</label>
                                <select name="idEmpleado" class="form-select form-figma-input" required>
                                    <option value="" disabled selected>Selecciona un empleado...</option>
                                    <c:forEach var="emp" items="${listaEmpleados}">
                                        <option value="${emp.idUsuario}">${emp.nombre} (${emp.correo})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Nombre de la Cuenta -->
                            <div class="col-12 col-md-6 mb-2">
                                <label class="form-label-figma">NOMBRE DE LA CUENTA</label>
                                <input type="text" name="nombreCuenta" class="form-control form-figma-input" placeholder="Ej. Viáticos, Bonos, Gasolina" required>
                            </div>

                            <!-- Descripción Breve -->
                            <div class="col-12 mb-2">
                                <label class="form-label-figma">DESCRIPCIÓN BREVE</label>
                                <input type="text" name="descripcion" class="form-control form-figma-input" placeholder="Ej. Cuenta de gastos corporativos" required>
                            </div>

                            <!-- Límite Asignado -->
                            <div class="col-12 mb-2">
                                <label class="form-label-figma">LÍMITE ASIGNADO (MXN)</label>
                                <div class="input-group">
                                    <span class="input-group-text border-0" style="background: #1e2024; color: #00DBE7; font-weight: bold;">$</span>
                                    <input type="number" step="0.01" min="0" name="limiteAsignado" class="form-control form-figma-input ps-2" placeholder="10000.00" required>
                                </div>
                            </div>

                        </div>

                        <!-- Banner Informativo -->
                        <div class="info-box-figma p-3 my-3 d-flex align-items-start gap-3" style="background: #0c1a26; border: 1px solid #1e3a5f; border-radius: 8px;">
                            <i class="bi bi-info-circle text-cyan-neon fs-5 flex-shrink-0"></i>
                            <span style="color: #bfdbfe; font-size: 11px; line-height: 1.5;">
                                La cuenta se creará para el empleado seleccionado. Podrás realizar depósitos a esta cuenta desde la opción <strong>Depositar Fondos</strong>.
                            </span>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-2">
                            <button type="button" class="btn btn-outline-figma-neon w-100 w-sm-auto text-center" data-bs-dismiss="modal">
                                Cancelar
                            </button>
                            <button type="submit" id="btnSubmitCrearCuenta" class="btn btn-figma-neon w-100 w-sm-auto d-inline-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-check-circle-fill"></i>
                                <span>Crear Cuenta</span>
                            </button>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
