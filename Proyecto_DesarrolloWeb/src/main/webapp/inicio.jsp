<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*,dao.Negocio" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ZEGACAY S.A.C.</title>
        <link href="css/estilo_transporte.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
        <style>
            .fondo_pagina {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                background-image: url('imagenes/fondo_bus.jpg');
                background-size: contain; 
                background-position: center; 
                opacity: 0.2;
                filter: blur(1px);
            }
        </style>
    </head>
    <body>
        <div class="fondo_pagina"></div>
        <div>
            <br><center><img src="fotos/logo_empresa.png" alt="imagen" height="170"/></center><br><br>
        </div>
        <section class="mission-section">
            <h2>Nuestra Misión</h2>
            <p>Brindar experiencias de viaje inolvidables que inspiren, conecten y enriquezcan la vida de nuestros clientes.</p>

            <h2>Nuestra Visión</h2>
            <p>Convertirnos en el referente mundial en la industria de viajes, ofreciendo un servicio excepcional y destinos únicos.</p>

            <h2>Nuestros Valores</h2>
            <ul>
                <li>Pasión por los viajes</li>
                <li>Excelencia en el servicio al cliente</li>
                <li>Respeto por la diversidad cultural</li>
                <li>Innovación constante</li>
                <li>Compromiso con la sostenibilidad</li>
            </ul>
        </section>

        <footer>
            <p>&copy; 2023 ZEGACAY S.A.C. | <a href="#">Términos y Condiciones</a> | <a href="#">Política de Privacidad</a></p>
            <div class="social-media">
                <a href="#"><img src="fotos/facebook.png"></a>
                <a href="#"><img src="fotos/twitter.png"></a>
                <a href="#"><img src="fotos/instagram.png"></a>
            </div>
        </footer>
    </body>
</html>