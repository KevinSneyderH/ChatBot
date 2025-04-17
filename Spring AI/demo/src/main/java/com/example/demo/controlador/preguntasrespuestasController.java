
package com.example.demo.controlador;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.servicios.preguntasrepuestasService;
import org.springframework.ui.Model;

import com.example.demo.entidades.preguntasrespuestas;

@Controller
@RequestMapping("/PreguntasRespuestas")
public class preguntasrespuestasController {

    @Autowired
    public preguntasrepuestasService pregrespService;

    @GetMapping()
    public String listpregrep(Model model) {
        try {
            List<preguntasrespuestas> listpregresp = pregrespService.findAll();
            model.addAttribute("preguntasrespuestas", listpregresp);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "admin/pregresp/index";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("preguntasrespuestas", new preguntasrespuestas());
        return "admin/pregresp/post";
    }

    @PostMapping("/addpreguntasrespuestas")
    public String addpreguntarespuesta(@ModelAttribute("preguntasrespuestas") preguntasrespuestas preguntasrespuestas) {
        try {
            pregrespService.save(preguntasrespuestas);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "redirect:/PreguntasRespuestas";
    }

    @PostMapping("/deletePreguntasRespuestas")
    public String deleteStudent(@RequestParam("idpregunta") int preguntasrespuestas) {
        try {
            pregrespService.deleteById(preguntasrespuestas);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "redirect:/PreguntasRespuestas";
    }

    @GetMapping("/edit/{idpregunta}")
    public String showEditForm(@PathVariable("idpregunta") int idpregunta, Model model) {
        preguntasrespuestas preguntasrespuestas = pregrespService.findById(idpregunta).get();
        model.addAttribute("preguntasrespuestas", preguntasrespuestas);
        return "admin/pregresp/edit";
    }

    @PostMapping("/editPreguntasRespuestas")
    public String editStudent(@ModelAttribute("preguntasrespuestas") preguntasrespuestas preguntasrespuestas,
            RedirectAttributes redirectAttributes) {
        try {
            pregrespService.save(preguntasrespuestas);
            redirectAttributes.addFlashAttribute("successMessage", "Feedback actualizado con éxito.");
        } catch (Exception e) {
            System.out.println("Error: " + e);
            redirectAttributes.addFlashAttribute("errorMessage", "Error al actualizar el feedback.");
        }
        return "redirect:/PreguntasRespuestas";
    }
}