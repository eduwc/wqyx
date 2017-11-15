package game.mysql.entity.hero;

import game.mysql.entity.BaseEntity;
import game.mysql.entity.ETPublic;
import org.json.JSONObject;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/9/22 0022.
 */
public class ETHeroView extends BaseEntity {
    public  List heroList = null;
    private ETPublic etPublic = new ETPublic();
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


    public JSONObject getMaoXianInfo(String playerTag,String serverID)
    {
        JSONObject maoXianInfoMap = new JSONObject();
        List maoXianList = etPublic.getMaoXianInfo(playerTag,serverID);
        for(Object attribute : maoXianList) {
            HashMap attributeMap = (HashMap)attribute;
            JSONObject infoMap = new JSONObject();
            String heroList = (String)attributeMap.get("heroList");
            String maoXianID = (String)attributeMap.get("maoXianID");
            Long endTime = (Long)attributeMap.get("endTime");

            Integer listID = (Integer)attributeMap.get("listID");

            infoMap.put("heroList",heroList);
            infoMap.put("maoXianID",maoXianID);
            infoMap.put("endTime",endTime);

            maoXianInfoMap.put(listID.toString(),infoMap);

        }

        return  maoXianInfoMap;
    }

}
