<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ZEGACAY - AGREGAR CHOFER</title>
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
    <center>    
        <h1>Registrar chofer</h1>
        <form action="control3" method="post">
            <table>
                <tr><td>ID Codigo<td><input name="codigo">
                <tr><td>Nombre<td><input name="nombre">
                <tr><td>Fecha de Ingreso<td><input name="fechaing">
                <tr><td>Categoria<td><input name="categoria">
                <tr><td>Chofer Pago<td><input name="choferpago">        
                        <input type="hidden" name="opc" value="1">         
                <tr><td colspan="2"><input type="submit">
                <tr><td colspan="2"><a href="#" onclick="history.back()">Retornar</a>
            </table>            
        </form>
    </center>    
</body>
</html>
