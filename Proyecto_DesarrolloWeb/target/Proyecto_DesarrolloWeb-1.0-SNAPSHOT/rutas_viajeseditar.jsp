<%@page import="modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ZEGACAY - MODIFICAR VIAJE</title>
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
            Viaje p = (Viaje) request.getAttribute("dato");
        %>
    <center>    
        <h1>Modificar datos de Viaje</h1>
        <form action="control4" method="post">
            <table>         
                <tr><td>Viaje Nro<td><input name="viajenro" value="<%= p.getViajeNro()%>" readonly>
                <tr><td>Bus Nro<td><input name="busnro" value="<%= p.getBusNro()%>" required>
                <tr><td>Codigo Ruta<td><input name="codruta" value="<%= p.getRutaCodigo()%>" readonly>     
                <tr><td>ID Chofer<td><input name="idchofer" pattern="[C][0-9]{3}" placeholder="Ejm. C005,C010" value="<%= p.getIdCodChofer()%>" required>
                <tr><td>Hora del Viaje<td><input name="hora" pattern="[0-2][0-9][:][0-5][0-9]" placeholder="Ejm. 17:00,12:45" value="<%= p.getViajeHoras()%>" required>
                <tr><td>Fecha del Viaje<td><input type="date" name="fecha" value="<%= p.getViajeFechas()%>" required>
                <tr><td>Costo del Viaje<td><input name="costoviaje" pattern="[0-9]{1-3}" value="<%= p.getCostoViaje()%>" required>         
                        <input type="hidden" name="opc" value="4">         
                <tr><td colspan="2"><input type="submit">
                <tr><td colspan="2"><a href="#" onclick="history.back()">Retornar</a>
            </table>            
        </form>
    </center>    
</body>
</html>