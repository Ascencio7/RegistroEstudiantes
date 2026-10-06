package com.mycompany.registroestudiantes.controller;

import com.mycompany.registroestudiantes.dao.CatalogoDao;
import com.mycompany.registroestudiantes.dao.EstudianteDao;
import com.mycompany.registroestudiantes.model.Estudiante;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EstudianteServlet", urlPatterns = {"/estudiantes"})
public class EstudianteServlet extends HttpServlet {

    private final EstudianteDao estudianteDao = new EstudianteDao();
    private final CatalogoDao catalogoDao = new CatalogoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("nuevo".equals(action)) {
                cargarCatalogos(request);
                request.setAttribute("estudiante", new Estudiante());
                request.getRequestDispatcher("/WEB-INF/views/formEstudiante.jsp").forward(request, response);
                return;
            }

            if ("editar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Estudiante estudiante = estudianteDao.obtenerPorId(id);
                cargarCatalogos(request);
                request.setAttribute("estudiante", estudiante);
                request.getRequestDispatcher("/WEB-INF/views/formEstudiante.jsp").forward(request, response);
                return;
            }

            Object mensajeExito = request.getSession().getAttribute("mensajeExito");
            if (mensajeExito != null) {
                request.setAttribute("mensajeExito", mensajeExito);
                request.getSession().removeAttribute("mensajeExito");
            }
            request.setAttribute("estudiantes", estudianteDao.listar());
            request.getRequestDispatcher("/WEB-INF/views/listaEstudiantes.jsp").forward(request, response);
        } catch (Exception ex) {
            throw new ServletException("Error al procesar el listado de estudiantes", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("eliminar".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                estudianteDao.eliminar(id);
            } catch (Exception ex) {
                throw new ServletException("Error al eliminar el estudiante", ex);
            }
            response.sendRedirect(request.getContextPath() + "/estudiantes");
            return;
        }

        if ("guardar".equals(action)) {
            try {
                Estudiante estudiante = mapearFormulario(request);
                boolean guardado;
                if (estudiante.getEstudianteId() != null && estudiante.getEstudianteId() > 0) {
                    guardado = estudianteDao.actualizar(estudiante);
                } else {
                    guardado = estudianteDao.insertar(estudiante);
                }
                if (!guardado) {
                    throw new IllegalStateException("No se modificó ningún registro.");
                }
                request.getSession().setAttribute("mensajeExito", "El estudiante se guardó correctamente.");
                response.sendRedirect(request.getContextPath() + "/estudiantes");
                return;
            } catch (IllegalArgumentException | ParseException ex) {
                mostrarErrorFormulario(request, response,
                        "Revisa los datos ingresados: " + ex.getMessage());
                return;
            } catch (Exception ex) {
                log("Error al guardar el estudiante.", ex);
                mostrarErrorFormulario(request, response,
                        "No se pudo guardar el estudiante. Verifica que el carnet y el DUI no estén registrados y que la conexión con la base de datos funcione.");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/estudiantes");
    }

    private void mostrarErrorFormulario(HttpServletRequest request, HttpServletResponse response,
            String mensaje) throws ServletException, IOException {
        request.setAttribute("formSubmitted", true);
        request.setAttribute("mensajeError", mensaje);
        try {
            cargarCatalogos(request);
        } catch (Exception ex) {
            log("No se pudieron cargar los catálogos al volver a mostrar el formulario.", ex);
            request.setAttribute("mensajeError",
                    mensaje + " Tampoco fue posible cargar las listas; revisa la conexión con la base de datos.");
            request.setAttribute("sexos", new ArrayList<>());
            request.setAttribute("estadosCiviles", new ArrayList<>());
            request.setAttribute("ocupaciones", new ArrayList<>());
            request.setAttribute("nacionalidades", new ArrayList<>());
        }
        request.getRequestDispatcher("/WEB-INF/views/formEstudiante.jsp").forward(request, response);
    }

    private void cargarCatalogos(HttpServletRequest request) throws Exception {
        request.setAttribute("sexos", catalogoDao.listarSexos());
        request.setAttribute("estadosCiviles", catalogoDao.listarEstadosCiviles());
        request.setAttribute("ocupaciones", catalogoDao.listarOcupaciones());
        request.setAttribute("nacionalidades", catalogoDao.listarNacionalidades());
    }

    private Estudiante mapearFormulario(HttpServletRequest request) throws ParseException {
        Estudiante estudiante = new Estudiante();

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            estudiante.setEstudianteId(Integer.parseInt(idParam));
        }

        estudiante.setAspiranteId(parseInteger(request.getParameter("aspiranteId")));
        estudiante.setCarnet(request.getParameter("carnet"));
        estudiante.setPrimerNombre(request.getParameter("primerNombre"));
        estudiante.setSegundoNombre(request.getParameter("segundoNombre"));
        estudiante.setPrimerApellido(request.getParameter("primerApellido"));
        estudiante.setSegundoApellido(request.getParameter("segundoApellido"));

        String fechaNacimiento = request.getParameter("fechaNacimiento");
        if (fechaNacimiento != null && !fechaNacimiento.trim().isEmpty()) {
            java.util.Date parsed = new SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimiento);
            estudiante.setFechaNacimiento(new Timestamp(parsed.getTime()));
        }

        estudiante.setDireccion(request.getParameter("direccion"));
        estudiante.setTelefonoFijo(formatearDigitos(request.getParameter("telefonoFijo"), 4, 8));
        estudiante.setDui(formatearDigitos(request.getParameter("dui"), 8, 9));
        estudiante.setMatriculaBachillerato(parseMatricula(request.getParameter("matriculaBachillerato")));
        estudiante.setCuotaBachillerato(parseBigDecimal(request.getParameter("cuotaBachillerato")));
        estudiante.setSexoId(request.getParameter("sexoId"));
        estudiante.setEstadoCivilId(parseInteger(request.getParameter("estadoCivilId")));
        estudiante.setOcupacionId(parseInteger(request.getParameter("ocupacionId")));
        estudiante.setNacionalidadId(parseInteger(request.getParameter("nacionalidadId")));

        return estudiante;
    }

    private Integer parseInteger(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException("La cuota debe ser un valor numérico válido.");
        }
    }

    private BigDecimal parseMatricula(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        if (!value.matches("\\d+")) {
            throw new IllegalArgumentException("La matrícula debe ser un número entero.");
        }
        return new BigDecimal(value);
    }

    private String formatearDigitos(String value, int digitosAntesDelGuion, int maxDigitos) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        String digitos = value.replaceAll("\\D", "");
        if (digitos.length() > maxDigitos) {
            digitos = digitos.substring(0, maxDigitos);
        }
        if (digitos.length() > digitosAntesDelGuion) {
            return digitos.substring(0, digitosAntesDelGuion) + "-" + digitos.substring(digitosAntesDelGuion);
        }
        return digitos;
    }
}
