<?php
// Conexión a la base de datos
$serverName = "localhost";
$connectionInfo = array("Database"=>"chatbot", "UID"=>"sa", "PWD"=>"123456");
$conn = sqlsrv_connect( $serverName, $connectionInfo);

// Configuración de la codificación de caracteres utf-8
sqlsrv_query($conn, "SET NAMES 'utf8'");

// Obteniendo el mensaje del usuario a través de AJAX
$getMesg = $_POST['text'];
$getMesg = str_replace("'", "''", $getMesg); // Evitar errores de SQL injection

// Llamando al procedimiento almacenado
$sql = "{CALL GetReplyForMessage(?)}";
$params = array(&$getMesg);
$stmt = sqlsrv_prepare($conn, $sql, $params);

if(sqlsrv_execute($stmt)) {
    // Si la consulta tiene filas, mostrar la respuesta
    if(sqlsrv_has_rows($stmt)) {
        $fetch_data = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
        $reply = $fetch_data['replies'];
        echo $reply;
    } else {
        echo "¡Lo siento, no puedo ayudarte con este inconveniente! Favor comunícate con el administrador en el siguiente enlace:
    
        </br><a href='https://wa.me/51940759137?text=LEDER tengo una duda... Culturisame'>Contacto</a>";
    }
} else {
    echo "Error al ejecutar el procedimiento almacenado.";
}

// Liberar recursos
sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);
?>
