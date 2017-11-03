package game.example;

import base.file.configuration.ConfigurationManager;
import base.mysql.connectionpool.C3p0PoolManager;
import base.tools.time.TimeManager;
import game.timer.TimingManager;


import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

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
        final  TimingManager timeManager = new TimingManager("1");



             final ConcurrentHashMap map = new ConcurrentHashMap();

        map.put("1",1000);
        map.put("2",1000);
        map.put("3",1000);



        TimerTask task = new TimerTask() {
            Iterator iter = map.entrySet().iterator();
            @Override
            public void run() {
                while (iter.hasNext()) {
                    Map.Entry entry = (Map.Entry) iter.next();

                    System.out.println("内容是"+entry.setValue((Integer)entry.getValue()-1) );
                }
                iter = map.entrySet().iterator();
            }
        };
        Timer timer = new Timer();
        long delay = 0;
        long intevalPeriod = 1 * 1000;
        // schedules the task to be run in an interval
     //   timer.scheduleAtFixedRate(task, delay, intevalPeriod);


        TimerTask task2 = new TimerTask() {
            @Override
            public void run() {
                timeManager.deleteXiuYangItem("888888-1","1","4002");
              /*  try {
                    Thread.sleep(5000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }*/
            }
        };
        Timer timer2 = new Timer();
        long delay2 = 5000;
        long intevalPeriod2 = 5 * 1000;
        // schedules the task to be run in an interval
        timer2.scheduleAtFixedRate(task2, delay2, intevalPeriod2);



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
