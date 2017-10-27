package game.example;

import base.file.configuration.ConfigurationManager;
import base.mysql.connectionpool.C3p0PoolManager;
import game.mysql.entity.ETPublic;
import game.mysql.entity.hero.ETHeroHuoRong;


import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

/**
 * Created by Administrator on 2017/8/29 0029.
 */
public class GameExample {


    public GameExample()
    {
       /* ETHeroHuoRong ETHeroHuoRong2 = new ETHeroHuoRong();
        ETHeroHuoRong2.heroKuoRong("888888-1","1");*/

      /*  ETPublic etPublic = new ETPublic();
        int xx = etPublic.getHeroNumber("888888-1","1");
        int xx2 = xx;*/

    /*   int xx =  etPublic.getMaxKuoRongNumber("888888-1","1","4");
        int xx2 = xx;*/

    }


    //读取和写入配置文件
    public void how_to_configFile() throws IOException {
        //写入文件
        Properties prop = new Properties();
        prop.setProperty("phone7", "10086");
        ConfigurationManager.getInstance().writeCMFile("test",prop,true);

        //读取文件
        Properties prop2 = ConfigurationManager.getInstance().readCMFile("test");
        System.out.print("获取的属性是"+prop2.getProperty("phone3").toString());

    }


    public void how_to_useC3p0() throws IOException
    {
       Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            String sql = "INSERT INTO test VALUES(1,2)";
            stmt.execute(sql);
            stmt.close();
            cc.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }




}
