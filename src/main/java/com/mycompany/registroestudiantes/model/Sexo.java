package com.mycompany.registroestudiantes.model;

public class Sexo {
    private String sexoId;
    private String descripcion;

    public Sexo() {
    }

    public Sexo(String sexoId, String descripcion) {
        this.sexoId = sexoId;
        this.descripcion = descripcion;
    }

    public String getSexoId() {
        return sexoId;
    }

    public void setSexoId(String sexoId) {
        this.sexoId = sexoId;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
