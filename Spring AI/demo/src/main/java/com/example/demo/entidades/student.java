package com.example.demo.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long CODstudent;
    private String NAMEstudent;
    private Long CEDstudent;
    private String EMAILstudent;
    private String fecha_registro;
    private String contraseña;
    private String usuario;

    public student() {

    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Long getCODstudent() {
        return CODstudent;
    }

    public void setCODstudent(Long cODstudent) {
        CODstudent = cODstudent;
    }

    public String getNAMEstudent() {
        return NAMEstudent;
    }

    public void setNAMEstudent(String nAMEstudent) {
        NAMEstudent = nAMEstudent;
    }

    public Long getCEDstudent() {
        return CEDstudent;
    }

    public void setCEDstudent(Long cEDstudent) {
        CEDstudent = cEDstudent;
    }

    public String getEMAILstudent() {
        return EMAILstudent;
    }

    public void setEMAILstudent(String eMAILstudent) {
        EMAILstudent = eMAILstudent;
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

}
