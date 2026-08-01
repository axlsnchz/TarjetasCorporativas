<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empleados - FinTech Corp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="app-layout">
    <% request.setAttribute("activePage", "empleados"); %>
    <jsp:include page="../components/sidebar-admin.jsp"/>
    <div class="main-content">
        <jsp:include page="../components/header.jsp"/>
        <div class="content-area">
            <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:1.5rem;">
                <div>
                    <h1 class="page-title" style="margin:0;">Gestión de Empleados</h1>
                    <p style="color:#8892a4;font-size:0.85rem;margin-top:0.25rem;">Administra y monitorea el acceso institucional de tu equipo.</p>
                </div>
                <button class="btn btn-primary" onclick="abrirModalNuevo()" style="display:inline-flex;align-items:center;gap:0.5rem;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                    Registrar Empleado
                </button>
            </div>

            <!-- Stats -->
            <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:1rem;margin-bottom:1.5rem;">
                <div class="card" style="background:#0d1520;border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:1.25rem;">
                    <p style="color:#8892a4;font-size:0.75rem;margin:0;">Total Empleados</p>
                    <p style="color:#fff;font-size:1.5rem;font-weight:700;margin:0.25rem 0 0;">${stats.totalEmpleados}</p>
                </div>
                <div class="card" style="background:#0d1520;border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:1.25rem;">
                    <p style="color:#8892a4;font-size:0.75rem;margin:0;">Activos</p>
                    <p style="color:#00e676;font-size:1.5rem;font-weight:700;margin:0.25rem 0 0;">${stats.activosEmpleados}</p>
                </div>
                <div class="card" style="background:#0d1520;border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:1.25rem;">
                    <p style="color:#8892a4;font-size:0.75rem;margin:0;">Departamentos</p>
                    <p style="color:#fff;font-size:1.5rem;font-weight:700;margin:0.25rem 0 0;">${stats.totalDepts}</p>
                </div>
                <div class="card" style="background:#0d1520;border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:1.25rem;">
                    <p style="color:#8892a4;font-size:0.75rem;margin:0;">Nuevos (Mes)</p>
                    <p style="color:#0ff;font-size:1.5rem;font-weight:700;margin:0.25rem 0 0;">+${stats.nuevosMes}</p>
                </div>
            </div>

            <!-- Search & Filter (server-side) -->
            <form method="GET" action="${pageContext.request.contextPath}/admin/empleados" style="display:flex;align-items:center;gap:1rem;margin-bottom:1rem;">
                <div class="input-wrapper" style="flex:3;position:relative;">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#8892a4" stroke-width="2" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                    <input type="text" name="q" value="${q}" placeholder="Buscar empleados por nombre, correo o departamento..."
                        style="width:100%;padding:1rem 1rem 1rem 3rem;background:#0d1520;border:1px solid rgba(255,255,255,0.1);border-radius:10px;color:#fff;font-size:0.95rem;outline:none;box-sizing:border-box;">
                </div>
                <select name="activo" style="background:#0d1520;border:1px solid rgba(255,255,255,0.1);border-radius:10px;color:#8892a4;padding:1rem 0.75rem;font-size:0.95rem;outline:none;flex:1;box-sizing:border-box;">
                    <option value="" ${empty activoFiltro ? 'selected' : ''}>Todos</option>
                    <option value="1" ${'1' eq activoFiltro ? 'selected' : ''}>Activos</option>
                    <option value="0" ${'0' eq activoFiltro ? 'selected' : ''}>Inactivos</option>
                </select>
                <button type="submit" class="btn btn-primary" style="padding:1rem 1.25rem;white-space:nowrap;">Buscar</button>
            </form>

            <!-- Table -->
            <div class="table-container" style="background:#0d1520;border:1px solid rgba(255,255,255,0.08);border-radius:12px;overflow:hidden;">
                <table class="data-table" style="width:100%;border-collapse:collapse;">
                    <thead>
                        <tr style="border-bottom:1px solid rgba(255,255,255,0.08);">
                            <th style="text-align:left;padding:1rem;color:#8892a4;font-size:0.75rem;font-weight:500;">Empleado</th>
                            <th style="text-align:left;padding:1rem;color:#8892a4;font-size:0.75rem;font-weight:500;">Correo Electrónico</th>
                            <th style="text-align:left;padding:1rem;color:#8892a4;font-size:0.75rem;font-weight:500;">Departamento</th>
                            <th style="text-align:left;padding:1rem;color:#8892a4;font-size:0.75rem;font-weight:500;">Estado</th>
                            <th style="text-align:right;padding:1rem;color:#8892a4;font-size:0.75rem;font-weight:500;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="empTbody">
                        <c:choose>
                            <c:when test="${empty pageResult.items}">
                                <tr><td colspan="5" style="padding:2rem;text-align:center;color:#8892a4;">Sin empleados registrados</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="emp" items="${pageResult.items}">
                                    <tr style="border-bottom:1px solid rgba(255,255,255,0.05);">
                                        <td style="padding:1rem;">
                                            <div style="display:flex;align-items:center;gap:0.75rem;">
                                                <div style="width:36px;height:36px;border-radius:50%;background:#1a2a3a;display:flex;align-items:center;justify-content:center;color:#0ff;font-size:0.8rem;font-weight:600;">${fn:substring(emp.nombre,0,1)}</div>
                                                <div>
                                                    <p style="color:#fff;font-size:0.85rem;margin:0;">${emp.nombre}</p>
                                                    <p style="color:#8892a4;font-size:0.7rem;margin:0;">${emp.cargo}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="padding:1rem;color:#8892a4;font-size:0.85rem;">${emp.email}</td>
                                        <td style="padding:1rem;color:#8892a4;font-size:0.85rem;">${emp.departamento}</td>
                                        <td style="padding:1rem;">
                                            <c:choose>
                                                <c:when test="${emp.activo == 1}">
                                                    <span style="background:rgba(0,230,118,0.15);color:#00e676;padding:0.25rem 0.6rem;border-radius:20px;font-size:0.7rem;">Activo</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:rgba(255,82,82,0.15);color:#ff5252;padding:0.25rem 0.6rem;border-radius:20px;font-size:0.7rem;">Inactivo</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                                        <td style="padding:1rem;text-align:right;">
                                            <button onclick="abrirModalEditar(${emp.id})" title="Editar"
                                                style="background:none;border:none;cursor:pointer;color:#8892a4;margin-right:0.5rem;">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                            </button>
                                            <c:if test="${emp.activo == 1}">
                                                <button onclick="eliminarEmpleado(${emp.id})" title="Dar de baja"
                                                    style="background:none;border:none;cursor:pointer;color:#ff5252;padding:0;">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Paginación -->
            <c:if test="${pageResult.totalPages > 1}">
            <div class="pg-bar-outer">
                <span class="pg-count">${pageResult.fromRecord}–${pageResult.toRecord} de ${pageResult.totalCount} empleados</span>
                <div class="pg-bar">
                    <c:choose>
                        <c:when test="${!pageResult.first}">
                            <a href="?page=${pageResult.prevPage}&amp;q=${q}&amp;activo=${activoFiltro}" class="pg-arrow">&#8592;</a>
                        </c:when>
                        <c:otherwise><span class="pg-arrow pg-arrow--dis">&#8592;</span></c:otherwise>
                    </c:choose>
                    <span class="pg-info">Página ${pageResult.page} de ${pageResult.totalPages}</span>
                    <c:choose>
                        <c:when test="${!pageResult.last}">
                            <a href="?page=${pageResult.nextPage}&amp;q=${q}&amp;activo=${activoFiltro}" class="pg-arrow">&#8594;</a>
                        </c:when>
                        <c:otherwise><span class="pg-arrow pg-arrow--dis">&#8594;</span></c:otherwise>
                    </c:choose>
                </div>
            </div>
            </c:if>

        </div>
    </div>
