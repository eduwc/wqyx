package base.tools.time;

import base.tools.csv.CsvManager;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Created by Administrator on 2017/10/16 0016.
 */
public class TimeManager {
    private static TimeManager _instance = null;
    public static TimeManager getInstance()
    {
        if(_instance == null)
        {
            _instance = new TimeManager();
        }
        return  _instance;
    }


    //计算2个时间的差值(秒数)
    public long gapTime(Timestamp beforeTime, Timestamp endTime)
    {

        long gapTime = (endTime.getTime()-beforeTime.getTime())/1000;
        return  gapTime;
    }


}
