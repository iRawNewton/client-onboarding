<?php
header('Content-Type: application/json');
include "../db.php";

$name = $_POST['proj_name'];
$desc =  $_POST['proj_desc'];

$startDate = $_POST['proj_startdate'];
$timestamp = strtotime($startDate);
$sdate = date('Y-m-d',$timestamp);

$endDate = $_POST['proj_enddate'];
$timestamp = strtotime($endDate);
$edate = date('Y-m-d',$timestamp);

$cli_id =  $_POST['proj_cli_id'];
$dev_id =  $_POST['proj_dev_id'];

$stmt = $db->prepare("INSERT INTO cli_project (proj_name, proj_desc, proj_startdate, proj_enddate, proj_cli_id, proj_dev_id) VALUES (?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$name, $desc, $sdate, $edate, $cli_id, $dev_id]);

echo json_encode([
'success' => $result
]);
