
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*,dao.Negocio" %>
<!DOCTYPE html>
<html>
    <head>
        <title>GRAFICOS</title>
        <script src="js/Chart.min.js" type="text/javascript"></script>
        <style>
            .container {
                width: 70%;
                margin: 15px auto;
            }
            body {
                text-align: center;
                color: green;
            }
            h2 {
                text-align: center;
                font-family: "Verdana", sans-serif;
                font-size: 30px;
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
        </style>
    </head>
    <body>
        <div class="fondo_pagina"></div>
        <%
            Negocio obj = new Negocio();
            int numVia = Integer.parseInt(request.getParameter("cbNumVia"));
            String data = "";
            String color = "['rgb(0,210,146)','rgb(166,96,206)','rgb(199,199,199)']";
            int x[] = new int[3];
            x = obj.tipoPasajero(numVia);
            data = x[0] + "," + x[1] + "," + x[2];

        %>   

        <div class="container">
            <h2>Cantidad por Tipo de pasajero</h2>
            <div>
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </body>
    <script>
        var ctx = document.getElementById("myChart").getContext("2d");
        var myChart = new Chart(ctx, {
            type: "pie",
            data: {
                labels: ['Estudiantes', 'Adultos', 'Niños'],
                datasets: [
                    {
                        label: "Cantidad",
                        data: [<%=data%>],
                        backgroundColor:<%=color%>,
                    },
                ],
            },
        });
    </script>
</html>