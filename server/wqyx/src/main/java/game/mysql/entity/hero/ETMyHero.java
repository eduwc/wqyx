package game.mysql.entity.hero;

import base.tools.csv.CsvManager;
import game.mysql.entity.BaseEntity;
import game.mysql.entity.ETPublic;
import game.mysql.entity.common.ETCommon;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/10/10 0010.
 */
public class ETMyHero extends BaseEntity {
    ETPublic etPublic = new ETPublic();

    //返回1 强化成功  2.道具数量不足  3.金币数量不足
    public int qiangHua(String playerTag,String serverID,String heroID)
    {
/*        //查询是否存在这个英雄
        boolean heroIsExist =  ETCommon.getInstance().heroIsExist(serverID,playerTag,heroID);*/


        long gold = etPublic.getGold(serverID,playerTag);

        HashMap heroMap = (HashMap)(CsvManager.getInstance().getCsvMap("hero").get(heroID));
        String propid = (String) heroMap.get("strengthen_need_propid");
        String callHeroLvStr = (String )heroMap.get("recruit_level");
        int callHeroLv = Integer.parseInt(callHeroLvStr);



        List heroList = etPublic.getHeroInfo(serverID,playerTag);
        int qiangHuaLv = etPublic.getQiangHuaLv(heroList,heroID);
        int needItemNumber = getQinagHuaNeedItemNumber(qiangHuaLv);
        int needGold = getQinagHuaNeedGold(qiangHuaLv,callHeroLv);

        int itemNumber = etPublic.getItemUntimeNumber(serverID,playerTag,propid);
        if (itemNumber<needItemNumber)
        {
            return  2;
        }
        else
        {
            if(gold<needGold)
            {
                return 3;
            }
            else
            {
                //强化
                updataQiangHua(serverID,playerTag,heroID,needGold,needItemNumber,propid);
                return 1;
            }
        }

    }



    //返回1 进阶成功  2.道具数量不足  3.金币数量不足
    public int jinjie(String playerTag,String serverID,String heroID)
    {
/*        //查询是否存在这个英雄
        boolean heroIsExist =  ETCommon.getInstance().heroIsExist(serverID,playerTag,heroID);*/


        long gold = etPublic.getGold(serverID,playerTag);

        HashMap heroMap = (HashMap)(CsvManager.getInstance().getCsvMap("hero").get(heroID));
        String propid = "100";
        String callHeroLvStr = (String )heroMap.get("recruit_level");
        int callHeroLv = Integer.parseInt(callHeroLvStr);



        List heroList = etPublic.getHeroInfo(serverID,playerTag);
        int jinJieLv = etPublic.getJinJieLv(heroList,heroID);
        int needItemNumber = getJinJieNeedItemNumber(jinJieLv);
        int needGold = getJinJieNeedGold(jinJieLv,callHeroLv);

        int itemNumber = etPublic.getItemUntimeNumber(serverID,playerTag,propid);
        if (itemNumber<needItemNumber)
        {
            return  2;
        }
        else
        {
            if(gold<needGold)
            {
                return 3;
            }
            else
            {
                //强化
                updataJinjie(serverID,playerTag,heroID,needGold,needItemNumber,propid);
                return 1;
            }
        }

    }



    //获取强化需要的道具数量
    public int getQinagHuaNeedItemNumber(int qiangHuaLv)
    {
        //公式是 需要的道具数量为 强化等级+1
        return  qiangHuaLv+1;
    }

    //获取强化需要的金币数
    public int getQinagHuaNeedGold(int qiangHuaLv,int heroCallLv)
    {
        if (qiangHuaLv == 0)
        {
            return  1000*heroCallLv*heroCallLv;
        }
        else if(qiangHuaLv == 1)
        {
            return  2000*heroCallLv*heroCallLv;
        }
        else if(qiangHuaLv == 2)
        {
            return  5000*heroCallLv*heroCallLv;
        }
        else if(qiangHuaLv == 3)
        {
            return  10000*heroCallLv*heroCallLv;
        }
        else if(qiangHuaLv == 4)
        {
            return  20000*heroCallLv*heroCallLv;
        }
        return 0;
    }

