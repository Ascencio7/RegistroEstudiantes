<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inicio | Registro Estudiantil</title>
        <style>
            :root { --navy: #153b6d; --navy-dark: #102d52; --ink: #1d2939; --muted: #667085; }
            * { box-sizing: border-box; }
            body { min-height: 100vh; margin: 0; display: flex; flex-direction: column; font-family: Arial, sans-serif; color: var(--ink); background: #f3f6fa; }
            .navbar { color: white; background: var(--navy); box-shadow: 0 2px 10px rgba(16,45,82,.16); }
            .nav-inner { width: min(100% - 32px, 1120px); min-height: 68px; margin: auto; display: flex; align-items: center; justify-content: space-between; gap: 20px; }
            .brand { color: white; font-weight: 700; font-size: 17px; text-decoration: none; }
            .nav-links { display: flex; gap: 10px; }
            .nav-links a { padding: 10px 14px; color: white; text-decoration: none; border-radius: 7px; }
            .nav-links a:hover { background: rgba(255,255,255,.16); }
            main { width: min(100% - 32px, 900px); margin: 42px auto; flex: 1; }
            .hero { padding: clamp(26px, 5vw, 48px); background: white; border: 1px solid #e7edf4; border-radius: 16px; box-shadow: 0 8px 26px rgba(23,43,77,.07); }
            .eyebrow { margin: 0 0 12px; color: var(--navy); font-size: 12px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; }
            h1 { margin: 0; color: var(--navy-dark); font-size: clamp(26px, 4vw, 36px); line-height: 1.2; }
            .lead { margin: 12px 0 28px; color: var(--muted); line-height: 1.6; }
            .student { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 14px; margin-bottom: 28px; }
            .detail { padding: 16px; background: #f7f9fc; border: 1px solid #e7edf4; border-radius: 9px; }
            .detail span { display: block; margin-bottom: 6px; color: var(--muted); font-size: 12px; text-transform: uppercase; letter-spacing: .04em; }
            .detail strong { color: var(--ink); }
            .button { display: inline-flex; align-items: center; min-height: 44px; padding: 0 18px; color: white; background: var(--navy); border-radius: 7px; font-weight: 700; text-decoration: none; }
            .button:hover { background: var(--navy-dark); }
            footer { padding: 18px 20px; color: #e8eef7; background: var(--navy-dark); text-align: center; font-size: 13px; }
            @media (max-width: 600px) { .nav-inner { padding: 14px 0; align-items: flex-start; flex-direction: column; gap: 8px; } .nav-links { flex-wrap: wrap; } main { margin: 22px auto; } .student { grid-template-columns: 1fr; } }
        </style>
    </head>
    <body>
        <header class="navbar">
            <div class="nav-inner">
                <a class="brand" href="${pageContext.request.contextPath}/index.jsp">Registro Estudiantil</a>
                <nav class="nav-links" aria-label="Navegación principal">
                    <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
                    <a href="${pageContext.request.contextPath}/estudiantes">Estudiantes</a>
                </nav>
            </div>
        </header>
        <main>
            <section class="hero">
                <p class="eyebrow">ITCA-FEPADE | DESARROLLO DE APLICACIONES MULTIPLAFORMA</p>
                <h1>Examen Práctico 2</h1>
                <p class="lead">Sistema de mantenimiento de registros de estudiantes, desarrollado con Java, JSP y arquitectura MVC.</p>
                <div class="student">
                    <div class="detail"><span>Estudiante</span><strong>Jonathan Vladimir Ascencio Ramos</strong></div>
                    <div class="detail"><span>Carnet</span><strong>021523</strong></div>
                    <div class="detail"><span>NetBeans</span><strong>Apache NetBeans 30</strong></div>
                    <div class="detail"><span>Plataforma / servidor</span><strong>Java EE 8 · Apache Tomcat 9</strong></div>
                </div>
                <a class="button" href="${pageContext.request.contextPath}/estudiantes">Gestionar</a>
            </section>
        </main>
        <footer>Jonathan Vladimir Ascencio Ramos | 021523 | Examen práctico 2</footer>
    </body>
</html>
