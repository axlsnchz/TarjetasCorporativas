<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Modal Bootstrap 5 para Depositar Fondos desde la Cuenta Concentradora a un Empleado -->
<div class="modal fade" id="modalDepositarEmpleado" tabindex="-1" aria-labelledby="modalDepositarEmpleadoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content text-white border-0 shadow-lg" style="background: #0D0F14; border-radius: 24px; border: 1px solid rgba(255, 255, 255, 0.08);">
            
            <!-- Encabezado del Modal -->
            <div class="modal-header border-0 px-4 pt-4 pb-2 d-flex justify-content-between align-items-center">
                <h3 class="modal-title fw-bold text-white mb-0" id="modalDepositarEmpleadoLabel" style="font-size: 1.75rem; letter-spacing: -0.02em;">
                    Depositar Fondos
                </h3>
                <button type="button" class="btn-close btn-close-white bg-secondary bg-opacity-25 rounded-circle p-2" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <!-- Cuerpo del Modal -->
            <div class="modal-body px-4 py-3">
                <form action="${pageContext.request.contextPath}/admin/depositar-cuenta" method="POST" id="formDepositarEmpleado">
                    <input type="hidden" id="depositoIdCuenta" name="idCuenta" value="">

                    <div class="row g-4">
                        <!-- Columna Izquierda: Selección de Cuenta -->
                        <div class="col-12 col-md-5">
                            <div class="p-3 p-md-4 rounded-4 h-100 d-flex flex-column" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                                <span class="d-block fw-bold text-uppercase tracking-wider mb-3" style="font-size: 0.7rem; color: #00DBE7; letter-spacing: 0.1em;">
                                    SELECCIÓN DE CUENTA
                                </span>

                                <!-- Nombre del empleado -->
                                <div class="mb-3">
                                    <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                        NOMBRE DEL EMPLEADO
                                    </label>
                                    <select id="depositoSelectEmpleado" class="form-select form-figma-select py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" onchange="onEmpleadoChange()">
                                        <option value="" disabled selected>Seleccionar empleado</option>
                                    </select>
                                </div>

                                <!-- Tipo de cuenta / Cuenta -->
                                <div class="mb-3">
                                    <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                        TIPO DE CUENTA
                                    </label>
                                    <select id="depositoSelectCuenta" class="form-select form-figma-select py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" onchange="onCuentaChange()" required disabled>
                                        <option value="" disabled selected>Seleccionar cuenta</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Columna Derecha: Detalles del Depósito -->
                        <div class="col-12 col-md-7">
                            <div class="p-3 p-md-4 rounded-4 h-100 d-flex flex-column justify-content-between" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                                <div>
                                    <span class="d-block fw-bold text-uppercase tracking-wider mb-3" style="font-size: 0.7rem; color: #00DBE7; letter-spacing: 0.1em;">
                                        DETALLES DEL DEPÓSITO
                                    </span>

                                    <!-- Indicador de Saldo en Concentradora -->
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <span class="small text-muted">Disponible en Concentradora:</span>
                                        <span class="fw-bold text-cyan-neon font-monospace">
                                            $<fmt:formatNumber value="${saldoConcentradora}" pattern="#,##0.00"/> MXN
                                        </span>
                                    </div>

                                    <!-- Monto a Depositar -->
                                    <div class="mb-3">
                                        <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                            MONTO A DEPOSITAR (MXN)
                                        </label>
                                        <div class="input-group">
                                            <span class="input-group-text border-0 text-cyan-neon fw-bold" style="background-color: #1E2024;">$</span>
                                            <input type="number" step="0.01" min="0.01" id="depositoMonto" name="monto" class="form-control form-figma-input py-2 border-0 shadow-none text-white ps-2" style="background-color: #1E2024 !important;" placeholder="0.00" required>
                                        </div>
                                        <div id="depositoWarningSaldo" class="alert alert-danger py-2 px-3 border-0 mt-2 d-none font-monospace small" style="background: rgba(239, 68, 68, 0.2); border-left: 4px solid #ef4444 !important; color: #f87171;">
                                            <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>No hay fondos suficientes</strong> (Disponible: $<fmt:formatNumber value="${saldoConcentradora}" pattern="#,##0.00"/> MXN)
                                        </div>
                                    </div>

                                    <!-- Concepto / Descripción -->
                                    <div class="mb-3">
                                        <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                            CONCEPTO (OPCIONAL)
                                        </label>
                                        <textarea name="descripcion" id="depositoDescripcion" class="form-control form-figma-input py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" rows="2" placeholder="Ej. Bono de Gasolina Semanal">Depósito desde Cuenta Concentradora</textarea>
                                    </div>

                                    <!-- Diagrama de Flujo Visual -->
                                    <div class="p-3 rounded-4 my-3 d-flex align-items-center justify-content-between" style="background: #0B0E11; border: 1px solid rgba(255, 255, 255, 0.05);">
                                        <!-- Nodo Origen: Empresa -->
                                        <div class="d-flex flex-column align-items-center text-center">
                                            <div class="rounded-circle d-flex align-items-center justify-content-center mb-1"
                                                 style="width: 44px; height: 44px; background: rgba(0, 229, 255, 0.1); color: #00E5FF; border: 1px solid rgba(0, 229, 255, 0.25);">
                                                <i class="bi bi-building fs-5"></i>
                                            </div>
                                            <span class="small fw-semibold text-muted" style="font-size: 11px;">Empresa</span>
                                        </div>

                                        <!-- Flecha Conectora animada -->
                                        <div class="flex-grow-1 mx-3 d-flex align-items-center justify-content-center position-relative" style="height: 2px; background: linear-gradient(90deg, #00E5FF 0%, rgba(0, 229, 255, 0.2) 100%);">
                                            <div class="position-absolute rounded-circle" style="width: 8px; height: 8px; background: #00E5FF; top: -3px; right: 20%;"></div>
                                            <i class="bi bi-chevron-right position-absolute text-cyan-neon" style="right: -4px; top: -7px; font-size: 12px;"></i>
                                        </div>

                                        <!-- Nodo Destino: Empleado - Cuenta -->
                                        <div class="d-flex flex-column align-items-center text-center">
                                            <div class="rounded-circle d-flex align-items-center justify-content-center mb-1"
                                                 style="width: 44px; height: 44px; background: rgba(0, 229, 255, 0.1); color: #00E5FF; border: 1px solid rgba(0, 229, 255, 0.25);">
                                                <i class="bi bi-file-earmark-text fs-5"></i>
                                            </div>
                                            <span class="small fw-semibold text-white text-truncate" id="diagramaDestinoTexto" style="font-size: 11px; max-width: 140px;">
                                                Seleccionar destino
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Botones de Acción -->
                                <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-3">
                                    <button type="button" class="btn btn-outline-figma-neon px-4 py-2.5 d-inline-flex align-items-center justify-content-center gap-2 text-center rounded-pill font-inter fw-bold w-100 w-sm-auto text-nowrap" style="min-width: 160px; font-size: 0.875rem;" data-bs-dismiss="modal">
                                        <i class="bi bi-x-circle fs-6"></i>
                                        <span>Cancelar</span>
                                    </button>
                                    <button type="submit" id="btnSubmitDepositarEmpleado" class="btn btn-figma-neon px-4 py-2.5 d-inline-flex align-items-center justify-content-center gap-2 text-center rounded-pill font-inter fw-bold shadow-sm w-100 w-sm-auto text-nowrap" style="min-width: 160px; font-size: 0.875rem; letter-spacing: 0.02em;">
                                        <i class="bi bi-file-earmark-plus-fill fs-6"></i>
                                        <span>Confirmar Depósito</span>
                                    </button>
                                </div>

                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Listado de cuentas cargado dinámicamente desde Java
    const arrayCuentasEmpleados = [
        <c:forEach var="cta" items="${listaCuentas}" varStatus="status">
            <c:if test="${cta.activo}">
            {
                idCuenta: "${cta.idCuenta}",
                idEmpleado: "${cta.idEmpleado}",
                nombreEmpleado: "${empty cta.nombreEmpleado ? 'Empleado' : cta.nombreEmpleado}",
                nombreCuenta: "${cta.nombreCuenta}",
                numeroCuenta: "${cta.numeroCuenta}"
            }${!status.last ? ',' : ''}
            </c:if>
        </c:forEach>
    ];

    function popularEmpleadosDropdown() {
        const selectEmp = document.getElementById("depositoSelectEmpleado");
        if (!selectEmp) return;

        selectEmp.innerHTML = '<option value="" disabled selected>Seleccionar empleado</option>';
        const empleadosMap = new Map();

        arrayCuentasEmpleados.forEach(item => {
            if (item.idEmpleado && !empleadosMap.has(item.idEmpleado)) {
                empleadosMap.set(item.idEmpleado, item.nombreEmpleado);
            }
        });

        empleadosMap.forEach((nombre, id) => {
            const opt = document.createElement("option");
            opt.value = id;
            opt.textContent = nombre;
            selectEmp.appendChild(opt);
        });
    }

    function abrirModalDepositoGeneral() {
        popularEmpleadosDropdown();
        document.getElementById("depositoSelectEmpleado").value = "";
        
        const selectCta = document.getElementById("depositoSelectCuenta");
        selectCta.innerHTML = '<option value="" disabled selected>Seleccionar cuenta</option>';
        selectCta.disabled = true;

        document.getElementById("depositoIdCuenta").value = "";
        document.getElementById("depositoMonto").value = "";
        document.getElementById("depositoDescripcion").value = "Depósito desde Cuenta Concentradora";
        document.getElementById("diagramaDestinoTexto").textContent = "Seleccionar destino";

        const warningBox = document.getElementById("depositoWarningSaldo");
        const btnSubmit = document.getElementById("btnSubmitDepositarEmpleado");
        if (warningBox) warningBox.classList.add("d-none");
        if (btnSubmit) btnSubmit.disabled = false;
    }

    function prepararModalDeposito(idCuenta, titular, nombreCuenta) {
        popularEmpleadosDropdown();
        
        const ctaItem = arrayCuentasEmpleados.find(item => item.idCuenta === String(idCuenta));
        if (ctaItem && ctaItem.idEmpleado) {
            document.getElementById("depositoSelectEmpleado").value = ctaItem.idEmpleado;
            onEmpleadoChange();
            document.getElementById("depositoSelectCuenta").value = idCuenta;
            document.getElementById("depositoIdCuenta").value = idCuenta;
            document.getElementById("diagramaDestinoTexto").textContent = ctaItem.nombreEmpleado + " - " + ctaItem.nombreCuenta;
        } else {
            document.getElementById("depositoIdCuenta").value = idCuenta;
            document.getElementById("diagramaDestinoTexto").textContent = titular + " - " + nombreCuenta;
        }

        document.getElementById("depositoMonto").value = "";
        const warningBox = document.getElementById("depositoWarningSaldo");
        const btnSubmit = document.getElementById("btnSubmitDepositarEmpleado");
        if (warningBox) warningBox.classList.add("d-none");
        if (btnSubmit) btnSubmit.disabled = false;
    }

    function onEmpleadoChange() {
        const idEmp = document.getElementById("depositoSelectEmpleado").value;
        const selectCta = document.getElementById("depositoSelectCuenta");
        selectCta.innerHTML = '<option value="" disabled selected>Seleccionar cuenta</option>';

        const cuentasFiltradas = arrayCuentasEmpleados.filter(item => item.idEmpleado === idEmp);

        if (cuentasFiltradas.length > 0) {
            selectCta.disabled = false;
            cuentasFiltradas.forEach(item => {
                const opt = document.createElement("option");
                opt.value = item.idCuenta;
                opt.textContent = item.nombreCuenta + " (" + item.numeroCuenta + ")";
                selectCta.appendChild(opt);
            });

            // Seleccionar automáticamente la primera si solo hay 1
            if (cuentasFiltradas.length === 1) {
                selectCta.value = cuentasFiltradas[0].idCuenta;
                onCuentaChange();
            } else {
                document.getElementById("depositoIdCuenta").value = "";
                document.getElementById("diagramaDestinoTexto").textContent = "Seleccionar cuenta";
            }
        } else {
            selectCta.disabled = true;
            document.getElementById("depositoIdCuenta").value = "";
            document.getElementById("diagramaDestinoTexto").textContent = "Sin cuentas activas";
        }
    }

    function onCuentaChange() {
        const idCta = document.getElementById("depositoSelectCuenta").value;
        document.getElementById("depositoIdCuenta").value = idCta;

        const ctaItem = arrayCuentasEmpleados.find(item => item.idCuenta === String(idCta));
        if (ctaItem) {
            document.getElementById("diagramaDestinoTexto").textContent = ctaItem.nombreEmpleado + " - " + ctaItem.nombreCuenta;
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        popularEmpleadosDropdown();

        const inputMonto = document.getElementById("depositoMonto");
        const warningBox = document.getElementById("depositoWarningSaldo");
        const form = document.getElementById("formDepositarEmpleado");
        const btnSubmit = document.getElementById("btnSubmitDepositarEmpleado");
        const saldoDisponible = parseFloat("${saldoConcentradora != null ? saldoConcentradora : 0}");

        function validarSaldo() {
            const val = parseFloat(inputMonto.value) || 0;
            if (val > saldoDisponible) {
                warningBox.classList.remove("d-none");
                if (btnSubmit) btnSubmit.disabled = true;
                return false;
            } else {
                warningBox.classList.add("d-none");
                if (btnSubmit) btnSubmit.disabled = false;
                return true;
            }
        }

        if (inputMonto && warningBox) {
            inputMonto.addEventListener("input", validarSaldo);
        }

        if (form) {
            form.addEventListener("submit", function(e) {
                const idCta = document.getElementById("depositoIdCuenta").value;
                if (!idCta) {
                    e.preventDefault();
                    alert("Debe seleccionar un empleado y una cuenta de destino.");
                    return;
                }
                if (!validarSaldo()) {
                    e.preventDefault();
                    alert("No hay fondos suficientes en la Cuenta Concentradora para realizar este depósito.");
                }
            });
        }
    });
</script>
