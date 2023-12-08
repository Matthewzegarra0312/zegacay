<%@page import="dao.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>      
        <link href="css/estilo_transporte2.css" rel="stylesheet" type="text/css"/>
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
            Negocio obj = new Negocio();
        %>
        <br>
    <center>
        <h1>Grafico de tipo de pasajero</h1>
        <form action="grafico2.jsp" target="zona">
            Nro de Viaje : <select name="cbNumVia" onchange="submit()">
                <%
                    for (String x : obj.lisNumVia()) {
                        out.print("<option value='" + x + "'>" + x + "</option>");
                    }
                %>
            </select>
        </form>
    </center>
    <br>
    <iframe name="zona" frameborder="0" width="100%" height="700"></iframe>    
</body>
</html>
