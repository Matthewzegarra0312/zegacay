<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*, java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ZEGACAY - CHOFERES X VIAJE</title>
        <link href="css/estilo_transporte2.css" rel="stylesheet" type="text/css">
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
        <%  List<Object> lista = (List<Object>) request.getAttribute("dato");
            String nombre = (String) request.getAttribute("dato2");%>
    <center>
        <h1>Viajes por Chofer</h1>
        <h3><%= nombre%></h3>
        <table class="table table-hover">
            <thead>
                <tr class="text-white bg-black"> <th>Viaje Nro<th>Ruta<th>Fecha<th>Costo</tr>
            </thead>
            <%  for (Object obj : lista) {
                    if (obj instanceof Map) {
                        Map<String, Object> resultado = (Map<String, Object>) obj;
                        String viajeNro = (String) resultado.get("VIANRO");
                        String rutaNombre = (String) resultado.get("RUTNOM");
                        String fecha = (String) resultado.get("VIAFCH");
                        double costo = (Double) resultado.get("COSVIA");%>
            <tr><td><%= viajeNro%> <td><%= rutaNombre%> <td><%= fecha%> <td><%= costo%></tr>
            <%      }
                }%>
        </table>
        <a href="#" onclick="history.back()">Retornar</a><br><br>
    </center>
</body>
</html>