$(document).ready(function () {

    $(document).on('keyup', '#txtnombre', function () {
        let valor = $(this).val();
        listado(valor);
    });

    function listado(consulta) {
        opc = "5";
        $.get("control5", {opc, consulta}, (response) => {
            const misDatos = JSON.parse(response);
            let template = ""; num=0;
            console.log(misDatos);

            template += `  
             <table class="table table-hover">  
                                    <thead class="text-white bg-dark">  
                                        <tr>  
                                            <th>Num. Orden</th>  
                                            <th>Nombre</th>  
                                            <th>Buscar</th>
                                        </tr>  
                                    </thead>  
                                    <tbody>`;
            misDatos.forEach(midato => {
                num=num+1; template += `  
                <tr>  
                    <td>${num}</td>
                    <td>${midato.nom_pasajero}</td>  
                    <td><a href="javascript:pasaSeleccion('${midato.nom_pasajero}');">Ver</a></td>
                </tr>`;

            })
            template += `</tbody></table>`;
            $("#tablares").html(template);

        })
    } //fin de listado 

}) 