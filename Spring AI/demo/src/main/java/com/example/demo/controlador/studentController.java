package com.example.demo.controlador;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.demo.servicios.studentService;

import jakarta.servlet.http.HttpSession;

import org.springframework.ui.Model;
import com.example.demo.entidades.student;

@Controller
@RequestMapping("/students")
public class studentController {

    private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    @Autowired
    public studentService stuService;

    @GetMapping()
    public String listStu(Model model) {
        try {
            List<student> listStudents = stuService.findAll();
            model.addAttribute("students", listStudents);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return "admin/stu/index";
    }

    @GetMapping("/login")
    public String login(Model model) {
        try {
            List<Object[]> usuariosYContrasenas = stuService.findUsuariosYContrasenas();
            model.addAttribute("students", usuariosYContrasenas);

        } catch (Exception e) {
            System.out.println("Error en login: " + e);
        }

        return "admin/chat/login";
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam("usuario") String usuario,
            @RequestParam("contraseña") String contraseña,
            Model model, HttpSession session) {

        try {

            Optional<student> studentOpt = stuService.findByUsuario(usuario);

            if (studentOpt.isPresent()) {

                String storedPassword = studentOpt.get().getContraseña();

                if (encoder.matches(contraseña, storedPassword)) {

                    String studentName = studentOpt.get().getNAMEstudent();
                    String studentCode = studentOpt.get().getCODstudent().toString();

                    session.setAttribute("studentName", studentName);
                    session.setAttribute("studentCode", studentCode);
                    return "redirect:/students/chatbot";
                }
            }

            model.addAttribute("error", "Usuario o contraseña incorrectos");

        } catch (Exception e) {
            model.addAttribute("error", "Acceso inválido. Por favor, inténtelo otra vez.");
        }

        return "admin/chat/login";
    }

    @GetMapping("/chatbot")
    public String showChatbotPage(HttpSession session, Model model) {
        String studentName = (String) session.getAttribute("studentName");
        if (studentName == null) {
            return "redirect:/login"; // Redirige al login si no está logueado
        }
        model.addAttribute("studentName", studentName);

        return "admin/chat/index";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("student", new student());
        return "admin/stu/post";
    }

    @PostMapping("/addStudent")
    public String addStudent(@ModelAttribute("student") student student, RedirectAttributes redirectAttributes) {
        try {
            List<String> encryptedPasswords = stuService.findAllPasswords();
            for (String encryptedPassword : encryptedPasswords) {
                if (encoder.matches(student.getContraseña(), encryptedPassword)) {
                    redirectAttributes.addFlashAttribute("error", "La contraseña ya está en uso.");
                    return "redirect:/students/new";
                }
            }

            if (stuService.existsByUsuario(student.getUsuario())) {
                redirectAttributes.addFlashAttribute("error", "El usuario ya está en uso.");
                return "redirect:/students/new";
            }

            if (stuService.existsByCEDstudent(student.getCEDstudent())) {
                redirectAttributes.addFlashAttribute("error", "La cédula ya está registrada.");
                return "redirect:/students/new";
            }

            if (stuService.existsByEMAILstudent(student.getEMAILstudent())) {
                redirectAttributes.addFlashAttribute("error", "El correo ya está registrado.");
                return "redirect:/students/new";
            }

            String encodedPassword = encoder.encode(student.getContraseña());
            student.setContraseña(encodedPassword);
            stuService.save(student);

        } catch (Exception e) {
            System.out.println("Error: " + e);
            redirectAttributes.addFlashAttribute("error", "Error al guardar el estudiante.");
            return "redirect:/students/new";
        }
        return "redirect:/students";
    }

    @PostMapping("/deleteStudent")
    public String deleteStudent(@RequestParam("codstudent") Long codstudent) {
        try {
            stuService.deleteByIdLong(codstudent);

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "redirect:/students";
    }

    @GetMapping("/edit/{codstudent}")
    public String showEditForm(@PathVariable("codstudent") Long codstudent, Model model) {
        student student = stuService.findByIdLong(codstudent).orElse(null);
        model.addAttribute("student", student);
        return "admin/stu/edit";
    }

    @PostMapping("/editStudent")
    public String editStudent(@ModelAttribute("student") student student, RedirectAttributes redirectAttributes) {
        try {
            // Si la contraseña no está vacía, verificamos si ya está en uso
            if (student.getContraseña() != null && !student.getContraseña().isEmpty()) {
                // Obtener todas las contraseñas encriptadas
                List<String> encryptedPasswords = stuService.findAllPasswords();

                // Verificar si la nueva contraseña ya está en uso
                for (String encryptedPassword : encryptedPasswords) {
                    if (encoder.matches(student.getContraseña(), encryptedPassword)) {
                        redirectAttributes.addFlashAttribute("error", "La contraseña ya está en uso.");
                        return "redirect:/students/edit/" + student.getCODstudent();
                    }
                }

                // Encriptar y asignar la nueva contraseña
                student.setContraseña(encoder.encode(student.getContraseña()));
            } else {
                // Si el campo de la contraseña está vacío, mantenemos la contraseña actual del
                // estudiante
                Optional<student> existingStudent = stuService.findByIdLong(student.getCODstudent());
                if (existingStudent.isPresent()) {
                    student.setContraseña(existingStudent.get().getContraseña());
                }
            }

            // Guardar los cambios del estudiante
            stuService.save(student);
            redirectAttributes.addFlashAttribute("successMessage", "Estudiante actualizado con éxito.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error al actualizar el estudiante.");
        }
        return "redirect:/students";
    }

}
