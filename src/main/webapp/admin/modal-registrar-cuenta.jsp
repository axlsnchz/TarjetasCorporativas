<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Modal Bootstrap 5 para Crear Nueva Cuenta -->
<div class="modal fade" id="modalRegistrarCuenta" tabindex="-1" aria-labelledby="modalRegistrarCuentaLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content text-white border-0 shadow-lg" style="background: #0D0F14; border-radius: 24px; border: 1px solid rgba(255, 255, 255, 0.08);">
            
            <div class="modal-header border-0 px-4 pt-4 pb-2 d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="modal-title fw-bold text-white mb-0" id="modalRegistrarCuentaLabel" style="font-size: 1.75rem; letter-spacing: -0.02em;">
                        Crear Nueva Cuenta Corporativa
                    </h3>
                    <p class="text-muted m-0 mt-1 small" style="color: #BAC9CC !important;">
                        Asigna fondos y límites financieros a un empleado.
                    </p>
                </div>
                <button type="button" class="btn-close btn-close-white bg-secondary bg-opacity-25 rounded-circle p-2" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body px-4 py-3">
                <form action="${pageContext.request.contextPath}/admin/registrar-cuenta" method="POST" id="formRegistrarCuenta">
                    <input type="hidden" name="idCuenta" id="inputIdCuenta" value="">
                    
                    <div class="p-3 p-md-4 rounded-4" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                        <div class="row g-3">

                            <!-- Seleccionar Empleado (Titular) -->
                            <div class="col-12 col-md-6 mb-2">
                                <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                    EMPLEADO / TITULAR
                                </label>
                                <select name="idEmpleado" id="modalEmpleadoSelectCuenta" class="form-select form-figma-select py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" required>
                                    <option value="" disabled selected>Selecciona un empleado...</option>
                                    <c:forEach var="emp" items="${listaEmpleados}">
                                        <option value="${emp.idUsuario}">${emp.nombre} (${emp.correo})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Nombre de la Cuenta -->
                            <div class="col-12 col-md-6 mb-2">
                                <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                    NOMBRE DE LA CUENTA
                                </label>
                                <input type="text" name="nombreCuenta" id="inputNombreCuenta" class="form-control form-figma-input py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" placeholder="Ej. Viáticos, Bonos, Gasolina" required>
                            </div>

                            <!-- Descripción Breve -->
                            <div class="col-12 mb-2">
                                <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                    DESCRIPCIÓN BREVE
                                </label>
                                <input type="text" name="descripcion" id="inputDescripcionCuenta" class="form-control form-figma-input py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" placeholder="Ej. Cuenta de gastos corporativos" required>
                            </div>

                            <!-- Límite Asignado -->
                            <div class="col-12 mb-2">
                                <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                    LÍMITE ASIGNADO (MXN)
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text border-0 text-cyan-neon fw-bold" style="background-color: #1E2024;">$</span>
                                    <input type="number" step="0.01" min="0" name="limiteAsignado" id="inputLimiteAsignado" class="form-control form-figma-input py-2 border-0 shadow-none text-white ps-2" style="background-color: #1E2024 !important;" placeholder="10000.00" required>
                                </div>
                            </div>

                        </div>

                        <!-- Banner Informativo -->
                        <div class="p-3 my-3 d-flex align-items-center gap-3 rounded-3" style="background: rgba(0, 229, 255, 0.04); border: 1px solid rgba(0, 229, 255, 0.1);">
                            <i class="bi bi-info-circle text-cyan-neon fs-5 flex-shrink-0"></i>
                            <span id="bannerCuentaText" style="color: #BAC9CC; font-size: 0.8rem; line-height: 1.5;">
                                La cuenta se creará para el empleado seleccionado. Podrás realizar depósitos a esta cuenta desde la opción <strong>Depositar Fondos</strong>.
                            </span>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-3">
                            <button type="button" class="btn btn-outline-figma-neon px-4 py-2.5 d-inline-flex align-items-center justify-content-center gap-2 text-center rounded-pill font-inter fw-bold w-100 w-sm-auto text-nowrap" style="min-width: 160px; font-size: 0.875rem;" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle fs-6"></i>
                                <span>Cancelar</span>
                            </button>
                            <button type="submit" class="btn btn-figma-neon px-4 py-2.5 d-inline-flex align-items-center justify-content-center gap-2 text-center rounded-pill font-inter fw-bold shadow-sm w-100 w-sm-auto text-nowrap" style="min-width: 160px; font-size: 0.875rem; letter-spacing: 0.02em;">
                                <i class="bi bi-check-circle-fill fs-6"></i>
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
