package com.example.demo.servicios;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.demo.entidades.student;

import jakarta.transaction.Transactional;

@Repository
public interface studentService extends JpaRepository<student, Integer> {

    @Query("SELECT s.usuario, s.contraseña FROM student s")
    List<Object[]> findUsuariosYContrasenas();

    @Query("SELECT s FROM student s WHERE s.usuario = :usuario")
    Optional<student> findByUsuario(String usuario);

    @Query("SELECT s.contraseña FROM student s")
    List<String> findAllPasswords();

    @Query("SELECT s FROM student s WHERE s.CODstudent = :id")
    Optional<student> findByIdLong(Long id);

    boolean existsByUsuario(String usuario);

    boolean existsByEMAILstudent(String EMAILstudent);

    boolean existsByCEDstudent(Long CEDstudent);

    @Modifying
    @Transactional
    @Query("DELETE FROM student s WHERE s.CODstudent = :codstudent")
    void deleteByIdLong(@Param("codstudent") Long codstudent);

}
