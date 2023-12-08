<%@page import="modelo.*"%>
<%@page import="dao.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ZEGACAY - CHOFERES</title>
        <link href="css/estilo_transporte2.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
        <script src="js/jquery-1.10.2.min.js" type="text/javascript"></script>
        <script src="js/filtrar2.js" type="text/javascript"></script>
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
    <center>
        <%
            Negocio obj = new Negocio();
        %>
        <h1>Filtrar Datos de Choferes</h1>

        <label>Ingrese nombre: &nbsp;&nbsp;&nbsp;</label> <input id="txtnombre">
        <br><br>
        <a href="choferes_agregar.jsp" class="text-blue">Agregar Chofer</a><br><br>
        <div id="tablares"></div>
        <script>
            function Ver(cod, nom) {
                location = "control3?opc=2&cod=" + cod + "&nom=" + nom;
            }
            function Modificar(cod) {
                location = "control3?opc=3&cod=" + cod;
            }
            function Eliminar(cod) {
                location = "control3?opc=5&cod=" + cod;
            }
        </script> 
    </center>
</body>
</html>