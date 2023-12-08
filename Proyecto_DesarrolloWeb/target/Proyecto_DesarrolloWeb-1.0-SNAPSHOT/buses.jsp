<%@page import="modelo.*"%>
<%@page import="dao.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ZEGACAY - BUSES</title>
        <link href="css/estilo_transporte2.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
            }

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

            .title {
                text-align: center;
                margin-top: 20px;
                font-size: 28px;
            }

            .bus-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                align-items: center;
                margin-top: 30px;
            }

            .bus-card {
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 50%;
                margin-bottom: 20px;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .bus-info {
                flex: 1;
                padding-right: 20px;
            }

            .bus-info h2 {
                margin-bottom: 10px;
            }

            .bus-image {
                width: 650px;
                height: auto;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                object-fit: contain;
            }
        </style>
    </head>
    <body>
        <div class="fondo_pagina"></div>
        <h1 class="title">BUSES DE LA EMPRESA ZEGACAY</h1>
    <center>
        <%
            Negocio obj = new Negocio();
            for (Bus x : obj.lisBuses()) {
        %>
        <div class="bus-container">
            <div class="bus-card">
                <% if (x.getBusnro() % 2 == 1) {%>
                <div class="bus-info">
                    <h2>Bus <%= x.getBusnro()%></h2>
                    <p>Placa: <%= x.getPlaca()%></p>
                    <p>Capacidad: <%= x.getCapacidad()%></p>
                </div>
                <img src="imagenes/bus0<%= x.getBusnro()%>.jpg" class="bus-image" onerror="this.src='fotos/sin_foto.jpg'">
                <% } else {%>
                <img src="imagenes/bus0<%= x.getBusnro()%>.jpg" class="bus-image" onerror="this.src='fotos/sin_foto.jpg'">
                <div class="bus-info">
                    <h2>Bus <%= x.getBusnro()%></h2>
                    <p>Placa: <%= x.getPlaca()%></p>
                    <p>Capacidad: <%= x.getCapacidad()%></p>
                </div>
                <% } %>
            </div>
        </div>
        <% }%>
    </center>
</body>
</html>