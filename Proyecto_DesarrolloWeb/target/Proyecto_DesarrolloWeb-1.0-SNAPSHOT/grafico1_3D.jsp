<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="java.io.OutputStream"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="dao.Negocio"%>
<%@page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .chart-container {
                text-align: center;
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
        <div style="chart-container">
            <%
                DefaultCategoryDataset datos = new DefaultCategoryDataset();

                Negocio obj = new Negocio();
                for (String x[] : obj.lisPasRuta()) {
                    datos.setValue(Double.parseDouble(x[2]), "pago total", x[1]);
                }
                JFreeChart graf = ChartFactory.createBarChart3D("Grafico de cantidad de pasajeros por ruta", "Ruta", "Pasajeros", datos,
                        PlotOrientation.HORIZONTAL, true, true, false);
                response.setContentType("image/jpeg");
                OutputStream salida = response.getOutputStream();
                ChartUtilities.writeChartAsJPEG(salida, graf, 600, 600);
                salida.close();
            %>
        </div>
    </body>
</html>