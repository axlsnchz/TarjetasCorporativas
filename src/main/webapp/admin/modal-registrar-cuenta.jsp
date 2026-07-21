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
                    <input type="hidden" name="idCuenta" id="inputIdCuenta" value="">
                    <div class="bg-figma-card p-4 rounded-3 shadow-lg" style="background: #14171C; border: 1px solid #30363d;">
                        <div class="row g-3">

                            <!-- Seleccionar Empleado (Titular) -->
                            <div class="col-12 col-md-6 mb-2">
                                <label class="form-label-figma">EMPLEADO / TITULAR</label>
                                <select name="idEmpleado" id="modalEmpleadoSelectCuenta" class="form-select form-figma-input" required>
                                    <option value="" disabled selected>Selecciona un empleado...</option>
                                    <c:forEach var="emp" items="${listaEmpleados}">
                                        <option value="${emp.idUsuario}">${emp.nombre} (${emp.correo})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Nombre de la Cuenta -->
                            <div class="col-12 col-md-6 mb-2">
                                <label class="form-label-figma">NOMBRE DE LA CUENTA</label>
                                <input type="text" name="nombreCuenta" id="inputNombreCuenta" class="form-control form-figma-input" placeholder="Ej. Viáticos, Bonos, Gasolina" required>
                            </div>

                            <!-- Descripción Breve -->
                            <div class="col-12 mb-2">
                                <label class="form-label-figma">DESCRIPCIÓN BREVE</label>
                                <input type="text" name="descripcion" id="inputDescripcionCuenta" class="form-control form-figma-input" placeholder="Ej. Cuenta de gastos corporativos" required>
                            </div>

                            <!-- Límite Asignado -->
                            <div class="col-12 mb-2">
                                <label class="form-label-figma">LÍMITE ASIGNADO (MXN)</label>
                                <div class="input-group">
                                    <span class="input-group-text border-0" style="background: #1e2024; color: #00DBE7; font-weight: bold;">$</span>
                                    <input type="number" step="0.01" min="0" name="limiteAsignado" id="inputLimiteAsignado" class="form-control form-figma-input ps-2" placeholder="10000.00" required>
                                </div>
                            </div>

                        </div>

                        <!-- Banner Informativo -->
                        <div class="info-box-figma p-3 my-3 d-flex align-items-start gap-3" style="background: #0c1a26; border: 1px solid #1e3a5f; border-radius: 8px;">
                            <i class="bi bi-info-circle text-cyan-neon fs-5 flex-shrink-0"></i>
                            <span id="bannerCuentaText" style="color: #bfdbfe; font-size: 11px; line-height: 1.5;">
                                La cuenta se creará para el empleado seleccionado. Podrás realizar depósitos a esta cuenta desde la opción <strong>Depositar Fondos</strong>.
                            </span>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-2">
                            <button type="button" class="btn btn-outline-figma-neon w-100 w-sm-auto text-center" data-bs-dismiss="modal">
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-figma-neon w-100 w-sm-auto d-inline-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-check-circle-fill"></i>
                                <span id="btnSubmitCuentaText">Crear Cuenta</span>
                            </button>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    window.prepararModalRegistrarCuenta = function() {
        const modalLabel = document.getElementById("modalRegistrarCuentaLabel");
        const btnText = document.getElementById("btnSubmitCuentaText");
        const inputId = document.getElementById("inputIdCuenta");
        const banner = document.getElementById("bannerCuentaText");

        if (modalLabel) modalLabel.textContent = "Crear Nueva Cuenta Corporativa";
        if (btnText) btnText.textContent = "Crear Cuenta";
        if (inputId) inputId.value = "";
        if (banner) banner.innerHTML = 'La cuenta se creará para el empleado seleccionado. Podrás realizar depósitos a esta cuenta desde la opción <strong>Depositar Fondos</strong>.';

        const form = document.getElementById("formRegistrarCuenta");
        if (form) form.action = "${pageContext.request.contextPath}/admin/registrar-cuenta";

        const empSelect = document.getElementById("modalEmpleadoSelectCuenta");
        if (empSelect) { empSelect.selectedIndex = 0; empSelect.disabled = false; }
        const nombreInput = document.getElementById("inputNombreCuenta");
        if (nombreInput) nombreInput.value = "";
        const descInput = document.getElementById("inputDescripcionCuenta");
        if (descInput) descInput.value = "";
        const limiteInput = document.getElementById("inputLimiteAsignado");
        if (limiteInput) limiteInput.value = "";
    };

    window.prepararModalEditarCuenta = function(idCuenta, idEmpleado, nombreCuenta, descripcion, limiteAsignado) {
        const modalLabel = document.getElementById("modalRegistrarCuentaLabel");
        const btnText = document.getElementById("btnSubmitCuentaText");
        const inputId = document.getElementById("inputIdCuenta");
        const banner = document.getElementById("bannerCuentaText");

        if (modalLabel) modalLabel.textContent = "Editar Cuenta Corporativa";
        if (btnText) btnText.textContent = "Guardar Cambios";
        if (inputId) inputId.value = idCuenta || "";
        if (banner) banner.innerHTML = 'Actualiza la información y el límite financiero asignado a esta cuenta corporativa.';

        const form = document.getElementById("formRegistrarCuenta");
        if (form) form.action = "${pageContext.request.contextPath}/admin/editar-cuenta";

        const empSelect = document.getElementById("modalEmpleadoSelectCuenta");
        if (empSelect && idEmpleado) { empSelect.value = idEmpleado; }
        const nombreInput = document.getElementById("inputNombreCuenta");
        if (nombreInput) nombreInput.value = nombreCuenta || "";
        const descInput = document.getElementById("inputDescripcionCuenta");
        if (descInput) descInput.value = descripcion || "";
        const limiteInput = document.getElementById("inputLimiteAsignado");
        if (limiteInput) limiteInput.value = limiteAsignado || "";
    };
</script>
