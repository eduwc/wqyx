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

        
        //这个发送没有实际意义，只是防止客户端报错
        $jsonArr["head"] = "SC_OTHER_NULL";
        echo json_encode($jsonArr, JSON_UNESCAPED_SLASHES);
        
        
    }
    
}
$enterGame = new EnterGame();
$enterGame->analyData();


?>