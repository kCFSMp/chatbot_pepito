CREATE DATABASE chatbot;
GO

USE chatbot;
GO

-- Drop the table if it already exists
IF OBJECT_ID('dbo.chatbot', 'U') IS NOT NULL
    DROP TABLE dbo.chatbot;
GO

-- Create the table
CREATE TABLE dbo.chatbot (
    id INT PRIMARY KEY,
    queries NVARCHAR(300) NOT NULL,
    replies NVARCHAR(300) NOT NULL
);
GO

-- Insert data into the table
INSERT INTO dbo.chatbot (id, queries, replies) VALUES
(1, N'Cual es el horario de clases', N'El horario de clases varia segun el grado. Puedes encontrar el horario especifico en la seccion de "Academicos" de la pagina web.'),
(2, N'Donde puedo encontrar los resultados de los examenes', N'Los resultados de los examenes se publican en la plataforma virtual del colegio. Inicia sesion con tus credenciales para acceder a ellos.'),
(3, N'Cual es el correo electronico de contacto', N'Puedes contactarnos a traves de nuestro correo electronico institucional: info@colegioejemplo.edu.pe'),
(4, N'Hay alguna actividad especial esta semana', N'Si, esta semana tendremos una charla sobre orientacion vocacional el viernes en el auditorio. No te lo pierdas!'),
(5, N'Cual es la fecha limite para entregar el proyecto de historia?', N'La fecha limite para entregar el proyecto de historia es el proximo lunes.'),
(6, N'Como puedo inscribirme en el equipo de futbol', N'Para inscribirte en el equipo de futbol, comunicate con el entrenador del equipo durante el recreo o envia un mensaje al departamento de deportes.'),
(7, N'Quien es el LEDER', N'El LEDER es Sebastian Cardenas');
GO
-- select * from chatbot;
-- GO

-- Drop the existing GetReplyForMessage stored procedure if it exists
IF OBJECT_ID('[dbo].[GetReplyForMessage]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetReplyForMessage];
GO

-- Create the GetReplyForMessage stored procedure
CREATE PROCEDURE GetReplyForMessage
    @Message NVARCHAR(300)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT replies 
    FROM chatbot 
    WHERE queries LIKE '%' + @Message + '%';
END;
GO