<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <title>REGISTRAR USUARIO</title>
        <script>
            function onInputFocus(inputElement) {
                var labelElement = inputElement.previousElementSibling;
                labelElement.style.display = "none";
            }

            function onInputBlur(inputElement) {
                var labelElement = inputElement.previousElementSibling;
                if (inputElement.value === "") {
                    labelElement.style.display = "block";
                }
            }
        </script>
        <style>
            .label {
                display: block;
            }

            .error-message {
                background-color: #cce5ff;
                color: #007bff;
                border: 1px solid #0056b3;
                padding: 10px;
                margin-bottom: 10px;
                text-align: center;
                font-weight: bold;
                border-radius: 5px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .fondo_pagina {
                position: fixed;
                top: 0;
                left: 0;
                width: 2000%;
                height: 90%;
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
        <img class="wave" src="imagenes/wave.png">
        <div class="container">
            <div class="img">
                <img src="imagenes/bgl1.svg">
            </div>
            <div class="login-content">
                <form method="post" action="control1">
                    <img src="imagenes/logo_mtravel1.png" width="380" style="border: 2px solid #000;"><br><br>
                    <img src="imagenes/avatar.svg"><br><br>
                    <h3 class="title">REGISTRO</h3><br>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="div">
                            <h5 class="label">Nombres</h5>
                            <input type="text" class="input" name="nombres" required onfocus="onInputFocus(this)" onblur="onInputBlur(this)">
                        </div>
                    </div>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="div">
                            <h5 class="label">Apellidos</h5>
                            <input type="text" class="input" name="apellidos" required onfocus="onInputFocus(this)" onblur="onInputBlur(this)">
                        </div>
                    </div>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="div">
                            <h5 class="label">Usuario</h5>
                            <input type="text" class="input" name="usuario" required onfocus="onInputFocus(this)" onblur="onInputBlur(this)">
                        </div>
                    </div>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-lock"></i>
                        </div>
                        <div class="div">
                            <h5 class="label">Contraseña</h5>
                            <input type="password" class="input" name="contrasena" required onfocus="onInputFocus(this)" onblur="onInputBlur(this)">
                        </div>
                    </div>
                    <input type="hidden" name="opc" value="2">
                    <button type="submit" class="btn">Registrar</button>
                    <% String errorRegistro = (String) request.getAttribute("errorRegistro");
                                if (errorRegistro != null) {%>
                    <div class="error-message"> <%= errorRegistro%> </div>
                    <% }%>
                    <div class="text-center">
                        <a class="font-italic isai5" href="login.jsp">Volver al inicio de sesión</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>