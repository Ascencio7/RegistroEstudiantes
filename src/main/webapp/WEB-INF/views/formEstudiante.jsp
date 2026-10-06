<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${empty estudiante.estudianteId ? 'Nuevo estudiante' : 'Editar estudiante'} | Registro Estudiantil</title>
        <style>
            :root { --navy: #153b6d; --navy-dark: #102d52; --blue: #eaf2fb; --ink: #1d2939; --muted: #667085; --line: #d8e0eb; }
            * { box-sizing: border-box; }
            body { min-height: 100vh; margin: 0; display: flex; flex-direction: column; font-family: Arial, sans-serif; color: var(--ink); background: #f3f6fa; }
            .navbar { background: var(--navy); color: white; box-shadow: 0 2px 10px rgba(16,45,82,.16); }
            .nav-inner { max-width: 1180px; margin: auto; padding: 0 24px; min-height: 68px; display: flex; align-items: center; justify-content: space-between; gap: 20px; }
            .brand { color: white; font-weight: 700; font-size: 17px; text-decoration: none; }
            .nav-links { display: flex; gap: 10px; }
            .nav-links a { padding: 10px 14px; color: white; text-decoration: none; border-radius: 7px; }
            .nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,.16); }
            main { width: min(100% - 32px, 960px); margin: 34px auto; flex: 1; }
            .card { padding: 30px; background: white; border: 1px solid #e7edf4; border-radius: 14px; box-shadow: 0 8px 26px rgba(23,43,77,.07); }
            .eyebrow { margin: 0 0 8px; color: var(--navy); font-size: 12px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; }
            h1 { margin: 0 0 25px; color: var(--navy-dark); font-size: 27px; }
            .feedback-error { display: flex; align-items: flex-start; gap: 12px; margin: 0 0 22px; padding: 14px 16px; color: #8a261e; background: #fff4f2; border: 1px solid #f2c9c4; border-radius: 9px; line-height: 1.5; }
            .feedback-error-icon { width: 23px; height: 23px; flex: 0 0 23px; display: grid; place-items: center; color: #a52a20; background: #ffe2de; border-radius: 50%; font-size: 13px; font-weight: 800; }
            .row { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 18px; margin-bottom: 16px; }
            .field { min-width: 0; display: flex; flex-direction: column; gap: 7px; }
            label { font-size: 14px; font-weight: 700; }
            input, select { width: 100%; min-height: 43px; padding: 10px 12px; color: var(--ink); background: white; border: 1px solid var(--line); border-radius: 7px; font: inherit; }
            input:focus, select:focus { outline: 3px solid rgba(21,59,109,.13); border-color: var(--navy); }
            input::placeholder { color: #98a2b3; }
            .hint { margin: -2px 0 0; color: var(--muted); font-size: 12px; }
            .actions { display: flex; align-items: center; gap: 16px; margin-top: 24px; }
            .button { display: inline-flex; justify-content: center; align-items: center; min-height: 42px; padding: 0 18px; color: white; background: var(--navy); border: 0; border-radius: 7px; font: inherit; font-weight: 700; text-decoration: none; cursor: pointer; }
            .button:hover { background: var(--navy-dark); }
            .back { color: var(--navy); font-weight: 600; text-decoration: none; }
            .back:hover { text-decoration: underline; }
            footer { padding: 18px 20px; color: #e8eef7; background: var(--navy-dark); text-align: center; font-size: 13px; }
            @media (max-width: 640px) { .nav-inner { padding: 14px 18px; align-items: flex-start; flex-direction: column; gap: 8px; } .nav-links { flex-wrap: wrap; } main { margin: 20px auto; } .card { padding: 22px 18px; } .row { grid-template-columns: 1fr; gap: 14px; margin-bottom: 14px; } h1 { font-size: 23px; } }
        </style>
    </head>
    <body>
        <header class="navbar">
            <div class="nav-inner">
                <a class="brand" href="${pageContext.request.contextPath}/index.jsp">Registro Estudiantil</a>
                <nav class="nav-links" aria-label="Navegación principal">
                    <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
                    <a class="active" href="${pageContext.request.contextPath}/estudiantes">Estudiantes</a>
                </nav>
            </div>
        </header>
        <main>
            <section class="card">
                <p class="eyebrow">Gestión de estudiantes</p>
                <h1>${(not empty estudiante.estudianteId or (formSubmitted and not empty param.id)) ? 'Editar estudiante' : 'Registrar estudiante'}</h1>
                <c:if test="${not empty mensajeError}">
                    <div class="feedback-error" role="alert">
                        <span class="feedback-error-icon" aria-hidden="true">!</span>
                        <span><c:out value="${mensajeError}"/></span>
                    </div>
                </c:if>
                <form method="post" action="${pageContext.request.contextPath}/estudiantes">
                    <input type="hidden" name="action" value="guardar">
                    <c:if test="${not empty estudiante.estudianteId or (formSubmitted and not empty param.id)}">
                        <input type="hidden" name="id" value="${formSubmitted ? param.id : estudiante.estudianteId}">
                        <input type="hidden" name="aspiranteId" value="${formSubmitted ? param.aspiranteId : estudiante.aspiranteId}">
                    </c:if>
                    <div class="row">
                        <div class="field">
                            <label for="carnet">Carnet</label>
                            <input id="carnet" type="text" name="carnet" maxlength="10" value="${formSubmitted ? param.carnet : estudiante.carnet}" required>
                        </div>
                        <div class="field">
                            <label for="primerNombre">Primer nombre</label>
                            <input id="primerNombre" type="text" name="primerNombre" value="${formSubmitted ? param.primerNombre : estudiante.primerNombre}" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="segundoNombre">Segundo nombre</label>
                            <input id="segundoNombre" type="text" name="segundoNombre" value="${formSubmitted ? param.segundoNombre : estudiante.segundoNombre}">
                        </div>
                        <div class="field">
                            <label for="primerApellido">Primer apellido</label>
                            <input id="primerApellido" type="text" name="primerApellido" value="${formSubmitted ? param.primerApellido : estudiante.primerApellido}" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="segundoApellido">Segundo apellido</label>
                            <input id="segundoApellido" type="text" name="segundoApellido" value="${formSubmitted ? param.segundoApellido : estudiante.segundoApellido}">
                        </div>
                        <div class="field">
                            <label for="fechaNacimiento">Fecha de nacimiento</label>
                            <input id="fechaNacimiento" type="date" name="fechaNacimiento" value="${formSubmitted ? param.fechaNacimiento : (not empty estudiante.fechaNacimiento ? fn:substring(estudiante.fechaNacimiento, 0, 10) : '')}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="dui">DUI</label>
                            <input id="dui" type="text" name="dui" inputmode="numeric" maxlength="10" pattern="[0-9]{8}-[0-9]" placeholder="00000000-0" title="Escriba 8 dígitos, guion y 1 dígito." value="${formSubmitted ? param.dui : estudiante.dui}">
                            <p class="hint">Formato: 8 dígitos - 1 dígito.</p>
                        </div>
                        <div class="field">
                            <label for="telefonoFijo">Teléfono</label>
                            <input id="telefonoFijo" type="text" name="telefonoFijo" inputmode="numeric" maxlength="9" pattern="[0-9]{4}-[0-9]{4}" placeholder="0000-0000" title="Escriba 4 dígitos, guion y 4 dígitos." value="${formSubmitted ? param.telefonoFijo : estudiante.telefonoFijo}">
                            <p class="hint">Formato: 4 dígitos - 4 dígitos.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="direccion">Dirección</label>
                            <input id="direccion" type="text" name="direccion" maxlength="200" value="${formSubmitted ? param.direccion : estudiante.direccion}">
                        </div>
                        <div class="field">
                            <label for="matriculaBachillerato">Matrícula bachillerato</label>
                            <input id="matriculaBachillerato" type="number" name="matriculaBachillerato" min="0" step="1" inputmode="numeric" value="${formSubmitted ? param.matriculaBachillerato : estudiante.matriculaBachillerato}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="cuotaBachillerato">Cuota bachillerato</label>
                            <input id="cuotaBachillerato" type="number" name="cuotaBachillerato" min="0" step="0.01" placeholder="Ingrese la cuota" value="${formSubmitted ? param.cuotaBachillerato : (not empty estudiante.cuotaBachillerato and estudiante.cuotaBachillerato gt 0 ? estudiante.cuotaBachillerato : '')}">
                        </div>
                        <div class="field">
                            <label for="sexoId">Sexo</label>
                            <select id="sexoId" name="sexoId">
                                <option value="">Seleccione</option>
                                <c:forEach var="sexo" items="${sexos}">
                                    <option value="${sexo.sexoId}" ${formSubmitted ? (param.sexoId == sexo.sexoId ? 'selected="selected"' : '') : (estudiante.sexoId == sexo.sexoId ? 'selected="selected"' : '')}>${sexo.descripcion}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="estadoCivilId">Estado civil</label>
                            <select id="estadoCivilId" name="estadoCivilId">
                                <option value="">Seleccione</option>
                                <c:forEach var="estado" items="${estadosCiviles}">
                                    <option value="${estado.estadoCivilId}" ${formSubmitted ? (param.estadoCivilId == estado.estadoCivilId ? 'selected="selected"' : '') : (estudiante.estadoCivilId == estado.estadoCivilId ? 'selected="selected"' : '')}>${estado.descripcion}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="field">
                            <label for="ocupacionId">Ocupación</label>
                            <select id="ocupacionId" name="ocupacionId">
                                <option value="">Seleccione</option>
                                <c:forEach var="ocupacion" items="${ocupaciones}">
                                    <option value="${ocupacion.ocupacionId}" ${formSubmitted ? (param.ocupacionId == ocupacion.ocupacionId ? 'selected="selected"' : '') : (estudiante.ocupacionId == ocupacion.ocupacionId ? 'selected="selected"' : '')}>${ocupacion.descripcion}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="field">
                            <label for="nacionalidadId">Nacionalidad</label>
                            <select id="nacionalidadId" name="nacionalidadId">
                                <option value="">Seleccione</option>
                                <c:forEach var="nacionalidad" items="${nacionalidades}">
                                    <option value="${nacionalidad.nacionalidadId}" ${formSubmitted ? (param.nacionalidadId == nacionalidad.nacionalidadId ? 'selected="selected"' : '') : (estudiante.nacionalidadId == nacionalidad.nacionalidadId ? 'selected="selected"' : '')}>${nacionalidad.descripcion}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="field"></div>
                    </div>
                    <div class="actions">
                        <button class="button" type="submit">Guardar estudiante</button>
                        <a class="back" href="${pageContext.request.contextPath}/estudiantes">Volver al listado</a>
                    </div>
                </form>
            </section>
        </main>
        <footer>Jonathan Vladimir Ascencio Ramos | 021523 | Examen práctico 2</footer>
        <script>
            function aplicarFormato(input, grupo, maximo) {
                function formatear() {
                    var digitos = input.value.replace(/\D/g, '').slice(0, maximo);
                    if (digitos.length > grupo) {
                        digitos = digitos.slice(0, grupo) + '-' + digitos.slice(grupo);
                    }
                    input.value = digitos;
                }
                input.addEventListener('input', formatear);
                formatear();
            }
            aplicarFormato(document.getElementById('dui'), 8, 9);
            aplicarFormato(document.getElementById('telefonoFijo'), 4, 8);
        </script>
    </body>
</html>
