<%@page import="java.util.*"%>
<%@page import="modelo.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ZEGACAY - AGREGAR PASAJEROS</title>
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
    input[type="reset"] {
        background-color: #4E7DAE;
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="reset"]:hover {
        background-color: #337ab7;
    }
</style>

<%
    String nroviaje = (String) request.getAttribute("dato");
    Viaje p = (Viaje) request.getAttribute("dato2");
    List<Comprobante_detalle> lista = (List<Comprobante_detalle>) request.getAttribute("dato3");
%>

<center>
    <h1>Agregar pasajeros </h1>
    <form action="control5" method="post" id="pasajeroForm" onsubmit="return validar()">
        <table class="table table-hover amplia-tabla">
            <thead>
            <tr class="text-white bg-black">
                <th colspan="2">Registro de pasajeros
            </tr>
            </thead>
            <tr>
                <td>Nombre del cliente</td>
                <td><input name="nombreCliente"></td>
            </tr>
            <tr>
                <td>Tipo de pasajero</td>
                <td>
                    <div>Estudiantes: &nbsp;&nbsp;<input type="number" id="estudiantes" name="estudiantes" min="0" max="10" value="0" onchange="calcularPrecio()">
                    <div>Adultos: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="adultos" name="adultos" min="0" max="10" value="0" onchange="calcularPrecio()">
                    <div>Niños: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="number" id="niños" name="niños" min="0" max="10" value="0" onchange="calcularPrecio()">
                </td>
            </tr>
            <tr>
                <td>Asiento seleccionado</td>
                <td><input name="asiento" id="asiento" readonly></td>
            </tr>
            <tr>
                <td colspan="2">Numero de Viaje: <%=nroviaje%></td>
            </tr>
            <tr>
                <td colspan="2">Asientos:
                    <table>
                        <%
                            int[][] asientos = {
                                    {1, 2, 3, 4},
                                    {5, 6, 7, 8},
                                    {9, 10, 11, 12},
                                    {13, 14, 15, 16},
                                    {17, 18, 19, 20},
                                    {21, 22, 23, 24},
                                    {25, 26, 27, 28},
                                    {29, 30, 31, 32}
                            };

                            for (int[] fila : asientos) {
                        %>
                        <tr>
                            <%
                                for (int asi : fila) {
                                    boolean ocupado = false;
                                    for (Comprobante_detalle x : lista) {
                                        if (x.getNro_asi() == asi) {
                                            ocupado = true;
                                            break;
                                        }
                                    }
                                    if (ocupado) {
                            %>
                            <td><img src="asientos/asientoRojo.png" onclick="error(<%=asi%>)"></td>
                            <% } else { %>
                            <td><img id="<%=asi%>" src="asientos/asientoGris.png" onclick="seleccionar(<%=asi%>)"></td>
                            <% } %>
                            <% } %>
                        </tr>
                        <% }%>
                    </table>
                </td>
            </tr>
            <tr>
                <td>Precio por el viaje</td>
                <td><input name="precioPorViaje" step="0.01" readonly value="<%=p.getCostoViaje()%>"></td>
            </tr>
            <tr>
                <td>Precio total</td>
                <td><input name="precioTotal" step="0.01" readonly></td>
            </tr>
            <tr>
                <td><input type="submit" value="Enviar"></td>
                <input type="hidden" name="cantidadAsientos" id="cantidadAsientos" value="">
                <input type="hidden" name="asientosSeleccionados" id="asientosSeleccionadosInput" value="">
                <input type="hidden" name="nroviaje" value="<%=nroviaje%>">
                <input type="hidden" name="opc" value="4">
                <td><input type="reset" value="Reestablecer"></td>
            </tr>
        </table>
    </form>
    <br><a href="#" onclick="history.back()">Retornar</a><br><br>
</center>

<script>
    var asientosSeleccionados = [];

    function seleccionar(x) {
        var index = asientosSeleccionados.indexOf(x);
        if (index === -1) {
            asientosSeleccionados.push(x);
            document.getElementById(x).src = "asientos/asientoAmarillo.png";
        } else {
            asientosSeleccionados.splice(index, 1);
            document.getElementById(x).src = "asientos/asientoGris.png";
        }
        document.getElementById('asiento').value = asientosSeleccionados.join(", ");
        document.getElementById('cantidadAsientos').value = asientosSeleccionados.length;
        document.getElementById('asientosSeleccionadosInput').value = asientosSeleccionados.join(",");
    }

    function calcularPrecio() {
        var costoViaje = parseFloat(<%=p.getCostoViaje()%>);
        var numEstudiantes = parseInt(document.getElementById('estudiantes').value);
        var numAdultos = parseInt(document.getElementById('adultos').value);
        var numNiños = parseInt(document.getElementById('niños').value);

        var precioTotal = costoViaje * ((numEstudiantes * 0.7) + (numAdultos * 1) + (numNiños * 0.5));
        document.getElementsByName('precioTotal')[0].value = precioTotal.toFixed(2);
    }

    function validar() {
        var totalPasajeros = parseInt(document.getElementById('estudiantes').value) +
                parseInt(document.getElementById('adultos').value) +
                parseInt(document.getElementById('niños').value);
        var totalAsientos = asientosSeleccionados.length;
        var nombreCliente = document.getElementsByName('nombreCliente')[0].value.trim();
        if (totalPasajeros !== totalAsientos || (totalPasajeros === 0 && totalAsientos === 0) || nombreCliente === "") {
            alert("Error al procesar la información.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>