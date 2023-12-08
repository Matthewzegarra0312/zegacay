<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*, java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ZEGACAY - VIAJES X RUTA</title>
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

        <%
            String cod = request.getParameter("cod");
            List<Viaje> lista = (List<Viaje>) request.getAttribute("dato");
            String nombre = (String) request.getAttribute("dato2");%>
    <center>
        <h1>Ruta: <%=nombre%></h1>
        <img src="imagenes/<%=nombre%>.jpg" width="300" height="200" class="img-circle" onerror="src='fotos/sin_foto.jpg' "><br><br>
        <a href="control4?opc=1&nom=<%=nombre%>&cod=<%=cod%>" class="text-blue">Agregar viaje a la Ruta</a><br><br>

        <table class="table table-hover">
            <thead>
                <tr class="text-white bg-black"><th>Codigo Viaje<th>Fecha<th>Hora<th>Costo<th>Pasajeros<th>Editar<th>Eliminar
            </thead>
            <%
                for (Viaje x : lista) {
            %>
            <tr><td><%=x.getViajeNro()%>
                <td><%=x.getViajeFechas()%>
                <td><%=x.getViajeHoras()%>
                <td><%=x.getCostoViaje()%>   
                <td><a href="control5?opc=1&cod=<%=x.getViajeNro()%>&costo=<%=x.getCostoViaje()%>">Ver</a>    
                <td><a href="control4?opc=3&cod=<%=x.getViajeNro()%> ">Mod</a>    
                <td><a href="control4?opc=5&cod=<%=x.getViajeNro()%>&codr=<%=cod%>&nom=<%=nombre%>">Del</a>        
                    <%
                        }
                    %>                                                            
        </table>
        <a href="#" onclick="history.back()">Retornar</a><br><br>
    </center>
</body>
</html>