</div>
<!-- ── Toast ───────────────────────────────────────────────────────────── -->
<div id="toast" style="display:none;position:fixed;bottom:1.5rem;right:1.5rem;background:#1e2d3d;border:1px solid rgba(255,255,255,0.12);border-radius:10px;padding:0.9rem 1.25rem;color:#fff;font-size:0.875rem;z-index:9999;min-width:260px;box-shadow:0 8px 32px rgba(0,0,0,0.4);"></div>

<!-- ── Modal crear / editar empleado ──────────────────────────────────── -->
<div id="modalOverlay" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.7);z-index:1000;align-items:center;justify-content:center;">
    <div style="background:#0d1520;border:1px solid rgba(255,255,255,0.12);border-radius:16px;padding:2rem;width:100%;max-width:520px;box-shadow:0 24px 64px rgba(0,0,0,0.5);max-height:90vh;overflow-y:auto;">
        <h2 id="modalTitle" style="color:#fff;margin:0 0 1.5rem;font-size:1.1rem;">Registrar Empleado</h2>
        <input type="hidden" id="empId">

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:1rem;margin-bottom:1rem;">
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Nombre *</label>
                <input type="text" id="empNombre" placeholder="Nombre"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#fff;font-size:0.88rem;outline:none;box-sizing:border-box;">
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Apellido paterno</label>
                <input type="text" id="empApPat" placeholder="Apellido paterno"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#fff;font-size:0.88rem;outline:none;box-sizing:border-box;">
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Apellido materno</label>
                <input type="text" id="empApMat" placeholder="Apellido materno"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#fff;font-size:0.88rem;outline:none;box-sizing:border-box;">
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Correo electrónico *</label>
                <input type="email" id="empEmail" placeholder="correo@empresa.com"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#fff;font-size:0.88rem;outline:none;box-sizing:border-box;">
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;" id="passLabel">Contraseña *</label>
                <input type="password" id="empPassword" placeholder="Contraseña"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#fff;font-size:0.88rem;outline:none;box-sizing:border-box;">
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Rol</label>
                <select id="empRol"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#8892a4;font-size:0.88rem;outline:none;box-sizing:border-box;">
                    <option value="empleado">Empleado</option>
                    <option value="admin">Administrador</option>
                </select>
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Departamento</label>
                <select id="empDep"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#8892a4;font-size:0.88rem;outline:none;box-sizing:border-box;">
                    <option value="">-- Sin departamento --</option>
                </select>
            </div>
            <div>
                <label style="display:block;color:#8892a4;font-size:0.78rem;margin-bottom:0.4rem;">Cargo</label>
                <select id="empCargo"
                    style="width:100%;padding:0.8rem;background:#060c14;border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:#8892a4;font-size:0.88rem;outline:none;box-sizing:border-box;">
                    <option value="">-- Sin cargo --</option>
                </select>
            </div>
        </div>

        <div style="display:flex;gap:0.75rem;justify-content:flex-end;margin-top:0.5rem;">
            <button type="button" onclick="cerrarModal()" class="btn" style="background:rgba(255,255,255,0.06);color:#8892a4;border:none;">Cancelar</button>
            <button type="button" id="btnGuardar" onclick="guardarEmpleado()" class="btn btn-primary">Guardar</button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script>
