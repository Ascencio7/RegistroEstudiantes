package com.mycompany.registroestudiantes.model;

public class Nacionalidad {
    private Integer nacionalidadId;
    private String descripcion;

    public Nacionalidad() {
    }

    public Nacionalidad(Integer nacionalidadId, String descripcion) {
        this.nacionalidadId = nacionalidadId;
        this.descripcion = descripcion;
    }

    public Integer getNacionalidadId() {
        return nacionalidadId;
    }

    public void setNacionalidadId(Integer nacionalidadId) {
        this.nacionalidadId = nacionalidadId;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
