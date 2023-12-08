<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*, java.util.*, dao.Negocio" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ZEGACAY - PASAJEROS X VIAJE</title>
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
        <style>
            .info-container {
                background-color: white;
                border: 1px solid #ddd;
                padding: 10px;
                margin: 10px;
                max-width: 300px; /* Ajusta el ancho máximo según tus necesidades */
            }

            .info-container div {
                display: inline-block;
                vertical-align: top; /* Alinea los divs en la parte superior */
            }

            .cost-label {
                font-weight: bold;
                color: #007BFF;
            }

            .info-container a {
                text-decoration: none;
                color: #007BFF;
            }

            .info-container a:hover {
                text-decoration: underline;
            }
            .frameQR {
                width: 210px;
                height: 210px;
                align-self: center;
                background-image: url("fotos/noQR.png");
                background-size: cover;
            }
        </style>

        <%  
            Negocio obj = new Negocio();
            List<Comprobante> lista = (List<Comprobante>) request.getAttribute("dato");
            String codigo = (String) request.getAttribute("dato2");
            double costo = (double) request.getAttribute("dato3");%>
    <center>
        <h1>Lista de Pasajeros en el viaje Nro: <%=codigo%></h1>
        <div class="info-container">
            <div>
                Costo del Viaje: <span class="cost-label"><%=costo%></span>
            </div>
        </div><br>
        <a href="control5?opc=2&nroviaje=<%=codigo%>">Adicionar Pasajeros</a><br><br>
        <table class="table table-hover">
            <thead>
                <tr class="text-white bg-black"><th>Boleto Nro<th>Nombre Pasajero<th>Pago Total<th>Eliminar<th>QR
            </thead>
            <%
                for (Comprobante x : lista) {
            %>
            <tr><td><%=x.getNum_boleta()%>
                <td><%=x.getNom_pasajero()%>
                <td><%=x.getPago_total()%>   
                <td><a href="control5?opc=3&cod=<%=x.getNum_boleta()%>&numVia=<%=codigo%>&costo=<%=costo%>">Del</a> 
                <td><a href="<%=obj.generarQR(x.getNum_boleta())%>" target="marcoQR">Ver</a>
                    <%
                        }
                    %>                                                            
        </table>
        <div class="info-container">
            QR generado: <br><br>
        <iframe name="marcoQR" class="frameQR" frameborder="0"></iframe><br><br>
        </div>
        <a href="#" onclick="history.back()">Retornar</a><br><br>
    </center>
</body>
</html>