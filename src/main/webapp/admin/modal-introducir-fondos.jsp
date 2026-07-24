<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Modal Bootstrap 5 para Introducir Fondos a la Cuenta Concentradora -->
<div class="modal fade" id="modalIntroducirFondos" tabindex="-1" aria-labelledby="modalIntroducirFondosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-white border-0 shadow-lg" style="background: #0D0F14; border-radius: 24px; border: 1px solid rgba(255, 255, 255, 0.08);">
            
            <div class="modal-header border-0 px-4 pt-4 pb-2 d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="modal-title fw-bold text-white mb-0" id="modalIntroducirFondosLabel" style="font-size: 1.75rem; letter-spacing: -0.02em;">
                        Introducir Fondos
                    </h3>
                    <p class="text-muted m-0 mt-1 small" style="color: #BAC9CC !important;">
                        Inyecta liquidez a la Cuenta Concentradora Corporativa para distribuirla en el sistema.
                    </p>
                </div>
                <button type="button" class="btn-close btn-close-white bg-secondary bg-opacity-25 rounded-circle p-2" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body px-4 py-3">
                <form action="${pageContext.request.contextPath}/admin/introducir-fondos" method="POST">
                    <div class="p-3 p-md-4 rounded-4" style="background: #14171C; border: 1px solid rgba(255, 255, 255, 0.04);">
                        <div class="row g-3">

                            <!-- Monto a ingresar -->
                            <div class="col-12">
                                <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                    MONTO A INGRESAR (MXN)
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text border-0 text-cyan-neon fw-bold" style="background-color: #1E2024;">$</span>
                                    <input type="number" step="0.01" min="0.01" name="monto" class="form-control form-figma-input py-2 border-0 shadow-none text-white ps-2" style="background-color: #1E2024 !important;" placeholder="50000.00" required autofocus>
                                </div>
                            </div>

                            <!-- Origen / Concepto -->
                            <div class="col-12">
                                <label class="form-label text-uppercase fw-bold text-muted mb-1" style="font-size: 0.65rem; color: #BAC9CC !important; letter-spacing: 0.05em;">
                                    CONCEPTO / DESCRIPCIÓN
                                </label>
                                <input type="text" name="descripcion" class="form-control form-figma-input py-2 border-0 shadow-none text-white" style="background-color: #1E2024 !important;" placeholder="Ej. Depósito bancario inicial, Capital de viáticos Q3" value="Inyección de Capital Corporativo" required>
                            </div>

                        </div>

                        <!-- Banner Informativo -->
                        <div class="p-3 my-3 d-flex align-items-center gap-3 rounded-3" style="background: rgba(0, 229, 255, 0.04); border: 1px solid rgba(0, 229, 255, 0.1);">
                            <i class="bi bi-info-circle text-cyan-neon fs-5 flex-shrink-0"></i>
                            <span style="color: #BAC9CC; font-size: 0.8rem; line-height: 1.5;">
                                Los fondos ingresados se añadirán de manera inmediata al saldo de la <strong>Cuenta Concentradora Corporativa</strong> y quedarán disponibles para ser transferidos a los empleados.
                            </span>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-3">
                            <button type="button" class="btn btn-outline-figma-neon px-4 py-2.5 d-inline-flex align-items-center justify-content-center gap-2 text-center rounded-pill font-inter fw-bold w-100 w-sm-auto text-nowrap" style="min-width: 160px; font-size: 0.875rem;" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle fs-6"></i>
                                <span>Cancelar</span>
                            </button>
                            <button type="submit" class="btn btn-figma-neon px-4 py-2.5 d-inline-flex align-items-center justify-content-center gap-2 text-center rounded-pill font-inter fw-bold shadow-sm w-100 w-sm-auto text-nowrap" style="min-width: 160px; font-size: 0.875rem; letter-spacing: 0.02em;">
                                <i class="bi bi-plus-circle-fill fs-6"></i>
                                <span>Confirmar Depósito</span>
                            </button>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
