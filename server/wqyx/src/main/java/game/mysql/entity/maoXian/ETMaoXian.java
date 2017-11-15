package game.mysql.entity.maoXian;

import base.tools.csv.CsvManager;
import game.mysql.entity.BaseEntity;
import game.timer.TimingManager;

/**
 * Created by Administrator on 2017/11/10 0010.
 */
public class ETMaoXian extends BaseEntity {

    public void beginMaoXian(String playerTag,String serverID,String heroList,String maoXianID,Integer listID)
    {
        String[] heroArr = heroList.split(";");

        long currentTime = System.currentTimeMillis()/1000;
        Integer cd = (CsvManager.getInstance().getMaoXianCd(maoXianID))*60;
        //根据副本来设置时间
        long endMaoXianCD = cd+currentTime;

        String tableName  = "maoxian"+serverID;
        String sql = "INSERT INTO "+tableName+"(id,playerTag,heroList,maoXianID,endTime,listID)"
                +" VALUES "+"(null,"+"'"+playerTag+"'"+","+"'"+heroList+"'"
                +","+"'"+maoXianID+"'"+","+endMaoXianCD+","+listID+")";
        insert(sql);


        TimingManager.getInstance().insertMaoXianCd(playerTag,listID.toString(),cd);


    }

}
