<?php
namespace mysql;

class BaseMysql
{
  
    private  $link        = NULL;
    private  $result    = NULL;
    public function conect($hostName,$account,$passWord,$databaseName)
    {
        $this->link = mysql_connect($hostName,$account,$passWord)or die("无法连接到数据库服务器");
        mysql_query("set names 'utf8'");
        $dbSelect = mysql_select_db($databaseName,$this->link);
          
    }
    
    public function insert($sql)
    {
        mysql_query($sql,$this->link);
        $this->close();
    }
    
    
    public function searchForObj($sql)
    {
        $this->result = mysql_query($sql,$this->link);
        $info = mysql_fetch_object($this->result);
        mysql_free_result($this->result);
        return $info;       
    }
    
    public function update($sql)
    {
        mysql_query($sql,$this->link);
        $this->close();
    }
    

    private function  close()
    {      
        mysql_close($this->link);
    }
    
}

?>