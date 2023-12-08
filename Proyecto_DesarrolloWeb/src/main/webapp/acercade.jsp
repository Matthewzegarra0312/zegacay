<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
        <link href="css/estilo_transporte.css" rel="stylesheet" type="text/css">
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>
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
            <center><h2>Acerca de Nosotros</h2></center>
            <p>Somos una agencia de viajes dedicada a brindar experiencias únicas y memorables a nuestros clientes. Desde nuestro inicio, nos hemos comprometido a ofrecer servicios de alta calidad y a crear itinerarios personalizados que se adapten a las necesidades y preferencias individuales de cada viajero.</p>
            <p>En nuestra agencia, creemos en la importancia de explorar el mundo y en el poder transformador de los viajes. Nos esforzamos por ofrecer destinos emocionantes, alojamientos excepcionales y actividades auténticas que permitan a nuestros clientes sumergirse en la cultura y la belleza de cada lugar que visitan.</p>
            <p>Nuestro equipo de expertos en viajes está compuesto por apasionados amantes de las aventuras y conocedores del turismo. Estamos comprometidos en brindar un servicio al cliente excepcional, asesorando y acompañando a nuestros clientes en cada paso del proceso de planificación y durante sus viajes.</p>
            <p>Ya sea que estés buscando unas vacaciones relajantes en la playa, una expedición emocionante por la selva o un recorrido cultural por ciudades históricas, estamos aquí para hacer realidad tus sueños de viaje. ¡Permítenos ser tu compañero de confianza en cada una de tus aventuras!</p>
        </section>
        <br><br>
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