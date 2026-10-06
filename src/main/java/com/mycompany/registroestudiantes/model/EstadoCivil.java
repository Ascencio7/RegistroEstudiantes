package com.mycompany.registroestudiantes.model;

public class EstadoCivil {
    private Integer estadoCivilId;
    private String descripcion;

    public EstadoCivil() {
    }

    public EstadoCivil(Integer estadoCivilId, String descripcion) {
        this.estadoCivilId = estadoCivilId;
        this.descripcion = descripcion;
    }

    public Integer getEstadoCivilId() {
        return estadoCivilId;
    }

    public void setEstadoCivilId(Integer estadoCivilId) {
        this.estadoCivilId = estadoCivilId;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