const CTX_EMP = '${pageContext.request.contextPath}';

function toast(msg, ok) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.style.borderColor = ok ? 'rgba(0,230,118,0.3)' : 'rgba(255,82,82,0.3)';
    t.style.display = 'block';
    setTimeout(() => t.style.display = 'none', 3500);
}

async function api(method, url, body) {
    const opts = { method, headers: {'Content-Type':'application/json'} };
    if (body) opts.body = JSON.stringify(body);
    const res = await fetch(CTX_EMP + url, opts);
    return res.json();
}

function cerrarModal() {
    document.getElementById('modalOverlay').style.display = 'none';
}

function abrirModalNuevo() {
    document.getElementById('modalTitle').textContent = 'Registrar Empleado';
    document.getElementById('empId').value = '';
    document.getElementById('empNombre').value = '';
    document.getElementById('empApPat').value = '';
    document.getElementById('empApMat').value = '';
    document.getElementById('empEmail').value = '';
    document.getElementById('empPassword').value = '';
    document.getElementById('empPassword').placeholder = 'Contraseña';
    document.getElementById('passLabel').textContent = 'Contraseña *';
    document.getElementById('empRol').value = 'empleado';
    cargarCatalogos(null, null);
    document.getElementById('modalOverlay').style.display = 'flex';
}

