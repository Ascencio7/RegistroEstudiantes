package com.mycompany.registroestudiantes.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Estudiante {
    private Integer estudianteId;
    private Integer aspiranteId;
    private String carnet;
    private String primerNombre;
    private String segundoNombre;
    private String primerApellido;
    private String segundoApellido;
    private Timestamp fechaNacimiento;
    private String direccion;
    private String telefonoFijo;
    private String dui;
    private Timestamp fechaCreacion;
    private BigDecimal matriculaBachillerato;
    private BigDecimal cuotaBachillerato;
    private String sexoId;
    private Integer estadoCivilId;
    private Integer ocupacionId;
    private Integer nacionalidadId;
    private String sexoDescripcion;
    private String estadoCivilDescripcion;
    private String ocupacionDescripcion;
    private String nacionalidadDescripcion;

    public Estudiante() {
    }

    public Integer getEstudianteId() {
        return estudianteId;
    }

    public void setEstudianteId(Integer estudianteId) {
        this.estudianteId = estudianteId;
    }

    public Integer getAspiranteId() {
        return aspiranteId;
    }

    public void setAspiranteId(Integer aspiranteId) {
        this.aspiranteId = aspiranteId;
    }

    public String getCarnet() {
        return carnet;
    }

    public void setCarnet(String carnet) {
        this.carnet = carnet;
    }

    public String getPrimerNombre() {
        return primerNombre;
    }

    public void setPrimerNombre(String primerNombre) {
        this.primerNombre = primerNombre;
    }

    public String getSegundoNombre() {
        return segundoNombre;
    }

    public void setSegundoNombre(String segundoNombre) {
        this.segundoNombre = segundoNombre;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public Timestamp getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Timestamp fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefonoFijo() {
        return telefonoFijo;
    }

    public void setTelefonoFijo(String telefonoFijo) {
        this.telefonoFijo = telefonoFijo;
    }

    public String getDui() {
        return dui;
    }

    public void setDui(String dui) {
        this.dui = dui;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public BigDecimal getMatriculaBachillerato() {
        return matriculaBachillerato;
    }

    public void setMatriculaBachillerato(BigDecimal matriculaBachillerato) {
        this.matriculaBachillerato = matriculaBachillerato;
    }

    public BigDecimal getCuotaBachillerato() {
        return cuotaBachillerato;
    }

    public void setCuotaBachillerato(BigDecimal cuotaBachillerato) {
        this.cuotaBachillerato = cuotaBachillerato;
    }

    public String getSexoId() {
        return sexoId;
    }

    public void setSexoId(String sexoId) {
        this.sexoId = sexoId;
    }

    public Integer getEstadoCivilId() {
        return estadoCivilId;
    }

    public void setEstadoCivilId(Integer estadoCivilId) {
        this.estadoCivilId = estadoCivilId;
    }

    public Integer getOcupacionId() {
        return ocupacionId;
    }

    public void setOcupacionId(Integer ocupacionId) {
        this.ocupacionId = ocupacionId;
    }

    public Integer getNacionalidadId() {
        return nacionalidadId;
    }

    public void setNacionalidadId(Integer nacionalidadId) {
        this.nacionalidadId = nacionalidadId;
    }

    public String getSexoDescripcion() {
        return sexoDescripcion;
    }

    public void setSexoDescripcion(String sexoDescripcion) {
        this.sexoDescripcion = sexoDescripcion;
    }

    public String getEstadoCivilDescripcion() {
        return estadoCivilDescripcion;
    }

    public void setEstadoCivilDescripcion(String estadoCivilDescripcion) {
        this.estadoCivilDescripcion = estadoCivilDescripcion;
    }

    public String getOcupacionDescripcion() {
        return ocupacionDescripcion;
    }

    public void setOcupacionDescripcion(String ocupacionDescripcion) {
        this.ocupacionDescripcion = ocupacionDescripcion;
    }

    public String getNacionalidadDescripcion() {
        return nacionalidadDescripcion;
    }

    public void setNacionalidadDescripcion(String nacionalidadDescripcion) {
        this.nacionalidadDescripcion = nacionalidadDescripcion;
    }
}
