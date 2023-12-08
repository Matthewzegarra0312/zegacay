$(document).ready(function () {
    $(document).on('keyup', '#txtnombre', function () {
        let valor = $(this).val();
        listado(valor);
    });

    function listado(consulta) {
        opc = "6";
        $.get("control3", {opc, consulta}, (response) => {
            const misDatos = JSON.parse(response);
            let template = "";
            console.log(misDatos);

            template += `  
             <table>
                <tr><th>Código</th>
                <th>Nombre</th>
                <th>Fecha de Ingreso</th>
                <th>Categoría</th>
                <th>Foto</th>
                <th>Ver</th>
                <th>Actualizar</th>
                <th>Eliminar</th>
                 </tr>   
            <tbody>`;
            misDatos.forEach(midato => {
                template += `  
                <tr><td>${midato.codigo}
                    <td>${midato.nombre}
                    <td>${midato.fechaingreso}
                    <td>${midato.categoria}
                    <td><img src="fotos/${midato.codigo}.jpg" width="90" height="90" class="img-circle" onerror="src='fotos/sin_foto.jpg' ">
                    <td><a href="javascript:Ver('${midato.codigo}','${midato.nombre}');">Ver</a></td>
                    <td><a href="javascript:Modificar('${midato.codigo}');">Mod</a></td>
                    <td><a href="javascript:Eliminar('${midato.codigo}');">Del</a></td>
                </tr>`;

            })
            template += `</tbody></table>`;
            $("#tablares").html(template);

        })
    } //fin de listado 

}) 