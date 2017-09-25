<?php
require_once ($_SERVER['DOCUMENT_ROOT'].'/wqyxweb/base/mysql/BaseMysql.php');
use mysql\BaseMysql;
class MysqlManager
{
    private $baseMysql = NULL;
    
      public function __construct() {
         $this->conect("localhost", "root", "123456", "wqyxweb");
      } 
    
    public function conect($hostName,$account,$passWord,$databaseName)
    {
        $this->baseMysql = new BaseMysql();
        $this->baseMysql->conect($hostName, $account, $passWord, $databaseName);
    }
    
    
    public function searchForObj($sql)
    {
        return $this->baseMysql->searchForObj($sql);
    }
    
    public function insert($sql)
    {
         $this->baseMysql->insert($sql);
    }
    
    public function update($sql)
    {
        $this->baseMysql->update($sql);
    }
    
}

?>