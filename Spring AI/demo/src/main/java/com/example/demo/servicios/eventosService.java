package com.example.demo.servicios;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entidades.eventos;

@Repository
public interface eventosService extends JpaRepository<eventos, Integer> {

    @Query("SELECT s FROM eventos s WHERE s.NOMevent = :nombre")
    Optional<eventos> findByNomEvento(@Param("nombre") String nombre);

    @Query("SELECT s FROM eventos s WHERE s.lugar_evento = :lugar")
    Optional<eventos> findByLugarEvento(@Param("lugar") String lugar);

}
