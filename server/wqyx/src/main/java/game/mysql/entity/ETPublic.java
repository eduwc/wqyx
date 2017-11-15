package game.mysql.entity;

import base.tools.csv.CsvManager;
import game.mysql.entity.BaseEntity;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/9/28 0028.
 */
public class ETPublic extends BaseEntity {

    //**************************金币***************************//
    //获取玩家金币数
    public BigInteger getGold(String serverID,String playerTag)
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        Map playerMap = searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");
        Long diamond = (Long) playerMap.get("diamond");
        BigInteger gold = (BigInteger) playerMap.get("gold");
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
        BigInteger gold = getGold(serverID,playerTag);
        if(gold.compareTo(BigInteger.valueOf(needGold))>=0)
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
    public Long getDiamond(String serverID,String playerTag)
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        Map playerMap = searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");
        Long diamond = (Long) playerMap.get("diamond");
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
        String tableName = "hero"+serverID;
        String sql = "SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        return  ls;
    }


    public List getAllHeroInfo(String serverID)
    {
        String tableName = "hero"+serverID;
        String sql = "SELECT *FROM "+tableName;
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

    //获取玩家的英雄数目
    public int getHeroNumber(String playerTag,String serverID)
    {
        List heroInfoList =  getHeroInfo(serverID,playerTag);
        String recruitedStr = (String) ((HashMap)heroInfoList.get(0)).get("recruited");
        String[] recruitedArr = recruitedStr.split(";");
        return  recruitedArr.length;
    }

   // 获取玩家的英雄数目(用于已经查询到list的时候，防止多次查询数据库)
    public int getHeroNumberByList(List heroInfoList)
    {
        String recruitedStr = (String) ((HashMap)heroInfoList.get(0)).get("recruited");
        String[] recruitedArr = recruitedStr.split(";");
        return  recruitedArr.length;
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

    //获取已经召唤的英雄
    public String[] getCalledHero(List heroList)
    {
        String recruitedStr = (String) ((HashMap)heroList.get(0)).get("recruited");
        String[] recruitedArr = recruitedStr.split(";");
        return recruitedArr;
    }

    public String[] getXiuYangTime(List heroList)
    {
        String xiuYangStr = (String) ((HashMap)heroList.get(0)).get("xiuYangTime");
        String[] xiuYangArr = xiuYangStr.split(";");
        return xiuYangArr;
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

    //***********************扩容***************************//
    //扩容类型
    // 1-资源仓库数量 // 2-资源各资源上限  // 3-道具装备数量
    // 4-英雄数量  // 10-锻造栏 //  11-冒险队列
    public int getKuoRongLv(String playerTag,String serverID,String kuoRongType)
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        Map playerMap = searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");

        Integer kuoRongLv = 0;
        if(kuoRongType.equals("1"))
        {

        }
        else if(kuoRongType.equals("2"))
        {

        }
        else if(kuoRongType.equals("3"))
        {

        }
        else if(kuoRongType.equals("4"))
        {
            kuoRongLv = (Integer) playerMap.get("heroKuoRongNumber");
        }
        else if(kuoRongType.equals("10"))
        {

        }
        else if(kuoRongType.equals("11"))
        {

        }

        return  kuoRongLv;
    }

    public void KuoRong(String playerTag,String serverID,int kuoRongAddLv,String kuoRongType)
    {
        String tableName = "playerInfo"+serverID;
        String addSql = "";
        String fieldName = "";
        if(kuoRongType.equals("1"))
        {
        }
        else if(kuoRongType.equals("2"))
        {

        }
        else if(kuoRongType.equals("2"))
        {

        }
        else if(kuoRongType.equals("3"))
        {

        }
        else if(kuoRongType.equals("4"))
        {
            fieldName = "heroKuoRongNumber";
        }
        else if(kuoRongType.equals("10"))
        {

        }
        else if(kuoRongType.equals("11"))
        {

        }
        addSql = fieldName+"+"+kuoRongAddLv;
        update(tableName,fieldName,addSql,"2","playerTag",playerTag);
    }



    //***********************玩家数据***************************//
    public Map getPlayerInfo(String playerTag,String serverID)
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        return  searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");
    }


    public Long getMaxKuoRongNumber(String playerTag,String serverID,String kuoRongType)
    {
        Map playerInfo = getPlayerInfo(playerTag,serverID);
        Long playerLv = (Long)playerInfo.get("lv");
        Integer kuoRongNumber = (Integer)playerInfo.get("heroKuoRongNumber");

        Long playerLvNumber = (Long) (playerLv/3);

        Integer kuoRongValue = 0;  //通过扩容获得的数量
        //i=1 是因为扩容等级是从1开始算，0的话表里面是空的
        for (Integer i = 1; i <= kuoRongNumber; i++) {
            HashMap kuoRongInfo = CsvManager.getInstance().getKuoRongInfo(i.toString(),kuoRongType);
            kuoRongValue += Integer.parseInt((String) kuoRongInfo.get("dilatation_up_num"));
        }

        //5是默认值
        return playerLvNumber+kuoRongValue+5;
    }


    //********************冒险*************************//
    public List getMaoXianInfo(String playerTag,String serverID)
    {
        String tbMaXian = "maoxian"+serverID;
        String sql = "SELECT *FROM "+tbMaXian+" WHERE playerTag="+"'"+playerTag+"'";
        return search(sql);
    }


}
