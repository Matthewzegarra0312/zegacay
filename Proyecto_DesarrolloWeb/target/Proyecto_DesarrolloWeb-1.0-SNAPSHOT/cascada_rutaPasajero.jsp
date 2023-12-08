<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*,dao.Negocio, java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultas Cliente x Factura</title>
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
        <br>
    <center>
        <h1>Consulta por Ruta y Viaje</h1>
        <%
            Negocio obj = new Negocio();
            String codRut = "", codVia = "";
            if (request.getParameter("cbRut") != null) {
                codRut = request.getParameter("cbRut");
            }
            if (request.getParameter("cbVia") != null)
                codVia = request.getParameter("cbVia");
        %>

        <form>
            <label>Rutas&nbsp;&nbsp;&nbsp;</label>
            <select class="form-control" name="cbRut" onchange="submit()">
                <option>--- Elegir ---</option>
                <%
                    for (Ruta x : obj.lisRutas()) {
                        if (x.getRutacod().equals(codRut)) {
                            out.print("<option value=" + x.getRutacod() + " selected>" + x.getRutanom());
                        } else {
                            out.print("<option value=" + x.getRutacod() + ">" + x.getRutanom());
                        }
                    }
                %>
            </select>
            <p>
                <label>Viajes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <select name="cbVia" onchange="submit()">
                    <%
                        for (Viaje x : obj.lisRutasViajes(codRut)) {
                            if (x.getViajeNro().equals(codVia)) {
                                out.print("<option value=" + x.getViajeNro() + " selected>" + x.getViajeNro());
                            } else {
                                out.print("<option value=" + x.getViajeNro() + ">" + x.getViajeNro());
                            }
                        }
                    %>
                </select>
        </form>
        <br>
    </center>
    <table>
        <thead>
            <tr><th>Nº Boleta<th>Nombres<th>Pago
        </thead>
        <tbody>
            <%
                double sm = 0;
                for (Comprobante x : obj.pasajeros(codVia)) {
                    out.print("<tr><td>" + x.getNum_boleta() + "<td>" + x.getNom_pasajero() + "<td>" + x.getPago_total());
                    sm = sm + x.getPago_total();
                }
            %>
            <tr><td colspan="2" style="font-size: 20px; font-weight: bold;">Total<td style="font-size: 20px; font-weight: bold;"><%=sm%>
        </tbody>    
    </table>            
</body>
</html>
