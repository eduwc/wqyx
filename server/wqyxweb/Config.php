<?php
Class Config
{
     static  $USE_BASE64 = false;  //是否使用base64加密
     private static $_instance = NULL;
    
    
    static function getInstance() {
      if(self::$_instance == NULL)
      {
          self::$_instance = new Config();
      }
      return self::$_instance;
    }
    
}



?>