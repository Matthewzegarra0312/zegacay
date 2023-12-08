<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>FILTROS Y BUSQUEDAS</title>
        <link href="css/estilo_transporte2.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
        <script src="js/jquery-1.10.2.min.js" type="text/javascript"></script>
        <script src="js/filtrar.js" type="text/javascript"></script>
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
        <br>
    <center>
        <h1>FILTRAR DATOS DEL PASAJERO</h1>
        <label>Ingrese nombre: &nbsp;&nbsp;&nbsp;</label> <input id="txtnombre">
        <br><br>
        <div id="tablares"></div>
        <script>
            function pasaSeleccion(nom) {
                location = "control5?opc=6&noma=" + nom;
            }
        </script>    
    </center>
</body>
</html>