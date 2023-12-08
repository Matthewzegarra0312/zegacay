<%@page import="modelo.*"%>
<%@page import="dao.Negocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ZEGACAY - RUTAS</title>
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
    <center>
        <%
            Negocio obj = new Negocio();
        %>
        <h1>Lista de Rutas</h1>
        <a href="rutas_agregar.jsp" class="text-blue">Agregar Ruta</a><br><br>
        <table>
            <tr><th>Código de Ruta<th>Nombre de Ruta<th>Imagen<th>Ver<th>Modificar<th>Eliminar
                    <%  for (Ruta x : obj.lisRutas()) {%>
            <tr><td><%=x.getRutacod()%>
                <td><%=x.getRutanom()%>
                <td><img src="imagenes/<%=x.getRutanom()%>.jpg" width="90" height="90" class="img-circle" onerror="src='fotos/sin_foto.jpg' ">
                <td><a href="control2?opc=2&cod=<%=x.getRutacod()%>&nom=<%=x.getRutanom()%>">Viajes</a>   
                <td><a href="control2?opc=3&cod=<%=x.getRutacod()%>">Mod</a>
                <td><a href="control2?opc=5&cod=<%=x.getRutacod()%>">Del</a>
                    <%  }%>
        </table>
    </center>
</body>
</html>