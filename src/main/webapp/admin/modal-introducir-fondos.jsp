<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Modal Bootstrap 5 para Introducir Fondos a la Cuenta Concentradora -->
<div class="modal fade" id="modalIntroducirFondos" tabindex="-1" aria-labelledby="modalIntroducirFondosLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background: #0d1117; border: 1px solid #30363d; border-radius: 20px; color: #E2E2E8;">
            
            <div class="modal-header border-bottom-0 pb-0 pt-4 px-4">
                <div>
                    <h4 class="modal-title fw-bold text-white m-0 lh-sm" id="modalIntroducirFondosLabel" style="font-size: 1.6rem; color: #E1FDFF !important;">
                        Introducir Fondos
                    </h4>
                    <p class="text-muted m-0 mt-1 small" style="color: #B9CACB !important;">
                        Inyecta liquidez a la Cuenta Concentradora Corporativa para distribuirla en el sistema.
                    </p>
                </div>
                <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">
                <form action="${pageContext.request.contextPath}/admin/introducir-fondos" method="POST">
                    <div class="bg-figma-card p-4 rounded-4 shadow-lg" style="background: #14171C; border: 1px solid #30363d;">
                        <div class="row g-3">

                            <!-- Monto a ingresar -->
                            <div class="col-12">
                                <label class="form-label-figma" style="color: #BAC9CC; font-size: 11px; font-weight: 700; letter-spacing: 0.6px; text-transform: uppercase;">
                                    MONTO A INGRESAR (MXN)
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text border-0" style="background: #1e2024; color: #00E5FF; font-weight: bold; border-top-left-radius: 8px; border-bottom-left-radius: 8px;">$</span>
                                    <input type="number" step="0.01" min="0.01" name="monto" class="form-control form-figma-input ps-2" placeholder="50000.00" required autofocus>
                                </div>
                            </div>

                            <!-- Origen / Concepto -->
                            <div class="col-12">
                                <label class="form-label-figma" style="color: #BAC9CC; font-size: 11px; font-weight: 700; letter-spacing: 0.6px; text-transform: uppercase;">
                                    CONCEPTO / DESCRIPCIÓN
                                </label>
                                <input type="text" name="descripcion" class="form-control form-figma-input" placeholder="Ej. Depósito bancario inicial, Capital de viáticos Q3" value="Inyección de Capital Corporativo" required>
                            </div>

                        </div>

                        <!-- Banner Informativo -->
                        <div class="info-box-figma p-3 my-3 d-flex align-items-start gap-3" style="background: rgba(0, 229, 255, 0.05); border: 1px solid rgba(0, 229, 255, 0.2); border-radius: 12px;">
                            <i class="bi bi-info-circle-fill text-cyan-neon fs-5 flex-shrink-0" style="color: #00E5FF !important;"></i>
                            <span style="color: #cbeafd; font-size: 12px; line-height: 1.5;">
                                Los fondos ingresados se añadirán de manera inmediata al saldo de la <strong>Cuenta Concentradora Corporativa</strong> y quedarán disponibles para ser transferidos a los empleados.
                            </span>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-2">
                            <button type="button" class="btn btn-outline-figma-neon w-100 w-sm-auto text-center" data-bs-dismiss="modal" style="border-radius: 32px; border: 1px solid #00e5ff; color: #00e5ff; font-weight: 700; padding: 8px 20px;">
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-figma-neon w-100 w-sm-auto d-inline-flex align-items-center justify-content-center gap-2" style="background: #00E5FF; color: #002022; font-weight: 700; border-radius: 32px; padding: 8px 24px; border: none;">
                                <i class="bi bi-plus-circle-fill"></i>
                                <span>Confirmar Depósito</span>
                            </button>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
