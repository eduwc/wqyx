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
}
