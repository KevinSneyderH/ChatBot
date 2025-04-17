-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-11-2024 a las 05:44:09
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `iabd`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarSalones` ()   BEGIN
    DECLARE sede CHAR(1);
    DECLARE piso INT;
    DECLARE salon INT;
    
    -- Bucle por sede de 'A' a 'G'
    SET sede = 'A';
    WHILE sede <= 'G' DO
        -- Bucle por cada piso (1 al 3)
        SET piso = 1;
        WHILE piso <= 3 DO
            -- Bucle por cada salón en el piso (00 al 09)
            SET salon = 0;
            WHILE salon <= 9 DO
                INSERT INTO Salones (Piso, Numero_Salon, ID_Sede)
                VALUES (piso, LPAD(salon, 2, '0'), sede);
                SET salon = salon + 1;
            END WHILE;
            SET piso = piso + 1;
        END WHILE;
        SET sede = CHAR(ASCII(sede) + 1); -- Cambia a la siguiente sede
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `IDevento` int(11) NOT NULL,
  `NOMevent` varchar(50) NOT NULL,
  `DESCevent` text DEFAULT NULL,
  `fecha_evento` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `lugar_evento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`IDevento`, `NOMevent`, `DESCevent`, `fecha_evento`, `lugar_evento`) VALUES
