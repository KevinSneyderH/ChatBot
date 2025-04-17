package com.example.demo.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class preguntasrespuestas {

    @Id
    private int IDpregunta;
    private Long CODstudent;
    private String pregunta;
    private String respuesta;
    private String categoria;

    public preguntasrespuestas() {

    }

    public int getIDpregunta() {
        return IDpregunta;
    }

    public void setIDpregunta(int iDpregunta) {
        IDpregunta = iDpregunta;
    }

    public String getPregunta() {
        return pregunta;
    }

    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public Long getCODstudent() {
        return CODstudent;
    }

    public void setCODstudent(Long cODpregunta) {
        CODstudent = cODpregunta;
    }
}
