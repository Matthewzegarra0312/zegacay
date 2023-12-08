<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*, java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ZEGACAY - AGREGAR VIAJE A UNA RUTA</title>
        <link href="css/estilo_transporte2.css" rel="stylesheet" type="text/css"/>
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
        <%
            List<Ruta> lista = (List<Ruta>) request.getAttribute("veri");
            int nueVia = (int) request.getAttribute("nueViaje");
            String nombre = request.getParameter("nom");
            String cod = request.getParameter("cod");
        %>
    <center>    
        <h1>Registrar viajes</h1>
        <form action="control4" method="post">
            <table>
                <tr><td>Viaje Nro<td><input name="viajenro" value="<%=nueVia%>" readonly>
                <tr><td>Bus Nro<td><input type="number" name="busnro" required>
                <tr><td>Codigo Ruta<td><input name="codruta" value="<%= lista.get(0).getRutacod()%>" readonly>     
                <tr><td>ID Chofer<td><input name="idchofer" pattern="[C][0-9]{3}" placeholder="Ejm. C005,C010" required>
                <tr><td>Hora del Viaje<td><input name="hora" pattern="[0-2][0-9][:][0-5][0-9]" placeholder="Ejm. 17:00,12:45" required>
                <tr><td>Fecha del Viaje<td><input type="date" name="fecha" required>
                <tr><td>Costo del Viaje<td><input name="costoviaje" pattern="[0-9]{1-3}" required>         
                        <input type="hidden" name="opc" value="2">
                        <input type="hidden" name="nom" value="<%=nombre%>">
                        <input type="hidden" name="cod" value="<%=cod%>">
                <tr><td colspan="2"><input type="submit">
                <tr><td colspan="2"><a href="#" onclick="history.back()">Retornar</a>
            </table>            
        </form>
    </center>    
</body>
</html>