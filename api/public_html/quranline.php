<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../private_html/initialize.php');

$quran_id = array_change_key_case($_GET, CASE_LOWER)['quran_id'];
$sql = "select line_id, text from quran_line where quran_id='" . $quran_id . "'";
echo select($sql, true);
?>
