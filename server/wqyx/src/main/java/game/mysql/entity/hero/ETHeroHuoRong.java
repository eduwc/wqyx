package game.mysql.entity.hero;

import base.tools.csv.CsvManager;
import game.mysql.entity.BaseEntity;
import game.mysql.entity.ETPublic;

import java.util.HashMap;

/**
 * Created by Administrator on 2017/10/26 0026.
 */
public class ETHeroHuoRong extends BaseEntity {
    String kuoRongType = "4";
    public int heroKuoRong(String playerTag,String serverID)
    {
        ETPublic etPublic = new ETPublic();

        HashMap playerInfoMap = (HashMap) etPublic.getPlayerInfo(playerTag,serverID);

        Integer kuoRongLv = (Integer) playerInfoMap.get("heroKuoRongNumber")+1;
        Long diamond = (Long) playerInfoMap.get("diamond");

        HashMap hp = CsvManager.getInstance().getKuoRongInfo(kuoRongLv.toString(),kuoRongType);
        String needDiamond = (String)hp.get("need_gemstone");

        if(diamond>=Integer.parseInt(needDiamond))
        {
            etPublic.KuoRong(playerTag,serverID,1,kuoRongType);
            //扣除钻石
            etPublic.reduceDiamond(serverID,playerTag,Integer.parseInt(needDiamond));
            return 1;
        }
        else
        {
            return 3;
        }

    }

}
