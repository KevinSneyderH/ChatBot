package com.example.demo.controlador;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.ai.chat.model.ChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.entidades.eventos;
import com.example.demo.entidades.preguntasrespuestas;
import com.example.demo.entidades.sedes;
import com.example.demo.servicios.eventosService;
import com.example.demo.servicios.preguntasrepuestasService;
import com.example.demo.servicios.sedesService;
import com.example.demo.servicios.studentService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/chatbot")

public class ChatController {

    private final ChatModel chatModel;

    public ChatController(ChatModel chatModel) {
        this.chatModel = chatModel;
    }

    @Autowired
    public preguntasrepuestasService pregrespService;

    @Autowired
    public studentService stuService;

    @Autowired
    public eventosService eveService;

    @Autowired
    public sedesService sedesService;

    @PostMapping("/message")
    public String chat(@RequestBody String userMessage, HttpSession session,
            preguntasrespuestas preguntasrespuestas) {

        // Recuperamos el nombre del estudiante desde la sesión
        String studentName = (String) session.getAttribute("studentName");
        String studentCode = (String) session.getAttribute("studentCode");

        // Verificamos si el nombre existe en la sesión
        if (studentName == null) {
            return "No estás logueado. Por favor, inicie sesión.";
        }
        String finalPrompt = "";
        String contexto = "Te recuerdo que eres un chatbot, tu nombre es Unibot y solo responderás a las preguntas que te hagan, ";

        if (userMessage.toLowerCase().contains("hola") || userMessage.toLowerCase().contains("buenas")) {
            finalPrompt = "Saluda al estudiante" + studentName + "en menos de 15 palabras";
        } else if (userMessage.toLowerCase().contains("adios") || userMessage.toLowerCase().contains("chao")) {
            finalPrompt = contexto + "Ya ayudaste al estudiante" + studentName
                    + " con su duda, ahora dile adios para que continúe con su dia en menos de 15 palabras";
        } else {
            finalPrompt = contexto + "Esta es la pregunta del usuario: (" + userMessage
                    + ") responde de manera concisa";
        }

        if (userMessage.toLowerCase().contains("eventos") || userMessage.toLowerCase().contains("evento")) {
            List<eventos> evento = eveService.findAll();

            String eventosFormateados = evento.stream()
                    .map(eventoIndividual -> eventoIndividual.toString())
                    .collect(Collectors.joining("\n"));

            System.out.println(eventosFormateados);

            finalPrompt = contexto + "Esta es la pregunta del usuario: (" + userMessage
                    + ") y estos son los eventos que hay en la Universidad Simon Bolivar sede Cúcuta: ("
                    + eventosFormateados + ") muestra los eventos al estudiante cordialmente";
        }

        if (userMessage.toLowerCase().contains("cuanto es") || userMessage.toLowerCase().contains("calcula")
                || userMessage.toLowerCase().contains("calcular")) {
            preguntasrespuestas.setCategoria("Matematicas");

        } else if (userMessage.toLowerCase().contains("traduce") || userMessage.toLowerCase().contains("en ingles")) {
            preguntasrespuestas.setCategoria("Ingles");
        } else {
            preguntasrespuestas.setCategoria("Pregunta");
        }

        if (userMessage.toLowerCase().contains("donde")) {
            List<sedes> sedes = sedesService.findAll();

            String sedesFormateados = sedes.stream()
                    .map(sedesIndividual -> sedesIndividual.toString())

                    .collect(Collectors.joining("\n"));

            finalPrompt = contexto + "Esta es la pregunta del usuario: (" + userMessage
                    + ") y estas son las sedes con sus respectivos bloques y lugares que hay en la Universidad Simon Bolivar sede Cúcuta: ("
                    + sedesFormateados + ") muestra las sedes al estudiante cordialmente";
        }

        preguntasrespuestas.setPregunta(userMessage);
        preguntasrespuestas.setRespuesta(chatModel.call(finalPrompt).toString());
        preguntasrespuestas.setCODstudent(Long.parseLong(studentCode));
        pregrespService.save(preguntasrespuestas);

        String respuestaBot = chatModel.call(finalPrompt);
        return respuestaBot;
    }

}
