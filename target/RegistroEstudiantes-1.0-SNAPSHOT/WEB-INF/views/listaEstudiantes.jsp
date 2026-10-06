<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Estudiantes | Registro Estudiantil</title>
        <style>
            :root {
                --navy: #153b6d;
                --navy-dark: #102d52;
                --ink: #172b4d;
                --muted: #66758a;
                --line: #e5ebf3;
                --surface: #ffffff;
                --canvas: #f4f7fb;
                --accent: #e9f1fb;
                --danger: #b42318;
            }
            * { box-sizing: border-box; }
            body { min-height: 100vh; margin: 0; display: flex; flex-direction: column; color: var(--ink); background: var(--canvas); font-family: "Segoe UI", Arial, sans-serif; }
            .navbar { position: sticky; top: 0; z-index: 2; color: white; background: var(--navy-dark); box-shadow: 0 3px 14px rgba(16,45,82,.16); }
            .nav-inner { width: min(100% - 40px, 1240px); min-height: 68px; margin: auto; display: flex; align-items: center; justify-content: space-between; gap: 24px; }
            .brand { display: flex; align-items: center; gap: 11px; color: white; font-size: 16px; font-weight: 750; text-decoration: none; letter-spacing: .01em; }
            .brand-mark { width: 34px; height: 34px; display: grid; place-items: center; border: 1px solid rgba(255,255,255,.25); border-radius: 10px; background: rgba(255,255,255,.12); font-size: 14px; }
            .nav-links { display: flex; gap: 6px; }
            .nav-links a { padding: 10px 14px; color: #e7eef8; text-decoration: none; border-radius: 8px; font-size: 14px; }
            .nav-links a:hover, .nav-links a.active { color: white; background: rgba(255,255,255,.14); }
            main { width: min(100% - 40px, 1160px); margin: 38px auto 48px; flex: 1; }
            .page-heading { display: flex; justify-content: space-between; align-items: flex-end; gap: 24px; margin-bottom: 24px; }
            .eyebrow { margin: 0 0 8px; color: #54739b; font-size: 11px; font-weight: 800; letter-spacing: .13em; text-transform: uppercase; }
            h1 { margin: 0; color: var(--navy-dark); font-size: clamp(27px, 4vw, 34px); letter-spacing: -.035em; }
            .subtitle { margin: 9px 0 0; color: var(--muted); font-size: 14px; line-height: 1.55; }
            .feedback-success { display: flex; align-items: center; gap: 11px; margin: 0 0 19px; padding: 13px 16px; color: #176044; background: #edf9f2; border: 1px solid #c8ecd7; border-radius: 9px; font-size: 14px; font-weight: 650; }
            .feedback-success-icon { width: 23px; height: 23px; flex: 0 0 23px; display: grid; place-items: center; color: white; background: #25865d; border-radius: 50%; font-size: 13px; font-weight: 800; }
            .button { min-height: 44px; display: inline-flex; justify-content: center; align-items: center; gap: 9px; padding: 0 17px; color: white; background: var(--navy); border: 1px solid var(--navy); border-radius: 9px; font: inherit; font-size: 14px; font-weight: 700; text-decoration: none; white-space: nowrap; box-shadow: 0 4px 10px rgba(21,59,109,.14); transition: background .15s ease, transform .15s ease, box-shadow .15s ease; }
            .button:hover { transform: translateY(-1px); background: var(--navy-dark); box-shadow: 0 7px 14px rgba(21,59,109,.2); }
            .button-icon { font-size: 19px; line-height: 1; }
            .list-panel { overflow: hidden; background: var(--surface); border: 1px solid var(--line); border-radius: 15px; box-shadow: 0 12px 32px rgba(25,48,79,.06); }
            .list-toolbar { min-height: 74px; display: flex; justify-content: space-between; align-items: center; gap: 18px; padding: 15px 20px; border-bottom: 1px solid var(--line); }
            .count { display: flex; align-items: center; gap: 10px; color: #42536b; font-size: 13px; font-weight: 650; }
            .count-badge { min-width: 30px; height: 30px; display: inline-grid; place-items: center; padding: 0 8px; color: var(--navy); background: var(--accent); border-radius: 9px; font-size: 12px; font-weight: 800; }
            .search { width: min(100%, 310px); position: relative; }
            .search input { width: 100%; height: 40px; padding: 0 13px 0 38px; color: var(--ink); background: #fbfcfe; border: 1px solid var(--line); border-radius: 8px; font: inherit; font-size: 13px; outline: none; }
            .search input:focus { border-color: #86a6d1; box-shadow: 0 0 0 3px rgba(21,59,109,.1); }
            .search-icon { position: absolute; top: 10px; left: 13px; color: #8492a6; font-size: 15px; }
            .record-list { display: grid; gap: 15px; padding: 18px; }
            .student-card { overflow: hidden; border: 1px solid var(--line); border-radius: 12px; background: white; transition: border-color .15s ease, box-shadow .15s ease; }
            .student-card[hidden] { display: none; }
            .student-card:hover { border-color: #cad7e7; box-shadow: 0 5px 16px rgba(25,48,79,.05); }
            .student-top { display: grid; grid-template-columns: minmax(220px, 1.5fr) repeat(3, minmax(110px, .7fr)) auto; align-items: center; gap: 18px; padding: 17px 19px; }
            .identity { min-width: 0; display: flex; align-items: center; gap: 13px; }
            .avatar { width: 42px; height: 42px; flex: 0 0 42px; display: grid; place-items: center; color: var(--navy); background: #e9f1fb; border-radius: 12px; font-size: 14px; font-weight: 800; }
            .student-name { overflow: hidden; color: #20334f; font-size: 14px; font-weight: 750; text-overflow: ellipsis; white-space: nowrap; }
            .student-id { margin-top: 5px; color: #75849a; font-size: 12px; }
            .summary-field { min-width: 0; }
            .field-label { display: block; margin-bottom: 5px; color: #8491a3; font-size: 10px; font-weight: 800; letter-spacing: .08em; text-transform: uppercase; }
            .field-value { overflow-wrap: anywhere; color: #34445c; font-size: 13px; font-weight: 600; }
            .student-actions { display: flex; align-items: center; justify-content: flex-end; gap: 12px; }
            .text-action { padding: 5px 0; color: var(--navy); background: none; border: 0; font: inherit; font-size: 12px; font-weight: 750; text-decoration: none; cursor: pointer; }
            .text-action:hover { text-decoration: underline; }
            .text-action.danger { color: var(--danger); }
            .details { border-top: 1px solid #edf1f6; background: #fbfcfe; }
            .details summary { display: flex; align-items: center; gap: 8px; padding: 12px 19px; color: #526983; font-size: 12px; font-weight: 700; cursor: pointer; list-style: none; user-select: none; }
            .details summary::-webkit-details-marker { display: none; }
            .details summary::before { content: "+"; width: 19px; height: 19px; display: grid; place-items: center; color: var(--navy); background: #e9f1fb; border-radius: 6px; font-size: 14px; line-height: 1; }
            .details[open] summary::before { content: "−"; }
            .details summary:hover { color: var(--navy); background: #f5f8fc; }
            .detail-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 1px; padding: 0 19px 18px; }
            .detail-item { min-height: 62px; padding: 12px 13px; background: white; border: 1px solid #edf1f6; }
            .detail-item:nth-child(1) { border-radius: 8px 0 0 0; }
            .detail-item:nth-child(4) { border-radius: 0 8px 0 0; }
            .detail-value { display: block; overflow-wrap: anywhere; color: #293c56; font-size: 13px; line-height: 1.4; }
            .empty { padding: 55px 20px; text-align: center; }
            .empty-icon { width: 54px; height: 54px; display: grid; place-items: center; margin: 0 auto 14px; color: var(--navy); background: var(--accent); border-radius: 17px; font-size: 23px; }
            .empty h2 { margin: 0 0 7px; color: var(--navy-dark); font-size: 18px; }
            .empty p { margin: 0; color: var(--muted); font-size: 13px; }
            .no-results { display: none; padding: 28px 20px; color: var(--muted); text-align: center; font-size: 14px; }
            footer { padding: 18px 20px; color: #dce6f3; background: var(--navy-dark); text-align: center; font-size: 12px; letter-spacing: .02em; }
            .confirm-dialog { width: min(440px, calc(100% - 32px)); padding: 0; border: 0; border-radius: 16px; color: var(--ink); background: white; box-shadow: 0 24px 70px rgba(16,24,40,.28); }
            .confirm-dialog::backdrop { background: rgba(16,24,40,.58); backdrop-filter: blur(3px); }
            .dialog-content { padding: 28px; }
            .dialog-icon { width: 48px; height: 48px; display: grid; place-items: center; margin-bottom: 18px; border-radius: 14px; color: var(--danger); background: #fff0ee; font-size: 23px; font-weight: 700; }
            .dialog-content h2 { margin: 0 0 9px; color: #182230; font-size: 21px; }
            .dialog-content p { margin: 0; color: var(--muted); line-height: 1.55; }
            .dialog-student { margin-top: 10px !important; color: #344054 !important; font-weight: 700; }
            .dialog-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 26px; }
            .dialog-button { min-height: 41px; padding: 0 15px; border: 1px solid var(--line); border-radius: 7px; color: #344054; background: white; font: inherit; font-weight: 700; cursor: pointer; }
            .dialog-button:hover { background: #f7f9fc; }
            .dialog-button-danger { border-color: var(--danger); color: white; background: var(--danger); }
            .dialog-button-danger:hover { border-color: #912018; background: #912018; }
            @media (max-width: 900px) { .student-top { grid-template-columns: minmax(220px, 1.4fr) repeat(2, minmax(100px, .7fr)) auto; } .student-top .summary-field:nth-of-type(4) { display: none; } .detail-grid { grid-template-columns: repeat(3, minmax(0, 1fr)); } }
            @media (max-width: 640px) {
                .nav-inner { width: min(100% - 32px, 1240px); min-height: 62px; }
                main { width: min(100% - 24px, 1160px); margin: 25px auto 34px; }
                .page-heading { align-items: flex-start; flex-direction: column; gap: 17px; }
                .page-heading .button { width: 100%; }
                .list-toolbar { align-items: stretch; flex-direction: column; padding: 15px; }
                .search { width: 100%; }
                .record-list { gap: 12px; padding: 12px; }
                .student-top { grid-template-columns: 1fr auto; gap: 14px; padding: 15px; }
                .identity { grid-column: 1 / -1; }
                .student-top .summary-field:nth-of-type(4) { display: block; }
                .student-actions { grid-column: 1 / -1; justify-content: flex-start; padding-top: 4px; }
                .detail-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); padding: 0 12px 13px; }
                .detail-item:nth-child(4) { border-radius: 0; }
            }
            @media (max-width: 380px) { .detail-grid { grid-template-columns: 1fr; } }
        </style>
    </head>
    <body>
        <header class="navbar">
            <div class="nav-inner">
                <a class="brand" href="${pageContext.request.contextPath}/index.jsp"><span class="brand-mark" aria-hidden="true">RE</span> Registro Estudiantil</a>
                <nav class="nav-links" aria-label="Navegación principal">
                    <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
                    <a class="active" href="${pageContext.request.contextPath}/estudiantes">Estudiantes</a>
                </nav>
            </div>
        </header>
        <main>
            <div class="page-heading">
                <div>
                    <p class="eyebrow">Parcial Práctico 2</p>
                    <h1>Estudiantes registrados</h1>
                    <p class="subtitle">Gestión de Estudiantes con Java y MySQL</p>
                </div>
                <a class="button" href="${pageContext.request.contextPath}/estudiantes?action=nuevo"><span class="button-icon" aria-hidden="true">+</span> Nuevo estudiante</a>
            </div>
            <c:if test="${not empty mensajeExito}">
                <div class="feedback-success" role="status">
                    <span class="feedback-success-icon" aria-hidden="true">&#10003;</span>
                    <span><c:out value="${mensajeExito}"/></span>
                </div>
            </c:if>
            <section class="list-panel" aria-label="Listado de estudiantes">
                <div class="list-toolbar">
                    <div class="count"><span class="count-badge">${fn:length(estudiantes)}</span> registros encontrados</div>
                    <label class="search">
                        <span class="search-icon" aria-hidden="true">&#9906;</span>
                        <input id="studentSearch" type="search" placeholder="Buscar por nombre o carnet..." aria-label="Buscar estudiantes">
                    </label>
                </div>
                <c:choose>
                    <c:when test="${empty estudiantes}">
                        <div class="empty">
                            <div class="empty-icon" aria-hidden="true">&#9823;</div>
                            <h2>Aún no hay estudiantes</h2>
                            <p>Registra el primer estudiante para empezar a llenar el listado.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="record-list" id="studentList">
                            <c:forEach var="estudiante" items="${estudiantes}">
                                <article class="student-card">
                                    <div class="student-top">
                                        <div class="identity">
                                            <div class="avatar" aria-hidden="true"><c:out value="${fn:substring(estudiante.primerNombre, 0, 1)}${fn:substring(estudiante.primerApellido, 0, 1)}"/></div>
                                            <div>
                                                <div class="student-name"><c:out value="${estudiante.primerNombre}"/> <c:out value="${estudiante.segundoNombre}"/> <c:out value="${estudiante.primerApellido}"/> <c:out value="${estudiante.segundoApellido}"/></div>
                                                <div class="student-id">Registro #${estudiante.estudianteId}</div>
                                            </div>
                                        </div>
                                        <div class="summary-field">
                                            <span class="field-label">Carnet</span>
                                            <span class="field-value"><c:out value="${estudiante.carnet}"/></span>
                                        </div>
                                        <div class="summary-field">
                                            <span class="field-label">DUI</span>
                                            <span class="field-value"><c:out value="${estudiante.dui}"/></span>
                                        </div>
                                        <div class="summary-field">
                                            <span class="field-label">Teléfono</span>
                                            <span class="field-value"><c:out value="${estudiante.telefonoFijo}"/></span>
                                        </div>
                                        <div class="student-actions">
                                            <a class="text-action" href="${pageContext.request.contextPath}/estudiantes?action=editar&id=${estudiante.estudianteId}">Editar</a>
                                            <button class="text-action danger delete-trigger" type="button"
                                                    data-id="${estudiante.estudianteId}"
                                                    data-name="<c:out value='${estudiante.primerNombre} ${estudiante.primerApellido}'/>">Eliminar</button>
                                        </div>
                                    </div>
                                    <details class="details">
                                        <summary>Ver todos los datos del estudiante</summary>
                                        <div class="detail-grid">
                                            <div class="detail-item"><span class="field-label">Estudiante ID</span><span class="detail-value"><c:out value="${estudiante.estudianteId}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Aspirante ID</span><span class="detail-value"><c:out value="${estudiante.aspiranteId}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Carnet</span><span class="detail-value"><c:out value="${estudiante.carnet}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Primer nombre</span><span class="detail-value"><c:out value="${estudiante.primerNombre}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Segundo nombre</span><span class="detail-value"><c:out value="${estudiante.segundoNombre}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Primer apellido</span><span class="detail-value"><c:out value="${estudiante.primerApellido}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Segundo apellido</span><span class="detail-value"><c:out value="${estudiante.segundoApellido}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Fecha de nacimiento</span><span class="detail-value"><c:if test="${not empty estudiante.fechaNacimiento}"><fmt:formatDate value="${estudiante.fechaNacimiento}" pattern="dd/MM/yyyy"/></c:if></span></div>
                                            <div class="detail-item"><span class="field-label">Dirección</span><span class="detail-value"><c:out value="${estudiante.direccion}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Teléfono fijo</span><span class="detail-value"><c:out value="${estudiante.telefonoFijo}"/></span></div>
                                            <div class="detail-item"><span class="field-label">DUI</span><span class="detail-value"><c:out value="${estudiante.dui}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Fecha de creación</span><span class="detail-value"><c:if test="${not empty estudiante.fechaCreacion}"><fmt:formatDate value="${estudiante.fechaCreacion}" pattern="dd/MM/yyyy HH:mm"/></c:if></span></div>
                                            <div class="detail-item"><span class="field-label">Matrícula bachillerato</span><span class="detail-value"><c:out value="${estudiante.matriculaBachillerato}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Cuota bachillerato</span><span class="detail-value"><c:out value="${estudiante.cuotaBachillerato}"/></span></div>
                                            <div class="detail-item"><span class="field-label">Sexo</span><span class="detail-value"><c:out value="${estudiante.sexoDescripcion}" default="Sin especificar"/></span></div>
                                            <div class="detail-item"><span class="field-label">Estado civil</span><span class="detail-value"><c:out value="${estudiante.estadoCivilDescripcion}" default="Sin especificar"/></span></div>
                                            <div class="detail-item"><span class="field-label">Ocupación</span><span class="detail-value"><c:out value="${estudiante.ocupacionDescripcion}" default="Sin especificar"/></span></div>
                                            <div class="detail-item"><span class="field-label">Nacionalidad</span><span class="detail-value"><c:out value="${estudiante.nacionalidadDescripcion}" default="Sin especificar"/></span></div>
                                        </div>
                                    </details>
                                </article>
                            </c:forEach>
                        </div>
                        <div class="no-results" id="noResults">No se encontraron estudiantes que coincidan con la búsqueda.</div>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>
        <dialog class="confirm-dialog" id="deleteDialog" aria-labelledby="deleteDialogTitle" aria-describedby="deleteDialogDescription">
            <div class="dialog-content">
                <div class="dialog-icon" aria-hidden="true">!</div>
                <h2 id="deleteDialogTitle">¿Eliminar estudiante?</h2>
                <p id="deleteDialogDescription">Esta acción eliminará permanentemente el registro. No se puede deshacer.</p>
                <p class="dialog-student" id="deleteStudentName"></p>
                <div class="dialog-actions">
                    <button class="dialog-button" id="cancelDelete" type="button">Cancelar</button>
                    <form method="post" action="${pageContext.request.contextPath}/estudiantes">
                        <input type="hidden" name="action" value="eliminar">
                        <input type="hidden" name="id" id="deleteStudentId">
                        <button class="dialog-button dialog-button-danger" type="submit">Sí, eliminar</button>
                    </form>
                </div>
            </div>
        </dialog>
        <footer>Jonathan Vladimir Ascencio Ramos <span aria-hidden="true">·</span> 021523 <span aria-hidden="true">·</span> Examen práctico 2</footer>
        <script>
            (function () {
                var dialog = document.getElementById('deleteDialog');
                var name = document.getElementById('deleteStudentName');
                var id = document.getElementById('deleteStudentId');
                var cancel = document.getElementById('cancelDelete');
                var search = document.getElementById('studentSearch');
                var cards = Array.prototype.slice.call(document.querySelectorAll('.student-card'));
                var noResults = document.getElementById('noResults');

                document.querySelectorAll('.delete-trigger').forEach(function (button) {
                    button.addEventListener('click', function () {
                        id.value = button.getAttribute('data-id');
                        name.textContent = button.getAttribute('data-name');
                        dialog.showModal();
                        cancel.focus();
                    });
                });

                cancel.addEventListener('click', function () {
                    dialog.close();
                });

                dialog.addEventListener('click', function (event) {
                    if (event.target === dialog) {
                        dialog.close();
                    }
                });

                if (search) {
                    search.addEventListener('input', function () {
                        var query = search.value.trim().toLocaleLowerCase();
                        var visibleCount = 0;
                        cards.forEach(function (card) {
                            var matches = card.textContent.toLocaleLowerCase().indexOf(query) !== -1;
                            card.hidden = !matches;
                            if (matches) {
                                visibleCount++;
                            }
                        });
                        noResults.style.display = visibleCount === 0 ? 'block' : 'none';
                    });
                }
            }());
        </script>
    </body>
</html>
