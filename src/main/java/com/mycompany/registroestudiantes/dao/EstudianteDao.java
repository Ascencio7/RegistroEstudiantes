package com.mycompany.registroestudiantes.dao;

import com.mycompany.registroestudiantes.model.Estudiante;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class EstudianteDao {

    public List<Estudiante> listar() throws SQLException {
        List<Estudiante> estudiantes = new ArrayList<>();
        String sql = "SELECT e.*, "
                + "COALESCE(NULLIF(TRIM(s.DESCRIPCION), ''), "
                + "CASE e.SEXOID WHEN 'M' THEN 'Masculino' WHEN 'F' THEN 'Femenino' "
                + "ELSE 'Sin especificar' END) AS SEXODESCRIPCION, "
                + "COALESCE(NULLIF(TRIM(ec.DESCRIPCION), ''), 'Sin especificar') AS ESTADOCIVILDESCRIPCION, "
                + "COALESCE(NULLIF(TRIM(o.DESCRIPCION), ''), 'Sin especificar') AS OCUPACIONDESCRIPCION, "
                + "COALESCE(NULLIF(TRIM(n.DESCRIPCION), ''), 'Sin especificar') AS NACIONALIDADDESCRIPCION "
                + "FROM regestudiante e "
                + "LEFT JOIN sexo s ON e.SEXOID = s.SEXOID "
                + "LEFT JOIN estado_civil ec ON e.ESTADOCIVILID = ec.ESTADOCIVILID "
                + "LEFT JOIN ocupacion o ON e.OCUPACIONID = o.OCUPACIONID "
                + "LEFT JOIN nacionalidad n ON e.NACIONALIDADID = n.NACIONALIDADID "
                + "ORDER BY e.ESTUDIANTEID ASC";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Estudiante estudiante = mapear(rs);
                estudiante.setSexoDescripcion(rs.getString("SEXODESCRIPCION"));
                estudiante.setEstadoCivilDescripcion(rs.getString("ESTADOCIVILDESCRIPCION"));
                estudiante.setOcupacionDescripcion(rs.getString("OCUPACIONDESCRIPCION"));
                estudiante.setNacionalidadDescripcion(rs.getString("NACIONALIDADDESCRIPCION"));
                estudiantes.add(estudiante);
            }
        }
        return estudiantes;
    }

    public Estudiante obtenerPorId(int id) throws SQLException {
        String sql = "SELECT * FROM regestudiante WHERE ESTUDIANTEID = ?";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }
        return null;
    }

    public boolean insertar(Estudiante estudiante) throws SQLException {
        String sql = "INSERT INTO regestudiante (CARNET, PRIMERNOMBRE, SEGUNDONOMBRE, PRIMERAPELLIDO, SEGUNDOAPELLIDO, FECHANACIMIENTO, DIRECCION, TELEFONOFIJO, DUI, MATRICULABACHILLERATO, CUOTABACHILLERATO, SEXOID, ESTADOCIVILID, OCUPACIONID, NACIONALIDADID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionUtil.getConnection()) {
            boolean autoCommitOriginal = con.getAutoCommit();
            con.setAutoCommit(false);
            int generatedId;
            try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                setParametros(ps, estudiante);
                if (ps.executeUpdate() == 0) {
                    con.rollback();
                    return false;
                }

                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (!generatedKeys.next()) {
                        throw new SQLException("No se generó el ID del estudiante.");
                    }
                    generatedId = generatedKeys.getInt(1);
                    try (PreparedStatement update = con.prepareStatement(
                            "UPDATE regestudiante SET ASPIRANTEID = ? WHERE ESTUDIANTEID = ?")) {
                        update.setInt(1, generatedId);
                        update.setInt(2, generatedId);
                        if (update.executeUpdate() == 0) {
                            throw new SQLException("No se pudo asignar el ID automático del aspirante.");
                        }
                    }
                }
                con.commit();
                estudiante.setEstudianteId(generatedId);
                estudiante.setAspiranteId(estudiante.getEstudianteId());
                return true;
            } catch (SQLException ex) {
                con.rollback();
                throw ex;
            } finally {
                con.setAutoCommit(autoCommitOriginal);
            }
        }
    }

    public boolean actualizar(Estudiante estudiante) throws SQLException {
        String sql = "UPDATE regestudiante SET CARNET = ?, PRIMERNOMBRE = ?, SEGUNDONOMBRE = ?, PRIMERAPELLIDO = ?, SEGUNDOAPELLIDO = ?, FECHANACIMIENTO = ?, DIRECCION = ?, TELEFONOFIJO = ?, DUI = ?, MATRICULABACHILLERATO = ?, CUOTABACHILLERATO = ?, SEXOID = ?, ESTADOCIVILID = ?, OCUPACIONID = ?, NACIONALIDADID = ? WHERE ESTUDIANTEID = ?";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            setParametros(ps, estudiante);
            ps.setInt(16, estudiante.getEstudianteId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM regestudiante WHERE ESTUDIANTEID = ?";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private void setParametros(PreparedStatement ps, Estudiante estudiante) throws SQLException {
        ps.setString(1, estudiante.getCarnet());
        ps.setString(2, estudiante.getPrimerNombre());
        ps.setString(3, estudiante.getSegundoNombre());
        ps.setString(4, estudiante.getPrimerApellido());
        ps.setString(5, estudiante.getSegundoApellido());
        if (estudiante.getFechaNacimiento() != null) {
            ps.setTimestamp(6, estudiante.getFechaNacimiento());
        } else {
            ps.setNull(6, java.sql.Types.TIMESTAMP);
        }
        ps.setString(7, estudiante.getDireccion());
        ps.setString(8, estudiante.getTelefonoFijo());
        ps.setString(9, estudiante.getDui());
        if (estudiante.getMatriculaBachillerato() != null) {
            ps.setBigDecimal(10, estudiante.getMatriculaBachillerato());
        } else {
            ps.setNull(10, java.sql.Types.DECIMAL);
        }
        if (estudiante.getCuotaBachillerato() != null) {
            ps.setBigDecimal(11, estudiante.getCuotaBachillerato());
        } else {
            ps.setNull(11, java.sql.Types.DECIMAL);
        }
        ps.setString(12, estudiante.getSexoId());
        setNullableInt(ps, 13, estudiante.getEstadoCivilId());
        setNullableInt(ps, 14, estudiante.getOcupacionId());
        setNullableInt(ps, 15, estudiante.getNacionalidadId());
    }

    private void setNullableInt(PreparedStatement ps, int index, Integer value) throws SQLException {
        if (value != null) {
            ps.setInt(index, value);
        } else {
            ps.setNull(index, java.sql.Types.INTEGER);
        }
    }

    private Estudiante mapear(ResultSet rs) throws SQLException {
        Estudiante estudiante = new Estudiante();
        estudiante.setEstudianteId(rs.getInt("ESTUDIANTEID"));
        Object aspiranteId = rs.getObject("ASPIRANTEID");
        estudiante.setAspiranteId(aspiranteId != null ? rs.getInt("ASPIRANTEID") : estudiante.getEstudianteId());
        estudiante.setCarnet(rs.getString("CARNET"));
        estudiante.setPrimerNombre(rs.getString("PRIMERNOMBRE"));
        estudiante.setSegundoNombre(rs.getString("SEGUNDONOMBRE"));
        estudiante.setPrimerApellido(rs.getString("PRIMERAPELLIDO"));
        estudiante.setSegundoApellido(rs.getString("SEGUNDOAPELLIDO"));
        Timestamp fechaNacimiento = rs.getTimestamp("FECHANACIMIENTO");
        estudiante.setFechaNacimiento(fechaNacimiento);
        estudiante.setDireccion(rs.getString("DIRECCION"));
        estudiante.setTelefonoFijo(rs.getString("TELEFONOFIJO"));
        estudiante.setDui(rs.getString("DUI"));
        estudiante.setFechaCreacion(rs.getTimestamp("FECHACREACION"));
        BigDecimal matricula = rs.getBigDecimal("MATRICULABACHILLERATO");
        estudiante.setMatriculaBachillerato(matricula);
        BigDecimal cuota = rs.getBigDecimal("CUOTABACHILLERATO");
        estudiante.setCuotaBachillerato(cuota);
        estudiante.setSexoId(rs.getString("SEXOID"));
        estudiante.setEstadoCivilId(rs.getObject("ESTADOCIVILID") != null ? rs.getInt("ESTADOCIVILID") : null);
        estudiante.setOcupacionId(rs.getObject("OCUPACIONID") != null ? rs.getInt("OCUPACIONID") : null);
        estudiante.setNacionalidadId(rs.getObject("NACIONALIDADID") != null ? rs.getInt("NACIONALIDADID") : null);
        return estudiante;
    }
}
