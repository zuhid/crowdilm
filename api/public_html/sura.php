<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../private_html/initialize.php');

$sql = "SELECT id,name FROM table_name;";
echo select($sql, true);
?>
