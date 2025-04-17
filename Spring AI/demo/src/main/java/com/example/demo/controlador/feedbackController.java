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
import com.example.demo.servicios.feedbackService;
import org.springframework.ui.Model;
import com.example.demo.entidades.feedback;

@Controller
@RequestMapping("/feedback")
public class feedbackController {

    @Autowired
    public feedbackService feedbackService;

    @GetMapping()
    public String listinteracciones(Model model) {
        try {
            List<feedback> listfeedback = feedbackService.findAll();
            model.addAttribute("feedback", listfeedback);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "admin/feedback/index";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("feedback", new feedback());
        return "admin/feedback/post";
    }

    @PostMapping("/addFeedback")
    public String addfeedback(@ModelAttribute("feedback") feedback feedback, RedirectAttributes redirectAttributes) {
        try {
            if (!feedbackService.existsByCODstudent(feedback.getCODstudent())) {
                redirectAttributes.addFlashAttribute("error", "El estudiante no existe.");
                return "redirect:/feedback/new";
            } else {
                feedbackService.save(feedback);
                redirectAttributes.addFlashAttribute("successMessage", "Feedback guardado con éxito.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "redirect:/feedback";
    }

    @PostMapping("/deleteFeedback")
    public String deleteStudent(@RequestParam("idfeedback") int feedback) {
        try {
            feedbackService.deleteById(feedback);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return "redirect:/feedback";
    }

    @GetMapping("/edit/{idfeedback}")
    public String showEditForm(@PathVariable("idfeedback") int idfeedback, Model model) {
        feedback feedback = feedbackService.findById(idfeedback).get();
        model.addAttribute("feedback", feedback);
        return "admin/feedback/edit";
    }

    @PostMapping("/editFeedback")
    public String editStudent(@ModelAttribute("feedback") feedback feedback, RedirectAttributes redirectAttributes) {
        try {
            feedbackService.save(feedback);
            redirectAttributes.addFlashAttribute("successMessage", "Feedback actualizado con éxito.");
        } catch (Exception e) {
            System.out.println("Error: " + e);
            redirectAttributes.addFlashAttribute("errorMessage", "Error al actualizar el feedback.");
        }
        return "redirect:/feedback";
    }

}
