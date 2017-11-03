package game.logic;



import base.mysql.connectionpool.C3p0PoolManager;
import base.net.websocket.WebSocketManager;
import base.tools.csv.CsvManager;
import game.data.DataManager;
import game.example.GameExample;

import java.io.IOException;
import java.util.HashMap;


/**
 * Created by Administrator on 2017/8/29 0029.
 */
public class Main {


    public static void main(String[] args) {




        //  ge.how_to_configFile();


        try{
            C3p0PoolManager.getInstance().getConnection();


            //初始化数据
            DataManager dataManager = new DataManager();
            dataManager.initCsvData();

            //示例
         //   GameExample ge = new GameExample();

            new WebSocketManager(9635).run();



        }catch (Exception ex)
        {

        }



    }
}
