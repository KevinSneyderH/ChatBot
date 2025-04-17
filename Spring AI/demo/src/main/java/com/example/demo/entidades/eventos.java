package com.example.demo.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class eventos {

    @Id
    private int IDevento;
    private String NOMevent;
    private String DESCevent;
    private String fecha_evento;
    private String lugar_evento;

    public eventos() {

    }

    public int getIDevento() {
        return IDevento;
    }

    public void setIDevento(int iDevento) {
        IDevento = iDevento;
    }

    public String getNOMevent() {
        return NOMevent;
    }

    public void setNOMevent(String nOMevent) {
        NOMevent = nOMevent;
    }

    public String getDESCevent() {
        return DESCevent;
    }

    public void setDESCevent(String dESCevent) {
        DESCevent = dESCevent;
    }

    public String getFecha_evento() {
        return fecha_evento;
    }

    public void setFecha_evento(String fecha_evento) {
        this.fecha_evento = fecha_evento;
    }

    public String getLugar_evento() {
        return lugar_evento;
    }

    public void setLugar_evento(String lugar_evento) {
        this.lugar_evento = lugar_evento;
    }

    @Override
    public String toString() {
        return "Nombre: " + NOMevent + ", Descripción: " + DESCevent +
                ", Fecha: " + fecha_evento + ", Lugar: " + lugar_evento;
    }

}
