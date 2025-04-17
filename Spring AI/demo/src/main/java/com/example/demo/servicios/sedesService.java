package com.example.demo.servicios;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entidades.sedes;

@Repository
public interface sedesService extends JpaRepository<sedes, Integer> {

}