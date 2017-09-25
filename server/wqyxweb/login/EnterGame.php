<?php
header("Content-type: text/html; charset=utf-8");
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/config.php');
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/mysql/MysqlManager.php');
class EnterGame
{
    private $userInfo = "";
    function analyData()
    {
        if(Config::$USE_BASE64 == true)
        {
            $userInfoBase64 =   $_GET["userInfo"];
            $userInfo = base64_decode($userInfoBase64);
        }
        else
        {
            $userInfo = $_GET["userInfo"];
        }
        
        $userInfoJson = json_decode($userInfo,true);
        
        $userName = $userInfoJson["userName"];
        $serverID = $userInfoJson["serverID"];
  
        
        $mysqlManager = new MysqlManager();
        $mysqlManager->update("update user_info set serverID='$serverID' where  userName='$userName'");

        
    }
    
}
$enterGame = new EnterGame();
$enterGame->analyData();


?>