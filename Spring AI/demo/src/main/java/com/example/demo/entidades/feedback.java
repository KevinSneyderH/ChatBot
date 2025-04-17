package com.example.demo.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class feedback {

    @Id
    private int IDfeedback;
    private Long CODstudent;
    private String comentario;
    private int efectividad;
    private String fecha_feedback;

    public feedback() {

    }

    public int getIDfeedback() {
        return IDfeedback;
    }

    public void setIDfeedback(int iDfeedback) {
        IDfeedback = iDfeedback;
    }

    public Long getCODstudent() {
        return CODstudent;
    }

    public void setCODstudent(Long cODstudent) {
        CODstudent = cODstudent;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public int getEfectividad() {
        return efectividad;
    }

    public void setEfectividad(int efectividad) {
        this.efectividad = efectividad;
    }

    public String getFecha_feedback() {
        return fecha_feedback;
    }

    public void setFecha_feedback(String fecha_feedback) {
        this.fecha_feedback = fecha_feedback;
    }
}
