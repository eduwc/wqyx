package game.mysql.entity;

import game.mysql.entity.BaseEntity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/9/28 0028.
 */
public class ETPublic extends BaseEntity {

    //**************************金币***************************//
    //获取玩家金币数
    public long getGold(String serverID,String playerTag)
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        Map playerMap = searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");
        Integer diamond = (Integer) playerMap.get("diamond");
        Long gold = (Long) playerMap.get("gold");
        return  gold;
    }

    //减少金币
    public void reduceGold(String serverID,String playerTag,int reduceGold)
    {
        String tableName = "playerInfo"+serverID;
        String reduceSql = "gold"+"-"+reduceGold;
        update(tableName,"gold",reduceSql,"2","playerTag",playerTag);
    }

    //增加金币
    public void addGold(String serverID,String playerTag,int addGold)
    {
        String tableName = "playerInfo"+serverID;
        String reduceSql = "gold"+"+"+addGold;
        update(tableName,"gold",reduceSql,"2","playerTag",playerTag);
    }

    //查询金币是否足够
    public boolean goldIsSatisfy(String serverID,String playerTag,int needGold)
    {
        long gold = getGold(serverID,playerTag);
        if(gold>=needGold)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //**************************钻石***************************//

    //获取玩家钻石数目
    public int getDiamond(String serverID,String playerTag)
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        Map playerMap = searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");
        Integer diamond = (Integer) playerMap.get("diamond");
        return  diamond;
    }


    public void reduceDiamond(String serverID,String playerTag,int reduceDiamond)
    {
        String tableName = "playerInfo"+serverID;
        String reduceSql = "diamond"+"-"+reduceDiamond;
        update(tableName,"diamond",reduceSql,"2","playerTag",playerTag);
    }

    public void addDiamond(String serverID,String playerTag,int addDiamond)
    {
        String tableName = "playerInfo"+serverID;
        String reduceSql = "diamond"+"+"+addDiamond;
        update(tableName,"diamond",reduceSql,"2","playerTag",playerTag);
    }

    //查询钻石是否足够
    public boolean diamondIsSatisfy(String serverID,String playerTag,int needDiamond)
    {
        long diamond = getDiamond(serverID,playerTag);
        if(diamond>=needDiamond)
        {
            return true;
        }
        else
        {
            return false;
        }
    }


    //***********************英雄**************************//
    // 查询英雄是否存在
    public boolean heroIsExist(String serverID,String playerTag,String heroID)
    {
        String tableName = "hero"+serverID;
        String sql = "SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        if(!ls.isEmpty())
        {
            String recruited = (String) ((HashMap)ls.get(0)).get("recruited");
            String[] recruitedArr = recruited.split(";");
            for (int i = 0; i < recruitedArr.length; i++) {
                if(heroID==recruitedArr[i])
                {
                    return  true;
                }
            }
        }
        return  false;
    }

    public List getHeroInfo(String serverID,String playerTag)
    {
        int index = 0;
        String tableName = "hero"+serverID;
        String sql = "SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        return  ls;
    }

    //获取英雄所在的索引位置
    public int getHeroIndex(String recruited,String heroID)
    {
        int index = 0;
        String[] recruitedArr = recruited.split(";");
        for (int i = 0; i < recruitedArr.length; i++) {
            if (heroID == recruitedArr[i]) {
                index = i;
                break;
            }
        }
        return index;
    }


    public int getQiangHuaLv(List heroList,String heroID)
    {
        Integer heroIndex = getHeroIndex((String) ((HashMap)heroList.get(0)).get("recruited"),heroID);
        String qiangHuaLvStr = (String) ((HashMap)heroList.get(0)).get("qiangHuaLv");
        String[] qiangHuaLvArr = qiangHuaLvStr.split(";");
        String qianghuaLv = qiangHuaLvArr[heroIndex];
        return  Integer.parseInt(qianghuaLv);
    }


    //获取进阶等级
    public int getJinJieLv(List heroList,String heroID)
    {
        Integer heroIndex = getHeroIndex((String) ((HashMap)heroList.get(0)).get("recruited"),heroID);
        String jinJieLvStr = (String) ((HashMap)heroList.get(0)).get("jinjieLv");
        String[] jinJieLvArr = jinJieLvStr.split(";");
        String iinJieLv = jinJieLvArr[heroIndex];
        return  Integer.parseInt(iinJieLv);
    }


    //***********************道具***************************//
    //获取道具数目(非限时类道具)
    public int getItemUntimeNumber(String serverID,String playerTag,String itemID)
    {
        String tableName = "itemUntime"+serverID;
        Map itemMap = searchLine("SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'"+" AND "
                +"itemID="+"'"+itemID+"'");
        if(itemMap.size()<=0)
        {
            return  0;
        }
        Integer itemNumber = (Integer) itemMap.get("itemNumber");
        return  itemNumber;
    }

    //扣除道具
    public void reduceItemUntime(String serverID,String playerTag,String itemID,int reduceNumber)
    {
        String tableName = "itemUntime"+serverID;
        String updataSql = "UPDATE "+tableName+" SET itemNumber=itemNumber-"+reduceNumber+" WHERE playerTag="+"'"+playerTag+"'"+" AND "
                +"itemID="+"'"+itemID+"'";
        update(updataSql);
    }
}