(1, 'Charla de Inteligencia Artificial', 'Conferencia sobre IA y sus aplicaciones en el mundo moderno.', '2024-11-10 15:00:00', 'Auditorio Principal'),
(2, 'Taller de Seguridad Informática', 'Taller práctico sobre buenas prácticas de seguridad.', '2024-12-01 19:00:00', 'Sala de Conferencias 2'),
(3, 'Feria de Proyectos de Ingeniería', 'Exposición de proyectos realizados por estudiantes de ingeniería.', '2024-12-15 14:00:00', 'Plaza Central'),
(4, 'Seminario de Desarrollo Web', 'Seminario sobre las últimas tendencias en desarrollo web.', '2024-11-20 16:00:00', 'Laboratorio de Computación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `feedback`
--

CREATE TABLE `feedback` (
  `IDfeedback` int(4) NOT NULL,
  `CODstudent` bigint(12) NOT NULL,
  `comentario` text NOT NULL,
  `efectividad` int(3) NOT NULL,
  `fecha_feedback` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `feedback`
--

INSERT INTO `feedback` (`IDfeedback`, `CODstudent`, `comentario`, `efectividad`, `fecha_feedback`) VALUES
(1, 123123, 'Muy bueno!!!!', 6, '2024-11-13 21:55:01'),
(2, 202213223890, 'La información proporcionada fue útil, pero a veces confusa.', 4, '2024-01-02 05:00:00'),
(3, 202213223891, 'Me gustaría que el chatbot pudiera responder más preguntas.', 3, '2024-01-03 05:00:00'),
(4, 202213223892, 'Muy bueno, pero a veces se demora en responder.', 4, '2024-01-04 05:00:00'),
(5, 202213223893, 'La experiencia fue positiva, pero espero más interactividad.', 5, '2024-01-05 05:00:00'),
(6, 123123, 'asdas', 5, '2024-10-19 02:00:32'),
(8, 123123, 'Muy bueno!!!!???', 5, '2024-10-22 00:47:04'),
(10, 123123, 'Muy bueno!!!! si', 5, '2024-10-22 00:47:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntasrespuestas`
--

CREATE TABLE `preguntasrespuestas` (
  `IDpregunta` int(4) NOT NULL,
  `CODstudent` bigint(12) NOT NULL,
  `pregunta` varchar(200) NOT NULL,
  `respuesta` varchar(10000) NOT NULL,
  `categoria` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntasrespuestas`
--

INSERT INTO `preguntasrespuestas` (`IDpregunta`, `CODstudent`, `pregunta`, `respuesta`, `categoria`) VALUES
(135, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo estás? ¿En qué puedo ayudarte hoy?', 'Pregunta'),
(136, 202213223893, '{\"message\":\"Dime, donde queda el salon 100b?\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nPara encontrar el Salón 100B en la Universidad Simón Bolívar sede Cúcuta, te proporciono la siguiente información:\n\n**Ubicación del Salón 100B:**\n\n* Piso: 1\n* Sede: B\n\n**Dirección aproximada:**\n\nLa sede Cúcuta de la Universidad Simón Bolívar se encuentra en la Avenida del Libertador, frente a la Plaza Libertad, en el centro de la ciudad. El Salón 100B está ubicado en este edificio.\n\nTe recomiendo que te dirijas al edificio B, ascenda al piso 1 y busca el número 100B en la lista de salones disponibles.\n\nSi necesitas más ayuda o tienes alguna otra pregunta, no dudes en preguntar. Estoy aquí para ayudarte.', 'Pregunta'),
(137, 202213223893, '{\"message\":\"Donde esta el salon B\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nSegún mis conocimientos, el Salón B se encuentra ubicado en la Sede Cúcuta de la Universidad Simón Bolívar. Para localizarlo exactamente, te recomiendo consultar con la oficina de estudiantes o visitar su sitio web oficial, pero puedo darte una idea general:\n\nEl Salón B se ubica en el Piso 1 de la Sede Cúcuta y tiene un número de salón designado como 100B. Este es el lugar donde tus clases de Salón B tendrán lugar.\n\nSi necesitas más información o ayuda, no dudes en preguntar. Estoy aquí para ayudarte.', 'Pregunta'),
(138, 202213223893, '{\"message\":\"Donde esta el salon 100b?\"}', 'Hola! Soy Unibot, aquí para ayudarte.\n\nSin embargo, necesito un poco más de información para responder a tu pregunta. ¿Podrías decirme que piso y sede específica de la Universidad Simon Bolivar se refiere en el mensaje \"donde esta el salon 100b?\"?\n\nEn cuanto a los salones disponibles en la Universidad Simon Bolivar sede Cúcuta, según la información proporcionada, hay un salón ubicado en el piso 1, sede B, con el número de sala 100B.', 'Pregunta'),
(139, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, bienvenido a nuestro espacio de aprendizaje. ¿En qué puedo ayudarte hoy?', 'Pregunta'),
(140, 202213223893, '{\"message\":\"dime donde queda el salon 100b\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nPara darte una respuesta precisa, necesito saber qué universidad te refieres con \"Universidad Simon Bolivar sede Cúcuta\". Sin esta información, no puedo proporcionar la ubicación exacta del Salón 100B.\n\nSi me das el nombre de la universidad y el campus donde se encuentra la sede de Cúcuta, estaré encantado de ayudarte a encontrar la ubicación del Salón 100B.', 'Pregunta'),
(141, 202213223893, '{\"message\":\"Donde esta el salon 100b?\"}', '¡Hola! Soy Unibot. Para ayudarte a encontrar el Salón 100B, te puedo decir que se encuentra en la siguiente ubicación:\n\n- Piso: 1\n- Sede: B (Sede Cúcuta de la Universidad Simón Bolívar)\n\nSi necesitas más información o tienes alguna otra pregunta, no dudes en preguntar.', 'Pregunta'),
(142, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo te va? Estoy aquí para ayudarte en lo que necesites.', 'Pregunta'),
(143, 202213223893, '{\"message\":\"Dime donde esta el salon 100b?\"}', 'Aquí te muestro una versión más concisa y organizada de la lista:\n\n**Salones por piso**\n\n* Piso 1:\n	+ Salón 100\n	+ Salón 101\n	+ ...\n	+ Salón 109\n* Piso 2:\n	+ Salón 200\n	+ Salón 201\n	+ ...\n	+ Salón 209\n* Piso 3:\n	+ Salón 300\n	+ Salón 301\n	+ ...\n	+ Salón 309\n\n**Sedes**\n\n* G: 9 salones en cada piso (100 a 108 y 200 a 208)\n* F: 9 salones en cada piso (100 a 108 y 200 a 208, aunque con algunos nombres ligeramente diferentes)\n* G: 9 salones en cada piso (100 a 108 y 200 a 208, aunque con algunos nombres ligeramente diferentes)\n\n**G**: no se muestran los salones 105 y 106', 'Pregunta'),
(144, 202213223893, '{\"message\":\"Donde queda el salon 100A?\"}', '\"El salón que necesita el estudiante se determina según su asignatura y ciclo.\"', 'Pregunta'),
(145, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo estás? ¿En qué necesitas ayuda o consejo hoy?', 'Pregunta'),
(146, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, bienvenido a nuestra comunidad. ¿En qué puedo ayudarte hoy?', 'Pregunta'),
(147, 202213223893, '{\"message\":\"sedes\"}', '¡Hola amigo! Soy Unibot, aquí para ayudarte.\n\nMe alegra saber que estás interesado en conocer más sobre nuestras sedes. A continuación, te presento una lista de nuestras sedes en la Universidad Simón Bolívar:\n\n1. **Sede A**: Dirección: [insertar dirección]\n2. **Sede B**: Dirección: [insertar dirección]\n3. **Sede C**: Dirección: [insertar dirección]\n4. **Sede D**: Dirección: [insertar dirección]\n5. **Sede E**: Dirección: [insertar dirección]\n6. **Sede F**: Dirección: [insertar dirección]\n7. **Sede G**: Dirección: [insertar dirección]\n\nEspero que esta información te sea útil. Si necesitas más detalles o tienes alguna otra pregunta, no dudes en preguntar.\n\n¡Que tengas un buen día!', 'Pregunta'),
(148, 202213223893, '{\"message\":\"Dime donde esta la Sede 1\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nLa Sede 1 de la Universidad Simón Bolívar se encuentra en la dirección: Av. 3 #15-142, Los Caobos, Cúcuta, Norte de Santander. Estoy seguro de que esta información te será útil.', 'Pregunta'),
(149, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo te va? ¿Necesitas ayuda con algo o solo quieres charlar?', 'Pregunta'),
(150, 202213223893, '{\"message\":\"Donde esta la sede A\"}', '¡Hola! Me alegra ayudarte.\n\nPara encontrar la sede que corresponde a \"A\", te puedo decir que no hay una sede con ese nombre en la lista. Sin embargo, tengo otra opción para ti.\n\nSi buscas la sede con el bloque \"A\" o la dirección más cercana al número 3 de Av., Los Caobos, te recomiendo buscar en la Sede 1. Su ubicación es:\n\nNombre: Sede 1\nBloques: Bloque A\nDirección: Av. 3 #15-142, Los Caobos, Cúcuta, Norte de Santander\n\nEspero que esta información te sea útil. ¡Si tienes alguna otra pregunta, no dudes en preguntar!', 'Pregunta'),
(151, 202213223893, '{\"message\":\"Donde esta el bloque A?\"}', 'Lo siento, pero no puedo proporcionar información específica sobre ubicaciones sin más contexto. ¿Puedes proporcionar más detalles o aclarar a qué tipo de bloque te refieres?', 'Pregunta'),
(152, 202213223893, '{\"message\":\"Donde esta el bloque A?\"}', '¡Hola! Me alegra poder ayudarte.\n\nPara encontrar el bloque A, te recomiendo verificar la información proporcionada sobre cada sede de la Universidad Simón Bolívar en Cúcuta. En resumen:\n\n- La Sede 1 cuenta con el bloque A y se encuentra ubicado en Av. 3 #15 - 142, Los Caobos, Cúcuta.\n- Las sedes 2 y 3 no tienen un bloque específico llamado \"A\".\n\nSi necesitas más ayuda o tienes alguna otra pregunta, ¡estoy aquí para ayudarte!', 'Pregunta'),
(153, 202213223901, '{\"message\":\"Hola\"}', 'Hola, soy un modelo de lenguaje, ¿en qué puedo ayudarte hoy?', 'Pregunta'),
(154, 202213223901, '{\"message\":\"Donde esta el bloque G?\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nPara encontrar el bloque G de la Sede 4 de la Universidad Simón Bolívar en Cúcuta, te diré que se encuentra ubicado en:\n\nDirección: a. 121, Cl. 14 #31\nCúcuta, Norte de Santander\n\nEspero que esto te ayude. ¡Si necesitas algo más, no dudes en preguntar!', 'Pregunta'),
(155, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo estás? ¿Necesitas ayuda o tienes alguna pregunta sobre algún tema?', 'Pregunta'),
(156, 202213223893, '{\"message\":\"Dime donde esta el Auditorio José Toloza\"}', 'Lo siento, pero no tengo información actualizada sobre ubicaciones específicas o cambios en rutas.', 'Pregunta'),
(157, 202213223893, '{\"message\":\"Dime donde esta el auditorio José Toloza\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nPara encontrar el auditorio José Toloza, te diré que se encuentra en la Sede 1 de la Universidad Simón Bolívar en Cúcuta. Su ubicación es en el bloque A, justo al lado de las admisiones y del laboratorio de ciencias. La dirección exacta es:\n\nAv. 3 #15-142\nLos Caobos\n\nEspero que esta información te sea útil. ¿Necesitas algo más?', 'Pregunta'),
(158, 202213223893, '{\"message\":\"Donde encuentro el laboratorio de ciencias?\"}', 'Hola, soy Unibot. ¿En qué puedo ayudarte?', 'Pregunta'),
(159, 202213223893, '{\"message\":\"Donde esta el biciparqueo\"}', '¡Hola! Soy Unibot, aquí para ayudarte.\n\nPara encontrar la sede donde se encuentra el Biciparqueo, te recomiendo revisar los lugares disponibles en Sede 3. En esta sede, puedes encontrar el Biciparqueo entre otros lugares como el Consultorio Jurídico y más.', 'Pregunta'),
(160, 202213223901, '{\"message\":\"Hola\"}', 'Hola, soy un asistente virtual aquí para ayudarte en lo que necesites.', 'Pregunta'),
(161, 202213223893, '{\"message\":\"Donde esta el Biciparqueo\"}', 'Hola, estudiante. Me alegra ayudarte a encontrar la información que buscas.\n\nDesafortunadamente, no tengo información sobre el Biciparqueo en ninguna de las sedes de la Universidad Simón Bolívar en Cúcuta. Sin embargo, puedo decirte que hay una sede con un lugar llamado Consultorio Jurídico y otra sede con un lugar llamado Área de acondicionamiento físico o Gimnasio, pero no se menciona el Biciparqueo.\n\nSi deseas saber más sobre la ubicación exacta del Biciparqueo, te recomiendo que consultes directamente con las sedes de la Universidad Simón Bolívar en Cúcuta para obtener esta información.', 'Pregunta'),
(162, 202213223901, '{\"message\":\"Dime donde esta ubicado el Gimnasio?\"}', '¡Hola! Me alegra poder ayudarte.\n\nPara encontrar el gimnasio de la Universidad Simon Bolivar sede Cúcuta, te recomiendo buscar en la Sede 4. En esta sede se encuentra el Área de acondicionamiento físico o Gimnasio.\n\nLa dirección del Gimnasio es:\n\nÁrea de acondicionamiento físico o Gimnasio\n\nDirección: Av. 4 #31\n\nClase 14\n\nCúcuta, Norte de Santander\n\nEspero que esta información te sea útil. ¡Si necesitas algo más, no dudes en preguntar!', 'Pregunta'),
(163, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo te va? ¿Necesitas ayuda con algo o necesitas un consejo?', 'Pregunta'),
(164, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, que bienvenido a nuestro espacio de aprendizaje, ¡estoy aquí para ayudarte!', 'Pregunta'),
(165, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, ¿cómo te va? Estoy aquí para ayudarte con cualquier duda.', 'Pregunta'),
(166, 202213223893, '{\"message\":\"Como estas?\"}', 'Estoy funcionando correctamente, gracias. ¿En qué puedo ayudarte hoy?', 'Pregunta'),
(167, 202213223893, '{\"message\":\"Hola\"}', 'Hola Karoll, bienvenido a nuestro espacio, ¿cómo te va?', 'Pregunta'),
(168, 202213223893, '{\"message\":\"Donde está la biblioteca?\"}', '¡Hola! Me alegra ayudarte a encontrar la biblioteca de la Universidad Simon Bolivar sede Cúcuta.\n\nLa biblioteca se encuentra en la Sede 2, y específicamente, está ubicada en el Edificio cultural. ¿Necesitas ayuda para llegar allí?', 'Pregunta'),
(169, 202213223893, '{\"message\":\"donde esta la sede 2?\"}', '¡Hola! Me alegra ayudarte. La sede 2 de la Universidad Simon Bolivar en Cúcuta se encuentra en Av. 3 #14 #3-39, Cúcuta, Norte de Santander. ¿Necesitas algo más?', 'Pregunta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salones`
--

CREATE TABLE `salones` (
  `ID_Salon` int(11) NOT NULL,
  `Piso` int(11) NOT NULL,
  `Numero_Salon` varchar(5) NOT NULL,
  `ID_Sede` char(1) DEFAULT NULL,
  `Codigo_Salon` varchar(10) GENERATED ALWAYS AS (concat(`Piso`,`Numero_Salon`,`ID_Sede`)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `ID_Sede` char(1) NOT NULL,
  `Nombre_Sede` varchar(50) NOT NULL,
  `Bloques` varchar(30) NOT NULL,
  `Lugares` varchar(1000) NOT NULL,
  `Direccion_Sede` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`ID_Sede`, `Nombre_Sede`, `Bloques`, `Lugares`, `Direccion_Sede`) VALUES
('1', 'Sede 1', 'Bloque A', 'Admisiones, Laboratorio de ciencias, Auditorio José Toloza, Macondolab', 'Av. 3 #15 #142, Los Caobos, Cúcuta, Norte de Santander'),
('2', 'Sede 2', 'Bloque B, Bloque C, Bloque D', 'Biblioteca Anita Bolívar de Consuegra, Edificio cultural', 'Av. 3 #14 #3-39, Cúcuta, Norte de Santander'),
('3', 'Sede 3', 'Bloque E, Bloque F', 'Biciparqueo, Consultorio Juridico', 'Av. 4 #14-28, Cúcuta, Norte de Santander'),
('4', 'Sede 4', 'Bloque G', 'Auditorio Bloque G, Área de acondicionamiento físico o Gimnasio, Monumento rector fundador, Piscina, Tribunal Simulado', 'av4, Cl. 14 #31, Cúcuta, Norte de Santander');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `student`
--

CREATE TABLE `student` (
  `CODstudent` bigint(12) NOT NULL,
  `NAMEstudent` varchar(80) NOT NULL,
  `CEDstudent` bigint(15) NOT NULL,
  `EMAILstudent` varchar(50) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `usuario` varchar(20) NOT NULL,
  `contraseña` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `student`
--

INSERT INTO `student` (`CODstudent`, `NAMEstudent`, `CEDstudent`, `EMAILstudent`, `fecha_registro`, `usuario`, `contraseña`) VALUES
(75986, 'Sebastian xd', 1976957, 'a@gmail.com', '2024-11-27 22:03:52', 'k.js83568', '$2a$10$wbQyMXJCmIDBJSupk67PQea79GHF9xauU6egDukHEBaPLMaVZBm9y'),
(123123, 'JoseS', 1021666753, 'sadada@kjsdad', '2024-11-13 22:33:02', 'ñ_need', ''),
(432145, 'kevia', 197634, 'a@gmail.com', '2024-11-14 01:09:23', 'k.js83', '$2a$10$o33tMzv0yp3hRzbZCEZS5u0SE6yS3T9/i7ONtsi6/Fy.rTwHM4Hl6'),
(202213223881, 'Bryan Hernandez', 1005023144, 'acciol400@gmail.com', '2024-11-14 01:36:27', 'b_hernandez8', '$2a$10$u3ZF8UZRlfD9jzCjThk2R.Il.rsoyh83T/3QoYuF9NbciNEUxt586'),
(202213223889, 'Carlos Pérez', 1234567890, 'carlos.perez@example', '2024-10-15 05:00:00', 'carlosp', 'pass1234'),
(202213223890, 'María Rodríguez', 987654321, 'maria.rodriguez@exam', '2024-10-18 03:25:56', 'mariar', 'password56789'),
(202213223891, 'Juan Gómez', 1029384756, 'juan.gomez@example.c', '2024-10-10 05:00:00', 'juang', 'qwerty9876'),
(202213223892, 'Ana Martínez', 5647382910, 'ana.martinez@example', '2024-08-05 05:00:00', 'anam', 'securepass123'),
(202213223893, 'Karoll Samaras', 1230984567, 'luis.fernandez@examp', '2024-11-28 04:33:56', 'admin', '$2a$10$l8EARwxX4EPFrBv6Bz9WRuMheFEySguSLZ6qBc2XklMkbZ.N5EGti'),
(202213223897, 'Kevin Sneyder Hernández Camacho', 1021666752, 'kevin.sneyder.hernandez@gmail.com', '2024-11-13 21:31:50', 'k_hernandez8', '$2a$10$lSxRAWBmxrssdTswvAfW..7hL42opYbLh5oiNOJNcfi7RMs6/M/6W'),
(202213223899, 'Juan ', 100027384, 'juan@gmail.com', '2024-11-14 02:08:01', 'juan32', ''),
(202213223900, 'Andres Bastos', 1021663757, 'aholas@gmail.com', '2024-11-14 02:16:38', 'andres1234', '$2a$10$TDuKyXs/tvIFk9WxLrMK7uJ2IaZgegKfZN8rSAGoHkDCDBAYMXaz2'),
(202213223901, 'DrTroy', 1021677648, 'drtroytwitch@gmail.com', '2024-11-27 22:04:43', 'tgdrtroyyt', '$2a$10$MpSQVliOuNAidpZGmP5Yuevl1iGaFixsJ90YvgQnBsTZEMg2CcxBW');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`IDevento`);

--
-- Indices de la tabla `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`IDfeedback`),
  ADD KEY `CODstudent` (`CODstudent`);

--
-- Indices de la tabla `preguntasrespuestas`
--
ALTER TABLE `preguntasrespuestas`
  ADD PRIMARY KEY (`IDpregunta`),
  ADD KEY `CODstudent` (`CODstudent`);

--
-- Indices de la tabla `salones`
--
ALTER TABLE `salones`
  ADD PRIMARY KEY (`ID_Salon`),
  ADD KEY `ID_Sede` (`ID_Sede`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`ID_Sede`);

--
-- Indices de la tabla `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`CODstudent`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `IDevento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `feedback`
--
ALTER TABLE `feedback`
  MODIFY `IDfeedback` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `preguntasrespuestas`
--
ALTER TABLE `preguntasrespuestas`
  MODIFY `IDpregunta` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT de la tabla `salones`
--
ALTER TABLE `salones`
  MODIFY `ID_Salon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT de la tabla `student`
--
ALTER TABLE `student`
  MODIFY `CODstudent` bigint(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202213223902;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`CODstudent`) REFERENCES `student` (`CODstudent`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `preguntasrespuestas`
--
ALTER TABLE `preguntasrespuestas`
  ADD CONSTRAINT `preguntasrespuestas_ibfk_1` FOREIGN KEY (`CODstudent`) REFERENCES `student` (`CODstudent`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `salones`
--
ALTER TABLE `salones`
  ADD CONSTRAINT `salones_ibfk_1` FOREIGN KEY (`ID_Sede`) REFERENCES `sedes` (`ID_Sede`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
