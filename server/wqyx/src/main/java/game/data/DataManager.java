package game.data;

import base.tools.csv.CsvManager;

/**
 * Created by Administrator on 2017/9/28 0028.
 */
public class DataManager {


    public void initCsvData()
    {
        //初始化csv表
        CsvManager.getInstance().loadCsv("res\\csv\\hero.csv","hero");
    }
}
