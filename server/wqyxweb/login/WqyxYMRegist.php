<?php
header("Content-type: text/html; charset=utf-8"); 
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/config.php');
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/mysql/MysqlManager.php');
class WqyxYMRegist
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
            echo "长度".strlen($userName);
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
             $mysqlManager->insert("INSERT INTO user_info(id,userName,passWord) VALUES(NULL,'$userName','$passWord')");
              //注册成功  发送服务器列表
             $json_string = file_get_contents('../json/serverList.json');
             $jsonArr["head"] = "SC_OTHER_SERVERLIST";    
             $jsonArr["list"] = $json_string;
        }
        else
        {                   
            $jsonArr["head"] = "SC_ERROR_TIP";
            $jsonArr["error"] = "账号已经存在";                                  
        }
        echo json_encode($jsonArr);
 
    }

}
$regist = new WqyxYMRegist();
$regist->analyData();

?>