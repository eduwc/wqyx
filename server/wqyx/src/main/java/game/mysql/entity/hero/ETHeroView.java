package game.mysql.entity.hero;

import game.mysql.entity.BaseEntity;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/9/22 0022.
 */
public class ETHeroView extends BaseEntity {
    public String searchUncalled(String playerTag,String serverID)
    {
        String tbPlayerInfo = "hero"+serverID;
        String sql = "SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        String recruited = "";
        if(!ls.isEmpty())
        {
            recruited = (String) ((HashMap)ls.get(0)).get("recruited");
        }


        return  recruited;
    }
}
