package com.example.demo.servicios;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;
import com.example.demo.entidades.feedback;

@Repository
public interface feedbackService extends JpaRepository<feedback, Integer> {

    boolean existsByCODstudent(Long CODstudent);

}