    //强化
    public boolean updataQiangHua(String serverID,String playerTag,String heroID,
                                  int callNeedGold,int itemNumber,String itemID)
    {
        int index = 0;
        String tableName = "hero"+serverID;
        String sql = "SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        if(!ls.isEmpty())
        {
            String recruited = (String) ((HashMap)ls.get(0)).get("recruited");
            String[] recruitedArr = recruited.split(";");
            for (int i = 0; i < recruitedArr.length; i++) {
                if(heroID.equals(recruitedArr[i]))
                {
                    index = i;
                    break;
                }
            }
            String qiangHuaLv = (String) ((HashMap)ls.get(0)).get("qiangHuaLv");
            String[] qiangHuaLvArr = qiangHuaLv.split(";");
            Integer qianghuaHero =  Integer.parseInt(qiangHuaLvArr[index]);
            qianghuaHero+= 1;
            qiangHuaLvArr[index] = qianghuaHero.toString();
            //拼接成字符串
            String newQiangHuaStr = "";
            for (int i = 0; i < qiangHuaLvArr.length; i++) {
                if(i<qiangHuaLvArr.length-1)
                {
                    newQiangHuaStr += qiangHuaLvArr[i]+";";
                }
                else
                {
                    newQiangHuaStr += qiangHuaLvArr[i];
                }

            }

            //扣除金币
            ETPublic etPublic = new ETPublic();
            etPublic.reduceGold(serverID,playerTag,callNeedGold);

            //扣除道具
            etPublic.reduceItemUntime(serverID,playerTag,itemID,itemNumber);

            return update(tableName,"qiangHuaLv",newQiangHuaStr,"1","playerTag",playerTag);
        }
        return  false;
    }



    //强化
    public boolean updataJinjie(String serverID,String playerTag,String heroID,
                                  int callNeedGold,int itemNumber,String itemID)
    {
        int index = 0;
        String tableName = "hero"+serverID;
        String sql = "SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        if(!ls.isEmpty())
        {
            String recruited = (String) ((HashMap)ls.get(0)).get("recruited");
            String[] recruitedArr = recruited.split(";");
            for (int i = 0; i < recruitedArr.length; i++) {
                if(heroID.equals(recruitedArr[i]))
                {
                    index = i;
                    break;
                }
            }
            String jinJieLv = (String) ((HashMap)ls.get(0)).get("jinjieLv");
            String[] jinJieLvArr = jinJieLv.split(";");
            Integer jinJieHero =  Integer.parseInt(jinJieLvArr[index]);
            jinJieHero+= 1;
            jinJieLvArr[index] = jinJieHero.toString();
            //拼接成字符串
            String newQiangHuaStr = "";
            for (int i = 0; i < jinJieLvArr.length; i++) {
                if(i<jinJieLvArr.length-1)
                {
                    newQiangHuaStr += jinJieLvArr[i]+";";
                }
                else
                {
                    newQiangHuaStr += jinJieLvArr[i];
                }

            }

            //扣除金币
            ETPublic etPublic = new ETPublic();
            etPublic.reduceGold(serverID,playerTag,callNeedGold);

            //扣除道具
            etPublic.reduceItemUntime(serverID,playerTag,itemID,itemNumber);

            return update(tableName,"jinjieLv",newQiangHuaStr,"1","playerTag",playerTag);
        }
        return  false;
    }


    //获取进阶需要的道具数量
    public int getJinJieNeedItemNumber(int jinJieLv)
    {
        //公式是 需要的道具数量为 进阶等级+1
        return  jinJieLv+1;
    }

    //获取进阶需要的金币数
    public int getJinJieNeedGold(int jinJieLv,int heroCallLv)
    {
        jinJieLv += 1;
        return 100*jinJieLv*jinJieLv*heroCallLv*heroCallLv;
    }


}
