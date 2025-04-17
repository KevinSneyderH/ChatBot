package com.example.demo.servicios;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entidades.preguntasrespuestas;

@Repository
public interface preguntasrepuestasService extends JpaRepository<preguntasrespuestas, Integer> {

}
