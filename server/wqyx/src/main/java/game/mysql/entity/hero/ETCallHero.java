package game.mysql.entity.hero;

import base.tools.csv.CsvManager;
import game.mysql.entity.BaseEntity;
import game.mysql.entity.ETPublic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/9/28 0028.
 */
public class ETCallHero extends BaseEntity {
    //返回 1成功  2.金币不足 3.钻石不足
    public int callHero(String callType,String heroID,String playerTag,String serverID)
    {
        int isExecuteState = 0;
        ETPublic etPublic = new ETPublic();

        //获取金币和钻石
        String tbPlayerInfo = "playerInfo"+serverID;
        Map playerMap = searchLine("SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+playerTag+"'");
        Integer diamond = (Integer) playerMap.get("diamond");
        Long gold = (Long) playerMap.get("gold");

        //获取召唤需要的钻石和金币数
        HashMap heroMap = (HashMap)(CsvManager.getInstance().getCsvMap("hero").get(heroID));
        Integer callNeedGold = Integer.parseInt((String) heroMap.get("recruit_need_gold"));
        Integer callNeedDiamond = Integer.parseInt((String) heroMap.get("recruit_need_gemstone"));


        String tbHeroInfo = "hero"+serverID;
        String sql = "SELECT *FROM "+tbHeroInfo+" WHERE playerTag="+"'"+playerTag+"'";
        List ls = search(sql);
        String recruited = "";
        String heroLv = "";
        String qiangHuaLv = "";
        String jinjieLv = "";
        if(!ls.isEmpty())
        {
            recruited = (String) ((HashMap)ls.get(0)).get("recruited");
            heroLv = (String) ((HashMap)ls.get(0)).get("lv");
            qiangHuaLv = (String) ((HashMap)ls.get(0)).get("qiangHuaLv");
            jinjieLv = (String) ((HashMap)ls.get(0)).get("jinjieLv");

            String[] recruitedArr = recruited.split(";");
            //判断这个英雄有没被插入过
            boolean isExistHero = false;
            for (int i = 0; i < recruitedArr.length; i++) {
                if(heroID==recruitedArr[i])
                {
                    isExistHero = true;
                    break;
                }
            }
            if(!isExistHero)
            {

                //金币购买
                if(callType.equals("1"))
                {
                    if(gold>=callNeedGold)
                    {
                        recruited = recruited+";"+heroID;
                        heroLv = heroLv+";"+1;
                        qiangHuaLv = qiangHuaLv+";"+0;
                        jinjieLv = jinjieLv+";"+0;

                        String updateSql = "UPDATE "+tbHeroInfo+" SET "+"recruited="+
                                "'"+recruited+"'"+","+"lv="+"'"+heroLv+"'"+","+
                                "qiangHuaLv="+"'"+qiangHuaLv+"'"+","+"jinjieLv="+
                                "'"+jinjieLv+"'"+" WHERE playerTag="+"'"+playerTag+"'";
                        if(update(updateSql))
                        {
                            etPublic.reduceGold(serverID,playerTag,callNeedGold);
                            isExecuteState = 1;
                        }
                    }
                    else {
                        isExecuteState = 2;
                    }
                }
                else
                {
                    if(diamond>=callNeedDiamond)
                    {
                        recruited = recruited+";"+heroID;
                        heroLv = heroLv+";"+1;
                        qiangHuaLv = qiangHuaLv+";"+0;
                        jinjieLv = jinjieLv+";"+0;
                        String updateSql = "UPDATE "+tbHeroInfo+" SET "+"recruited="+
                                "'"+recruited+"'"+","+"lv="+"'"+heroLv+"'"+","+
                                "qiangHuaLv="+"'"+qiangHuaLv+"'"+","+"jinjieLv="+
                                "'"+jinjieLv+"'"+" WHERE playerTag="+"'"+playerTag+"'";
                        if(update(updateSql))
                        {
                            etPublic.reduceDiamond(serverID,playerTag,callNeedDiamond);
                            isExecuteState = 1;
                        }
                    }
                    else {
                        isExecuteState = 3;
                    }
                }

            }
            else
            {

            }
        }
        else
        {
            //金币购买
            if(callType.equals("1"))
            {
                if(gold>=callNeedGold)
                {
                    if(insert(tbHeroInfo,"null",playerTag,heroID,"1","0","0"))
                    {
                        etPublic.reduceGold(serverID,playerTag,callNeedGold);
                        isExecuteState = 1;
                    }
                }
                else
                {
                    isExecuteState = 2;
                }
            }
            else
            {
                if(diamond>=callNeedDiamond)
                {
                    if(insert(tbHeroInfo,"null",playerTag,heroID,"1","0","0"))
                    {
                        etPublic.reduceDiamond(serverID,playerTag,callNeedDiamond);
                        isExecuteState = 1;
                    }
                }
                else {
                    isExecuteState = 3;
                }
            }

        }

        return  isExecuteState;
    }
}
