<?php
header("Content-type: text/html; charset=utf-8");
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/config.php');
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/mysql/MysqlManager.php');
Class WqyxYMLogin
{
    //YM 是yunmo的缩写
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
        $passWord = $userInfoJson["passWord"];
        
        $jsonArr = array();
        if(strlen($userName)<6 || strlen($passWord )<6)
        {
            $jsonArr["head"] = "SC_ERROR_TIP";
            $jsonArr["error"] = "账号或密码要大于等于6位";
            echo json_encode($jsonArr);
            return;
        }
        elseif(strlen($userName)>10 || strlen($passWord )>10)
        {
            $jsonArr["head"] = "SC_ERROR_TIP";
            $jsonArr["error"] = "账号或密码要小于或等于10位";
            echo json_encode($jsonArr);
            return;
        }
        else if(!ctype_alnum($userName)||!ctype_alnum($passWord))
        {
            $jsonArr["head"] = "SC_ERROR_TIP";
            $jsonArr["error"] = "账号或密码只能是数字或字母";
            echo json_encode($jsonArr);
            return;
        }
        
        $mysqlManager = new MysqlManager();             
        $res = $mysqlManager->searchForObj("select *from user_info where userName='$userName' ");
      
        if(!$res)
        {
            $jsonArr["head"] = "SC_ERROR_TIP";
            $jsonArr["error"] = "账号不存在"; 
        }
        else
        {    
             //上一次登录的服务器ID
            $lastServerID =$res->serverID;
            
             //发送服务器列表
             $json_string = file_get_contents('../json/serverList.json');
             $jsonArr["head"]                = "SC_OTHER_SERVERLIST";    
             $jsonArr["list"]                    = json_decode($json_string);
             $jsonArr["lastServerID"]   = (int)$lastServerID;
             
            
        }
        //JSON_UNESCAPED_SLASHES  不需要转义字符
        echo json_encode($jsonArr,JSON_UNESCAPED_SLASHES);
 
    }

}
$login = new WqyxYMLogin();
$login->analyData();

?>