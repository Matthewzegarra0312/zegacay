<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*,dao.Negocio" %>
<!DOCTYPE html>
<html>
    <head>
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
            String label = "", data = "";
            String color = "['rgb(7,153,182)','rgb(74,110,176)','rgb(17,76,95)','rgb(156,210,211)','rgb(242,230,207)',"
                    + "'rgb(7,153,182)','rgb(74,110,176)','rgb(17,76,95)','rgb(156,210,211)','rgb(242,230,207)',"
                    + "'rgb(7,153,182)','rgb(74,110,176)','rgb(17,76,95)','rgb(156,210,211)','rgb(242,230,207)',"
                    + "'rgb(7,153,182)','rgb(74,110,176)','rgb(17,76,95)','rgb(156,210,211)','rgb(242,230,207)',"
                    + "'rgb(7,153,182)','rgb(74,110,176)']";
            for (String x[] : obj.lisPasRuta()) {
                label += "'" + x[1] + "',";
                data += x[2] + ",";
            }
            if (obj.lisPasRuta().size() > 0) {
                label = label.substring(0, label.length() - 1);
                data = data.substring(0, data.length() - 1);
            }
        %>   

        <div class="container">
            <h2>Cantidad de pasajeros por Ruta</h2>
            <div>
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </body>
    <script>
        var ctx = document.getElementById("myChart").getContext("2d");
        var myChart = new Chart(ctx, {
            type: "bar",
            data: {
                labels: [<%=label%>],
                datasets: [
                    {
                        label: "Pasajeros",
                        data: [<%=data%>],
                        backgroundColor:<%=color%>,
                    },
                ],
            },
        });
    </script>
</html>