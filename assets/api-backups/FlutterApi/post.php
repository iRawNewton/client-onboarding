<?php
header('Content-Type: application/json');
include "../FlutterApi/db.php";

// if(isset($_POST[]!='')){
$id = $_POST['cli_userid'];
$pass =  $_POST['cli_pass'];
$name = $_POST['cli_name'];
$email =  $_POST['cli_email'];
$phone = $_POST['cli_phone'];
$project_name =  $_POST['cli_project_name'];
$project_desc = $_POST['cli_project_desc'];

$stmt = $db->prepare("INSERT INTO cli_client_table (cli_userid, cli_pass, cli_name, cli_email, cli_phone, cli_project_name, cli_project_desc) VALUES (?, ?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$id, $pass, $name, $email, $phone, $project_name, $project_desc]);

echo json_encode([
'success' => $result
]);
// }