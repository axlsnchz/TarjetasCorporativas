<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Modal Bootstrap 5 para Registrar Empleado -->
<div class="modal fade" id="modalRegistrarEmpleado" tabindex="-1" aria-labelledby="modalRegistrarEmpleadoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background: #0d1117; border: 1px solid #30363d; border-radius: 16px; color: #E2E2E8;">

            <div class="modal-header border-bottom-0 pb-0 pt-4 px-4">
                <div>
                    <h4 class="modal-title fw-semibold text-white m-0 lh-sm" id="modalRegistrarEmpleadoLabel" style="font-size: 1.8rem; color: #E1FDFF !important;">Registrar Nuevo Empleado</h4>
                    <p class="text-muted m-0 mt-1 small" style="color: #B9CACB !important;">Agrega a un nuevo talento al equipo</p>
                </div>
                <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <div class="modal-body p-4">
                <form action="${pageContext.request.contextPath}/admin/registrar-empleado" method="POST" id="formEmpleadoModal" enctype="multipart/form-data">
                    <input type="hidden" name="idUsuario" id="inputIdUsuario" value="">
                    <div class="row g-4 align-items-stretch">

                        <!-- Columna Izquierda: Subida de Fotografía -->
                        <div class="col-12 col-lg-4">
                            <div class="bg-figma-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center shadow-lg"
                                 style="min-height: 320px; background: #14171C; border: 1px solid #30363d; border-radius: 12px;">
                                <div class="position-relative mb-4">
                                    <div class="avatar-upload-box" onclick="document.getElementById('fotoInputModal').click();">
                                        <div id="uploadPlaceholderModal" class="d-flex flex-column align-items-center">
                                            <i class="bi bi-camera text-secondary fs-3 mb-1"></i>
                                            <span class="text-uppercase fw-bold" style="font-size: 10px; color: #8b949e;">SUBIR FOTO</span>
                                        </div>
                                        <img id="avatarImageModal" src="" alt="Vista previa" class="w-100 h-100 object-fit-cover d-none">
                                    </div>
                                    <div class="avatar-badge-edit role-button" onclick="document.getElementById('fotoInputModal').click();">
                                        <i class="bi bi-pencil-fill text-dark" style="font-size: 12px;"></i>
                                    </div>
                                </div>
                                <!-- Input File Oculto -->
                                <input type="file" id="fotoInputModal" name="foto" class="d-none" accept="image/png, image/jpeg" onchange="previewImageModal(event)">

                                <p class="small mb-0" style="color: #8b949e; line-height: 1.4; font-size: 11px;">
                                    Sube una imagen profesional en<br>formato JPG o PNG. Máximo 2MB.
                                </p>
                            </div>
                        </div>

                        <!-- Columna Derecha: Campos del Formulario y Botones -->
                        <div class="col-12 col-lg-8">
                            <div class="bg-figma-card p-4 d-flex flex-column justify-content-between h-100 shadow-lg"
                                 style="background: #14171C; border: 1px solid #30363d; border-radius: 12px;">
                                <div>
                                    <div class="row g-3">
                                        <!-- Nombre Completo -->
                                        <div class="col-12 col-md-6 mb-2">
                                            <label class="form-label-figma">NOMBRE COMPLETO</label>
                                            <input type="text" id="inputNombreCompleto" name="nombreCompleto" class="form-control form-figma-input" placeholder="Ej. Alejandro Valdivia" required>
                                        </div>

                                        <!-- Correo Electrónico -->
                                        <div class="col-12 col-md-6 mb-2">
                                            <label class="form-label-figma">CORREO ELECTRÓNICO</label>
                                            <input type="email" id="inputCorreo" name="correo" class="form-control form-figma-input" placeholder="alejandro@fintechcorp.com" required>
                                        </div>

                                        <!-- Departamento -->
                                        <div class="col-12 col-md-6 mb-2">
                                            <label class="form-label-figma">DEPARTAMENTO</label>
                                            <input type="text" id="inputDepartamento" name="departamento" class="form-control form-figma-input" placeholder="Ej. Ciberseguridad" required>
                                        </div>

                                        <!-- Cargo / Rol -->
                                        <div class="col-12 col-md-6 mb-2">
                                            <label class="form-label-figma">CARGO / ROL</label>
                                            <input type="text" id="inputCargo" name="cargo" class="form-control form-figma-input" placeholder="Ej. Ejecutivo en seguridad" required>
                                        </div>
                                    </div>

                                    <!-- Banner Informativo -->
                                    <div class="info-box-figma p-3 my-3 d-flex align-items-start gap-3" style="background: #0c1a26; border: 1px solid #1e3a5f; border-radius: 8px;">
                                        <i class="bi bi-info-circle text-cyan-neon fs-5 flex-shrink-0"></i>
                                        <span id="bannerEmpleadoText" style="color: #bfdbfe; font-size: 11px; line-height: 1.5;">
                                            Al registrar un nuevo empleado, el sistema generará automáticamente sus credenciales de acceso temporal y le enviará un correo electrónico institucional.
                                        </span>
                                    </div>
                                </div>

                                <!-- Botones de Acción -->
                                <div class="d-flex flex-column flex-sm-row justify-content-end align-items-center gap-3 pt-3">
                                    <button type="button" class="btn btn-outline-figma-neon w-100 w-sm-auto text-center" data-bs-dismiss="modal">
                                        Cancelar
                                    </button>
                                    <button type="submit" class="btn btn-figma-neon w-100 w-sm-auto d-inline-flex align-items-center justify-content-center gap-2">
                                        <i class="bi bi-check-circle-fill"></i>
                                        <span id="btnSubmitEmpleadoText">Guardar Empleado</span>
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
    function previewImageModal(event) {
        const input = event.target;
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const avatarImg = document.getElementById('avatarImageModal');
                const placeholder = document.getElementById('uploadPlaceholderModal');
                if (avatarImg && placeholder) {
                    avatarImg.src = e.target.result;
                    avatarImg.classList.remove('d-none');
                    placeholder.classList.add('d-none');
                }
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    window.prepararModalRegistrarEmpleado = function() {
        const modalLabel = document.getElementById("modalRegistrarEmpleadoLabel");
        const btnText = document.getElementById("btnSubmitEmpleadoText");
        const inputId = document.getElementById("inputIdUsuario");
        const banner = document.getElementById("bannerEmpleadoText");

        if (modalLabel) modalLabel.textContent = "Registrar Nuevo Empleado";
        if (btnText) btnText.textContent = "Guardar Empleado";
        if (inputId) inputId.value = "";
        if (banner) banner.textContent = "Al registrar un nuevo empleado, el sistema generará automáticamente sus credenciales de acceso temporal y le enviará un correo electrónico institucional.";

        const form = document.getElementById("formEmpleadoModal");
        if (form) form.action = "${pageContext.request.contextPath}/admin/registrar-empleado";

        document.getElementById("inputNombreCompleto").value = "";
        document.getElementById("inputCorreo").value = "";
        document.getElementById("inputDepartamento").value = "";
        document.getElementById("inputCargo").value = "";
    };

    window.prepararModalEditarEmpleado = function(idUsuario, nombre, correo, departamento, cargo) {
        const modalLabel = document.getElementById("modalRegistrarEmpleadoLabel");
        const btnText = document.getElementById("btnSubmitEmpleadoText");
        const inputId = document.getElementById("inputIdUsuario");
        const banner = document.getElementById("bannerEmpleadoText");

        if (modalLabel) modalLabel.textContent = "Editar Empleado";
        if (btnText) btnText.textContent = "Guardar Cambios";
        if (inputId) inputId.value = idUsuario || "";
        if (banner) banner.textContent = "Actualiza la información del empleado en la plataforma corporativa.";

        const form = document.getElementById("formEmpleadoModal");
        if (form) form.action = "${pageContext.request.contextPath}/admin/editar-empleado";

        document.getElementById("inputNombreCompleto").value = nombre || "";
        document.getElementById("inputCorreo").value = correo || "";
        document.getElementById("inputDepartamento").value = departamento || "";
        document.getElementById("inputCargo").value = cargo || "";
    };
</script>