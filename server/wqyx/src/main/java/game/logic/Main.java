package game.logic;



import base.net.websocket.WebSocketManager;
import base.tools.csv.CsvManager;
import game.example.GameExample;

import java.io.IOException;
import java.util.HashMap;


/**
 * Created by Administrator on 2017/8/29 0029.
 */
public class Main {


    public static void main(String[] args) {

        //示例
      //  GameExample ge = new GameExample();

        //  ge.how_to_configFile();


        try{
            new WebSocketManager(9635).run();
        }catch (Exception ex)
        {

        }

    }
}
