package com.example.demo.entidades;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class sedes {

    @Id
    private char ID_Sede;
    private String Nombre_Sede;
    private String Bloques;
    private String Direccion_Sede;
    private String Lugares;

    public sedes() {

    }

    public int getID_Sede() {
        return ID_Sede;
    }

    public void setID_Sede(char iD_Sede) {
        ID_Sede = iD_Sede;
    }

    public String getNombre_Sede() {
        return Nombre_Sede;
    }

    public void setNombre_Sede(String nombre_Sede) {
        Nombre_Sede = nombre_Sede;
    }

    public String getDireccion_Sede() {
        return Direccion_Sede;
    }

    public void setDireccion_Sede(String direccion_Sede) {
        Direccion_Sede = direccion_Sede;
    }

    public String getBloques() {
        return Bloques;
    }

    public void setBloques(String bloques) {
        Bloques = bloques;
    }

    @Override
    public String toString() {
        return "Nombre: " + Nombre_Sede +
                ", Bloques: " + Bloques +
                ", Lugares: " + Lugares +
                ", Direccion: " + Direccion_Sede;
    }

    public String getLugares() {
        return Lugares;
    }

    public void setLugares(String auditorios) {
        Lugares = auditorios;
    }

}
