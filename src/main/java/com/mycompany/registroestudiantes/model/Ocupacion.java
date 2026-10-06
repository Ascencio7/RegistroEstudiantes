package com.mycompany.registroestudiantes.model;

public class Ocupacion {
    private Integer ocupacionId;
    private String descripcion;

    public Ocupacion() {
    }

    public Ocupacion(Integer ocupacionId, String descripcion) {
        this.ocupacionId = ocupacionId;
        this.descripcion = descripcion;
    }

    public Integer getOcupacionId() {
        return ocupacionId;
    }

    public void setOcupacionId(Integer ocupacionId) {
        this.ocupacionId = ocupacionId;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