async function abrirModalEditar(id) {
    document.getElementById('modalTitle').textContent = 'Editar Empleado';
    document.getElementById('empPassword').placeholder = 'Dejar vacío para no cambiar';
    document.getElementById('passLabel').textContent = 'Nueva contraseña';
    document.getElementById('modalOverlay').style.display = 'flex';
    try {
        const data = await api('GET', '/api/empleados?id=' + id);
        if (!data.id) { toast('Empleado no encontrado', false); cerrarModal(); return; }
        document.getElementById('empId').value       = data.id;
        document.getElementById('empNombre').value   = data.nombre || '';
        document.getElementById('empApPat').value    = data.apellidoPaterno || '';
        document.getElementById('empApMat').value    = data.apellidoMaterno || '';
        document.getElementById('empEmail').value    = data.email || '';
        document.getElementById('empPassword').value = '';
        document.getElementById('empRol').value      = data.rol || 'empleado';
        cargarCatalogos(data.departamentoId, data.cargoId, data.departamentos, data.cargos);
    } catch(e) {
        toast('Error al cargar datos', false); cerrarModal();
    }
}

function cargarCatalogos(depId, cargoId, deps, cargos) {
    const selDep   = document.getElementById('empDep');
    const selCargo = document.getElementById('empCargo');
    if (deps && cargos) {
        selDep.innerHTML = '<option value="">-- Sin departamento --</option>'
            + deps.map(d => `<option value="${d.id}" ${d.id == depId ? 'selected' : ''}>${d.nombre}</option>`).join('');
        selCargo.innerHTML = '<option value="">-- Sin cargo --</option>'
            + cargos.map(c => `<option value="${c.id}" ${c.id == cargoId ? 'selected' : ''}>${c.nombre}</option>`).join('');
    } else {
        selDep.innerHTML   = '<option value="">Cargando...</option>';
        selCargo.innerHTML = '<option value="">Cargando...</option>';
        api('GET', '/api/empleados?id=catalogos').then(data => {
            selDep.innerHTML = '<option value="">-- Sin departamento --</option>'
                + (data.departamentos || []).map(d => `<option value="${d.id}">${d.nombre}</option>`).join('');
            selCargo.innerHTML = '<option value="">-- Sin cargo --</option>'
                + (data.cargos || []).map(c => `<option value="${c.id}">${c.nombre}</option>`).join('');
        }).catch(() => {
            selDep.innerHTML   = '<option value="">Error al cargar</option>';
            selCargo.innerHTML = '<option value="">Error al cargar</option>';
        });
    }
}

async function guardarEmpleado() {
    const id       = document.getElementById('empId').value;
    const nombre   = document.getElementById('empNombre').value.trim();
    const email    = document.getElementById('empEmail').value.trim();
    const password = document.getElementById('empPassword').value;

    if (!nombre || !email) { toast('Nombre y email son requeridos', false); return; }
    if (!id && !password)  { toast('La contraseña es requerida para nuevos empleados', false); return; }

    const payload = {
        nombre,
        apellidoPaterno: document.getElementById('empApPat').value.trim(),
        apellidoMaterno: document.getElementById('empApMat').value.trim(),
        email,
        password,
        rol:            document.getElementById('empRol').value,
        departamentoId: parseInt(document.getElementById('empDep').value) || 0,
        cargoId:        parseInt(document.getElementById('empCargo').value) || 0
    };
    if (id) payload.id = parseInt(id);

    const btn = document.getElementById('btnGuardar');
    btn.disabled = true;
    try {
        const res = await api(id ? 'PUT' : 'POST', '/api/empleados', payload);
        toast(res.msg || (id ? 'Empleado actualizado' : 'Empleado registrado'), res.ok);
        if (res.ok) { cerrarModal(); location.reload(); }
    } catch(e) {
        toast('Error de conexión', false);
    } finally {
        btn.disabled = false;
    }
}

async function eliminarEmpleado(id) {
    if (!confirm('¿Dar de baja a este empleado? Se devolverán los fondos de sus cuentas.')) return;
    try {
        const res = await api('DELETE', '/api/empleados?id=' + id);
        toast(res.msg || 'Operación completada', res.ok);
        if (res.ok) location.reload();
    } catch(e) {
        toast('Error de conexión', false);
    }
}

document.getElementById('modalOverlay').addEventListener('click', function(e) {
    if (e.target === this) cerrarModal();
});
</script>
</body>
</html>
