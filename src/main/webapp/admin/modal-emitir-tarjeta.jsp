<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Modal Emitir Nueva Tarjeta -->
<div class="modal fade" id="modalEmitirTarjeta" tabindex="-1" aria-labelledby="modalEmitirTarjetaLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 860px;">
    <div class="modal-content text-white border-0 shadow-lg" style="background: #0D0F14; border-radius: 24px; border: 1px solid rgba(255, 255, 255, 0.08);">
      
      <!-- Modal Header -->
      <div class="modal-header border-0 px-4 pt-4 pb-2 d-flex justify-content-between align-items-center">
        <h3 class="modal-title fw-bold text-white mb-0" id="modalEmitirTarjetaLabel" style="font-size: 1.75rem; letter-spacing: -0.02em;">
          Configura la nueva credencial
        </h3>
        <button type="button" class="btn-close btn-close-white bg-secondary bg-opacity-25 rounded-circle p-2" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>

      <form action="${pageContext.request.contextPath}/admin/emitir-tarjeta" method="POST" id="formEmitirTarjeta" autocomplete="off">
        <input type="hidden" name="idTarjeta" id="inputIdTarjeta" value="">
        <!-- Modal Body -->
        <div class="modal-body px-4 py-3">
          <div class="row g-4">
            
            <!-- Columna Izquierda: Identificación y Modalidad -->
            <div class="col-12 col-md-5 d-flex flex-column gap-3">
              
              <!-- Card 1: Identificación -->
              <div class="p-3 p-md-4 rounded-4" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                <span class="d-block fw-bold text-uppercase tracking-wider mb-3" style="font-size: 0.7rem; color: #00DBE7; letter-spacing: 0.1em;">
                  IDENTIFICACIÓN
                </span>
                
                <!-- Nombre del Empleado -->
                <div class="mb-3">
                  <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #94A3B8 !important; letter-spacing: 0.05em;">
                    NOMBRE DEL EMPLEADO
                  </label>
                  <select id="modalEmpleadoSelect" class="form-select form-figma-select py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" required>
                    <option value="" selected disabled>Seleccionar empleado</option>
                    <c:forEach var="emp" items="${listaEmpleados}">
                      <c:if test="${emp.activo}">
                        <option value="${emp.idUsuario}" data-nombre="${emp.nombre}">
                          ${emp.nombre}
                        </option>
                      </c:if>
                    </c:forEach>
                  </select>
                </div>

                <!-- Tipo de Cuenta del Empleado -->
                <div>
                  <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #94A3B8 !important; letter-spacing: 0.05em;">
                    TIPO DE CUENTA
                  </label>
                  <select id="modalCuentaSelect" name="idCuenta" class="form-select form-figma-select py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" required disabled>
                    <option value="" selected disabled>Seleccionar cuenta</option>
                  </select>
                </div>
              </div>

              <!-- Card 2: Modalidad de Tarjeta -->
              <div class="p-3 p-md-4 rounded-4 flex-grow-1" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                <span class="d-block fw-bold text-uppercase tracking-wider mb-3" style="font-size: 0.7rem; color: #00DBE7; letter-spacing: 0.1em;">
                  MODALIDAD DE TARJETA
                </span>

                <input type="hidden" name="tipoTarjeta" id="inputTipoTarjeta" value="VIRTUAL">

                <div class="row g-2">
                  <!-- Botón Option Virtual -->
                  <div class="col-6">
                    <button type="button" id="btnModeVirtual" class="btn w-100 p-3 d-flex flex-column align-items-center justify-content-center gap-2 rounded-3 mode-card-btn active-mode"
                            style="background: #0B0E11; border: 2px solid #00DBE7; color: #00DBE7; transition: all 0.2s ease;">
                      <i class="bi bi-phone fs-3"></i>
                      <span class="fw-bold tracking-wider" style="font-size: 0.75rem;">VIRTUAL</span>
                    </button>
                  </div>
                  <!-- Botón Option Física -->
                  <div class="col-6">
                    <button type="button" id="btnModeFisica" class="btn w-100 p-3 d-flex flex-column align-items-center justify-content-center gap-2 rounded-3 mode-card-btn"
                            style="background: #0B0E11; border: 1px solid rgba(255, 255, 255, 0.08); color: #64748B; transition: all 0.2s ease;">
                      <i class="bi bi-credit-card-2-front fs-3"></i>
                      <span class="fw-bold tracking-wider" style="font-size: 0.75rem;">FÍSICA</span>
                    </button>
                  </div>
                </div>
              </div>

            </div>

            <!-- Columna Derecha: Vista Previa y Datos de Tarjeta -->
            <div class="col-12 col-md-7 d-flex flex-column gap-3">
              
              <!-- Card 3: Contenedor Completo Derecha -->
              <div class="p-3 p-md-4 rounded-4" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                
                <!-- Live Card Preview Element -->
                <div class="card-preview-box p-4 rounded-4 mb-4 position-relative overflow-hidden shadow-lg"
                     style="background: linear-gradient(135deg, #09121d 0%, #0c1825 50%, #050a11 100%); border: 1px solid rgba(0, 242, 255, 0.15); min-height: 180px;">
                  
                  <!-- Watermark / Subtle Glow -->
                  <div class="position-absolute" style="top: -40px; right: -40px; width: 140px; height: 140px; background: rgba(0, 242, 255, 0.06); filter: blur(40px); border-radius: 50%;"></div>
                  
                  <!-- Top Row: Brand & Contactless Icon -->
                  <div class="d-flex justify-content-between align-items-center mb-4">
                    <span class="fw-bold tracking-wider" style="color: #00DBE7; font-size: 0.95rem; font-family: 'Inter', sans-serif;">
                      FINTECH CORP
                    </span>
                    <i class="bi bi-wifi text-cyan-neon fs-4" style="transform: rotate(90deg); display: inline-block;"></i>
                  </div>

                  <!-- Middle Row: Masked Card Number -->
                  <div id="cardPreviewNumber" class="fw-bold font-monospace text-center my-3 tracking-widest text-white-50" style="font-size: 1.35rem; letter-spacing: 0.25em;">
                    •••• •••• •••• ••••
                  </div>

                  <!-- Bottom Row: Titular & Vence -->
                  <div class="d-flex justify-content-between align-items-end mt-4 pt-2">
                    <div>
                      <span class="d-block text-uppercase text-muted fw-bold" style="font-size: 0.55rem; color: #64748B !important; letter-spacing: 0.08em;">TITULAR</span>
                      <span id="cardPreviewTitular" class="fw-bold text-white text-uppercase font-monospace" style="font-size: 0.825rem; letter-spacing: 0.05em;">
                        NOMBRE DEL EMPLEADO
                      </span>
                    </div>
                    <div class="text-end">
                      <span class="d-block text-uppercase text-muted fw-bold" style="font-size: 0.55rem; color: #64748B !important; letter-spacing: 0.08em;">VENCE</span>
                      <span id="cardPreviewVence" class="fw-bold text-white font-monospace" style="font-size: 0.825rem; letter-spacing: 0.05em;">
                        MM/AA
                      </span>
                    </div>
                  </div>
                </div>

                <!-- Form Datos de Tarjeta -->
                <div class="d-flex flex-column gap-3">
                  <span class="fw-bold text-cyan-neon" style="font-size: 0.9rem;">Datos de tarjeta</span>

                  <!-- Alias -->
                  <div>
                    <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #94A3B8 !important;">
                      Alias de la tarjeta
                    </label>
                    <input type="text" id="inputAlias" name="alias" class="form-control form-figma-input py-2" placeholder="Ej. Tarjeta1" autocomplete="off" data-lpignore="true" style="background-color: #1E2024 !important; border: 1px solid rgba(255,255,255,0.08) !important; color: #FFFFFF !important; caret-color: #00DBE7 !important;">
                  </div>

                  <!-- Número de tarjeta -->
                  <div>
                    <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #94A3B8 !important;">
                      Número de tarjeta (16 dígitos)
                    </label>
                    <input type="text" id="inputNumeroTarjeta" name="numeroTarjeta" class="form-control form-figma-input py-2 font-monospace" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" autocomplete="off" data-lpignore="true" style="background-color: #1E2024 !important; border: 1px solid rgba(255,255,255,0.08) !important; color: #FFFFFF !important; caret-color: #00DBE7 !important;">
                  </div>

                  <!-- Row CVV + Vencimiento -->
                  <div class="row g-3">
                    <div class="col-6">
                      <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #94A3B8 !important;">
                        Código de seguridad (CVV)
                      </label>
                      <input type="text" id="inputCvv" name="cvv" class="form-control form-figma-input py-2 font-monospace" placeholder="XXX" maxlength="4" autocomplete="off" data-lpignore="true" style="background-color: #1E2024 !important; border: 1px solid rgba(255,255,255,0.08) !important; color: #FFFFFF !important; caret-color: #00DBE7 !important;">
                    </div>
                    <div class="col-6">
                      <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #94A3B8 !important;">
                        Fecha de vencimiento
                      </label>
                      <input type="text" id="inputVencimiento" name="fechaExpiracion" class="form-control form-figma-input py-2 font-monospace" placeholder="MM/YY" maxlength="5" autocomplete="off" data-lpignore="true" style="background-color: #1E2024 !important; border: 1px solid rgba(255,255,255,0.08) !important; color: #FFFFFF !important; caret-color: #00DBE7 !important;">
                    </div>
                  </div>

                  <!-- Submit Button -->
                  <div class="mt-3">
                    <button type="submit" class="btn btn-figma-neon w-100 py-3 d-flex align-items-center justify-content-center gap-2 font-inter fw-bold shadow-sm" style="font-size: 0.9rem; letter-spacing: 0.04em;">
                      <i class="bi bi-credit-card-2-front-fill fs-5"></i>
                      <span id="btnSubmitTarjetaText">EMITIR NUEVA TARJETA</span>
                    </button>
                  </div>

                </div>

              </div>

            </div>

          </div>
        </div>
      </form>

    </div>
  </div>
