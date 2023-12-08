<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ZEGACAY S.A.C.</title>
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>
         <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
        <style>
            img {
                float: left; 
                margin-left: 0px; 
                margin-right: 30px; 
            }
            .frame_content{
                width: 100%;
                height: 1000px;
            }
        </style>
    </head>
    <body>
        <img src="fotos/logo_empresa.png" alt="imagen" width="350" height="90"/>
        <nav>
            <ul class="menu-horizontal">
                <li><a href="inicio.jsp" target="marco"><i class="bx bx-home-alt-2"></i> Inicio</a></li>
                <li><a href="rutas.jsp" target="marco"><i class="bx bx-map"></i> Rutas</a></li>
                <li><a href="choferes.jsp" target="marco"><i class="bx bxs-contact"></i> Choferes</a></li>
                <li>
                    <a href="#"><i class="bx bx-search"></i> Busquedas</a>
                    <ul class="menu-vertical">
                        <li><a href="busquedas.jsp" target="marco">Por filtrado</a></li>
                        <li><a href="cascada_rutaPasajero.jsp" target="marco">En cascada</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="bx bx-chart"></i> Gráficos</a>
                    <ul class="menu-vertical">
                        <li><a href="grafico1.jsp" target="marco">Pasajeros por Ruta</a></li>
                        <li><a href="grafico1_3D.jsp" target="marco">Pasajeros por Ruta 3D</a></li>
                        <li><a href="formGrafico2.jsp" target="marco">Tipos de pasajeros por viaje</a></li>
                    </ul>
                </li>
                <li><a href="buses.jsp" target="marco"><i class="bx bx-bus"></i> Buses</a></li>
                <li><a href="acercade.jsp" target="marco"><i class="bx bx-info-circle"></i> Acerca de</a></li>
                <li><a href="login.jsp"><i class="bx bx-exit"></i> Salir</a></li>
            </ul>
        </nav>
        <iframe name="marco" frameborder="0" class="frame_content"></iframe>
    </body>
</html>