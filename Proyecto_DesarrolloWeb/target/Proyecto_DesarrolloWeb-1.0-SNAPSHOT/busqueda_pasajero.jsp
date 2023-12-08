<%@page import="java.util.List"%>
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
            List<Comprobante_detalle> lista = (List<Comprobante_detalle>) request.getAttribute("dato");
            String nombre = (String) request.getAttribute("dato2");
        %>
        <h1>Compras del Pasajero: <%=nombre%></h1>
        <table>
            <tr><th>Nro Boleta<th>Num Viaje<th>Nro Asiento<th>Tipo<th>Pago
                    <%  for (Comprobante_detalle x : lista) {%>
            <tr><td><%=x.getNum_boleta()%>
                <td><%=x.getNum_viaje()%>
                <td><%=x.getNro_asi()%>
                <td><%=x.getTipo()%>    
                <td><%=x.getPago()%>        
                    <%  }%>
        </table>
        <br><a href="#" onclick="history.back()">Retornar</a><br><br>
    </center>
</body>
</html>