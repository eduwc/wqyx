package game.mysql.entity.hero;

import game.mysql.entity.BaseEntity;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/9/22 0022.
 */
public class ETHeroView extends BaseEntity {
    public  List heroList = null;
    public String searchcalled(String playerTag,String serverID)
    {
        String tbPlayerInfo = "hero"+serverID;
        String sql = "SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'";
        heroList = search(sql);
        String recruited = "";
        if(!heroList.isEmpty())
        {
            recruited = (String) ((HashMap)heroList.get(0)).get("recruited");
        }

        return  recruited;
    }


    public String getQiangHuaLv()
    {
        return  (String) ((HashMap)heroList.get(0)).get("qiangHuaLv");
    }

    public String getJinJieLv()
    {
        return  (String) ((HashMap)heroList.get(0)).get("jinjieLv");
    }

    public String getExp()
    {
        return  (String) ((HashMap)heroList.get(0)).get("exp");
    }

    public String getLv()
    {
        return  (String) ((HashMap)heroList.get(0)).get("lv");
    }

    public String getXiuYangTime()
    {
        return  (String) ((HashMap)heroList.get(0)).get("xiuYangTime");
    }
}
