package com.mycompany.registroestudiantes.dao;

import com.mycompany.registroestudiantes.model.EstadoCivil;
import com.mycompany.registroestudiantes.model.Nacionalidad;
import com.mycompany.registroestudiantes.model.Ocupacion;
import com.mycompany.registroestudiantes.model.Sexo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class CatalogoDao {

    public List<Sexo> listarSexos() throws SQLException {
        List<Sexo> sexos = new ArrayList<>();
        String sql = "SELECT SEXOID, DESCRIPCION FROM sexo ORDER BY DESCRIPCION ASC";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                sexos.add(new Sexo(rs.getString("SEXOID"), rs.getString("DESCRIPCION")));
            }
        }
        return sexos;
    }

    public List<EstadoCivil> listarEstadosCiviles() throws SQLException {
        Map<String, EstadoCivil> unicos = new LinkedHashMap<>();
        String sql = "SELECT MIN(ESTADOCIVILID) AS ESTADOCIVILID, DESCRIPCION "
                + "FROM estado_civil GROUP BY DESCRIPCION ORDER BY DESCRIPCION ASC";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                EstadoCivil opcion = new EstadoCivil(rs.getInt("ESTADOCIVILID"), rs.getString("DESCRIPCION"));
                unicos.putIfAbsent(normalizar(opcion.getDescripcion()), opcion);
            }
        }
        return new ArrayList<>(unicos.values());
    }

    public List<Ocupacion> listarOcupaciones() throws SQLException {
        Map<String, Ocupacion> unicos = new LinkedHashMap<>();
        String sql = "SELECT MIN(OCUPACIONID) AS OCUPACIONID, DESCRIPCION "
                + "FROM ocupacion GROUP BY DESCRIPCION ORDER BY DESCRIPCION ASC";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ocupacion opcion = new Ocupacion(rs.getInt("OCUPACIONID"), rs.getString("DESCRIPCION"));
                unicos.putIfAbsent(normalizar(opcion.getDescripcion()), opcion);
            }
        }
        return new ArrayList<>(unicos.values());
    }

    public List<Nacionalidad> listarNacionalidades() throws SQLException {
        Map<String, Nacionalidad> unicos = new LinkedHashMap<>();
        String sql = "SELECT MIN(NACIONALIDADID) AS NACIONALIDADID, DESCRIPCION "
                + "FROM nacionalidad GROUP BY DESCRIPCION ORDER BY DESCRIPCION ASC";
        try (Connection con = ConnectionUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Nacionalidad opcion = new Nacionalidad(rs.getInt("NACIONALIDADID"), rs.getString("DESCRIPCION"));
                unicos.putIfAbsent(normalizar(opcion.getDescripcion()), opcion);
            }
        }
        return new ArrayList<>(unicos.values());
    }

    private String normalizar(String descripcion) {
        return descripcion == null ? "" : descripcion.trim().toLowerCase(Locale.ROOT);
    }
}