</div>

<!-- Scripts de Interactividad del Modal -->
<script>
  // Transferimos la lista de cuentas desde JSP a un array JS
  window.cuentasData = [
    <c:forEach var="cta" items="${listaCuentas}" varStatus="loop">
      {
        idCuenta: "${cta.idCuenta}",
        idEmpleado: "${cta.idEmpleado}",
        nombreCuenta: "${cta.nombreCuenta}",
        numeroCuenta: "${cta.numeroCuenta}",
        activo: ${cta.activo}
      }${!loop.last ? ',' : ''}
    </c:forEach>
  ];

  document.addEventListener("DOMContentLoaded", function() {
    const modalElement = document.getElementById("modalEmitirTarjeta");
    const empleadoSelect = document.getElementById("modalEmpleadoSelect");
    const cuentaSelect = document.getElementById("modalCuentaSelect");
    const btnVirtual = document.getElementById("btnModeVirtual");
    const btnFisica = document.getElementById("btnModeFisica");
    const inputTipoTarjeta = document.getElementById("inputTipoTarjeta");
    
    const inputAlias = document.getElementById("inputAlias");
    const inputNumero = document.getElementById("inputNumeroTarjeta");
    const inputCvv = document.getElementById("inputCvv");
    const inputVencimiento = document.getElementById("inputVencimiento");

    const previewNumber = document.getElementById("cardPreviewNumber");
    const previewTitular = document.getElementById("cardPreviewTitular");
    const previewVence = document.getElementById("cardPreviewVence");

    // Modalidad Toggle (VIRTUAL vs FÍSICA)
    if (btnVirtual && btnFisica) {
      btnVirtual.addEventListener("click", function() {
        inputTipoTarjeta.value = "VIRTUAL";
        btnVirtual.style.borderColor = "#00DBE7";
        btnVirtual.style.color = "#00DBE7";
        btnFisica.style.borderColor = "rgba(255, 255, 255, 0.08)";
        btnFisica.style.color = "#64748B";
      });

      btnFisica.addEventListener("click", function() {
        inputTipoTarjeta.value = "FISICA";
        btnFisica.style.borderColor = "#00DBE7";
        btnFisica.style.color = "#00DBE7";
        btnVirtual.style.borderColor = "rgba(255, 255, 255, 0.08)";
        btnVirtual.style.color = "#64748B";
      });
    }

    // Filtrar Cuentas al seleccionar Empleado
    if (empleadoSelect && cuentaSelect) {
      empleadoSelect.addEventListener("change", function() {
        const empId = this.value;
        const selectedOption = this.options[this.selectedIndex];
        const empNombre = selectedOption ? selectedOption.getAttribute("data-nombre") : "";

        // Actualizar Titular en Live Preview
        if (previewTitular) {
          previewTitular.textContent = empNombre ? empNombre.toUpperCase() : "NOMBRE DEL EMPLEADO";
        }

        // Limpiar opciones previas
        cuentaSelect.innerHTML = '<option value="" selected disabled>Seleccionar cuenta</option>';

        if (!empId) {
          cuentaSelect.disabled = true;
          return;
        }

        // Filtrar cuentas pertenecientes a este empleado
        const empCuentas = (window.cuentasData || []).filter(c => c.idEmpleado == empId && c.activo);

        if (empCuentas.length === 0) {
          const opt = document.createElement("option");
          opt.value = "";
          opt.disabled = true;
          opt.selected = true;
          opt.textContent = "Sin cuentas activas asociadas";
          cuentaSelect.appendChild(opt);
          cuentaSelect.disabled = true;
        } else {
          empCuentas.forEach(c => {
            const opt = document.createElement("option");
            opt.value = c.idCuenta;
            opt.textContent = c.nombreCuenta + " (" + c.numeroCuenta + ")";
            cuentaSelect.appendChild(opt);
          });
          cuentaSelect.disabled = false;
          cuentaSelect.selectedIndex = 1; // Auto seleccionar la primera cuenta disponible
        }
      });
    }

    // Validación antes del envío del formulario
    const formEmitir = document.getElementById("formEmitirTarjeta");
    if (formEmitir) {
      formEmitir.addEventListener("submit", function(e) {
        if (!cuentaSelect.value || cuentaSelect.disabled) {
          e.preventDefault();
          alert("Debe seleccionar un empleado con al menos una cuenta activa a la que pertenecerá la tarjeta.");
          if (empleadoSelect) empleadoSelect.focus();
        }
      });
    }

    // Formatear e Interactivo: Número de tarjeta (16 dígitos -> XXXX XXXX XXXX XXXX)
    if (inputNumero) {
      inputNumero.addEventListener("input", function(e) {
        let val = this.value.replace(/\D/g, ""); // solo números
        if (val.length > 16) val = val.substring(0, 16);

        // Agrupar de 4 en 4
        let formatted = val.match(/.{1,4}/g)?.join(" ") || "";
        this.value = formatted;

        if (previewNumber) {
          if (formatted.length > 0) {
            previewNumber.textContent = formatted;
            previewNumber.classList.remove("text-white-50");
            previewNumber.classList.add("text-white");
          } else {
            previewNumber.textContent = "•••• •••• •••• ••••";
            previewNumber.classList.add("text-white-50");
          }
        }
      });
    }

    // Formatear e Interactivo: Fecha de vencimiento (MM/YY - Máximo 5 caracteres)
    if (inputVencimiento) {
      inputVencimiento.addEventListener("input", function() {
        let val = this.value.replace(/\D/g, "");
        if (val.length > 4) val = val.substring(0, 4);

        let formatted = val;
        if (val.length >= 3) {
          formatted = val.substring(0, 2) + "/" + val.substring(2);
        }
        this.value = formatted;

        if (previewVence) {
          previewVence.textContent = formatted.length > 0 ? formatted : "MM/AA";
        }
      });
    }

    // Funciones globales para alternar entre Crear y Editar Tarjeta
    window.prepararModalEmitirTarjeta = function() {
      const modalLabel = document.getElementById("modalEmitirTarjetaLabel");
      const btnText = document.getElementById("btnSubmitTarjetaText");
      const inputId = document.getElementById("inputIdTarjeta");
      
      if (modalLabel) modalLabel.textContent = "Configura la nueva credencial";
      if (btnText) btnText.textContent = "EMITIR NUEVA TARJETA";
      if (inputId) inputId.value = "";
      
      if (inputAlias) inputAlias.value = "";
      if (inputNumero) { inputNumero.value = ""; inputNumero.dispatchEvent(new Event("input")); }
      if (inputCvv) inputCvv.value = "";
      if (inputVencimiento) { inputVencimiento.value = ""; inputVencimiento.dispatchEvent(new Event("input")); }
      
      if (empleadoSelect) {
        empleadoSelect.disabled = false;
        empleadoSelect.selectedIndex = 0;
        empleadoSelect.dispatchEvent(new Event("change"));
      }
      
      if (btnVirtual) btnVirtual.click();
    };

    window.prepararModalEditarTarjeta = function(idTarjeta, idEmpleado, idCuenta, tipoTarjeta, alias, numeroTarjeta, cvv, fechaExpiracion) {
      const modalLabel = document.getElementById("modalEmitirTarjetaLabel");
      const btnText = document.getElementById("btnSubmitTarjetaText");
      const inputId = document.getElementById("inputIdTarjeta");

      if (modalLabel) modalLabel.textContent = "Editar Credencial Corporativa";
      if (btnText) btnText.textContent = "GUARDAR CAMBIOS";
      if (inputId) inputId.value = idTarjeta || "";

      if (empleadoSelect && idEmpleado) {
        empleadoSelect.value = idEmpleado;
        empleadoSelect.disabled = true; // No permitir editar el empleado asignado

        // Actualizar Titular en Live Preview
        const selectedOption = empleadoSelect.options[empleadoSelect.selectedIndex];
        const empNombre = selectedOption ? selectedOption.getAttribute("data-nombre") : "";
        if (previewTitular) {
          previewTitular.textContent = empNombre ? empNombre.toUpperCase() : "NOMBRE DEL EMPLEADO";
        }

        // Cargar cuentas del empleado
        if (cuentaSelect) {
          cuentaSelect.innerHTML = '<option value="" disabled>Seleccionar cuenta</option>';
          const empCuentas = (window.cuentasData || []).filter(c => c.idEmpleado == idEmpleado);
          empCuentas.forEach(c => {
            const opt = document.createElement("option");
            opt.value = c.idCuenta;
            opt.textContent = c.nombreCuenta + " (" + c.numeroCuenta + ")";
            cuentaSelect.appendChild(opt);
          });
          cuentaSelect.disabled = false;
          if (idCuenta) cuentaSelect.value = idCuenta;
        }
      }

      if (tipoTarjeta && tipoTarjeta.toUpperCase() === "FISICA") {
        if (btnFisica) btnFisica.click();
      } else {
        if (btnVirtual) btnVirtual.click();
      }

      if (inputAlias) inputAlias.value = alias || "";
      if (inputNumero) {
        inputNumero.value = numeroTarjeta || "";
        inputNumero.dispatchEvent(new Event("input"));
      }
      if (inputCvv) inputCvv.value = cvv || "";
      if (inputVencimiento) {
        inputVencimiento.value = fechaExpiracion || "";
        inputVencimiento.dispatchEvent(new Event("input"));
      }
    };
  });
</script>
