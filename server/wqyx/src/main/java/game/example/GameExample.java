package game.example;

import base.file.configuration.ConfigurationManager;
import base.mysql.connectionpool.C3p0PoolManager;


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


      /*  ETPublic etPublic = new ETPublic();
        etPublic.reduceGold("playerinfo1","888888-1",100);*/


  /*      String tableName = "hero1";
        String field = "recruited";
        String value = "37475";
        String condition = "playerTag";
        String conditionValue = "888888-1";
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
       *//*     String sql = "UPDATE "+tableName+" SET "+field+"="+
                    "'"+value+"'"+" WHERE "+condition+"="+"'"+conditionValue+"'";*//*
            String pp = "gold"+"+"+50;
            String sql = "UPDATE  playerinfo1 SET gold ="+pp+" where playerTag='888888-1'";
            stmt.executeUpdate(sql);

            stmt.close();
            cc.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
*/

 /*       String sql = "SELECT *FROM "+"hero1"+" WHERE playerTag="+"'"+"888888-1"+"'";
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            ResultSet resultSet = stmt.executeQuery(sql);
            java.sql.ResultSetMetaData rsmd = resultSet.getMetaData();
            int numberOfColumns = rsmd.getColumnCount();
            List list = new ArrayList();
            while(resultSet.next()){

                Map rsTree = new HashMap(numberOfColumns);
                for(int r=1;r<numberOfColumns+1;r++)
                {
                    rsTree.put(rsmd.getColumnName(r),resultSet.getObject(r));
                }
                list.add(rsTree);
            }
            resultSet.close();
            stmt.close();
            cc.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }


        ETHeroView etHeroView = new ETHeroView();
        etHeroView.searchUncalled("888888-1","1");*/


      /*  //初始化 csv表
        CsvManager.getInstance().loadCsv("res\\csv\\res.csv","res");
        HashMap sp = CsvManager.getInstance().getCsvMap("res");
        String s = (String) ((HashMap)(CsvManager.getInstance().getCsvMap("res").get("5"))).get("img1_id");*/


/*        Integer a = 1;
        long start = 0;
        long end = 0;
        // 先垃圾回收
        System.gc();
        start = Runtime.getRuntime().freeMemory();
        HashMap map = new HashMap();
        for (int i = 0; i < 1000000; i++) {
            map.put(i, a);
        }
        // 快要计算的时,再清理一次
        System.gc();
        end = Runtime.getRuntime().freeMemory();
        System.out.println("一个HashMap对象占内存:" + (end - start));*/

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
