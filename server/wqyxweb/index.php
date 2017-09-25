<?php
require ('Config.php');
abc();//调用b.php页面中的abc()函数
$var = $_GET["id"];
$var2 = $_GET["id2"];
echo $var."<BR>";
echo $var2."<BR>";
?>