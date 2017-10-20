package game.mysql.entity.hero;

import base.tools.time.TimeManager;
import game.mysql.entity.BaseEntity;
import game.mysql.entity.ETPublic;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/16 0016.
 */
public class ETAoDingDao extends BaseEntity {
    //返回 1成功  2.金币不足 3.钻石不足
    public int jieJiao(String playerTag,String serverID,String jieJiaoType)
    {

        int executeState = 1;
        ETPublic etPublic = new ETPublic();

        if(jieJiaoType.equals("1"))
        {
            if(!etPublic.goldIsSatisfy(serverID,playerTag,1000))
            {
                executeState = 2;
            }
            else
            {
                etPublic.reduceGold(serverID,playerTag,1000);
            }
        }
        else if(jieJiaoType.equals("2"))
        {
            Timestamp freeJieJiaoTime = getFreeJieJiaoTime(playerTag,serverID);
            if(!isFreeTime(freeJieJiaoTime))
            {
                if(!etPublic.diamondIsSatisfy(serverID,playerTag,198))
                {
                    executeState = 3;
                }
                else
                {
                    etPublic.reduceDiamond(serverID,playerTag,198);
                }
            }
            else
            {

            }

        }
        else if(jieJiaoType.equals("3"))
        {
            if(!etPublic.diamondIsSatisfy(serverID,playerTag,1688))
            {
                executeState = 3;
            }
            else
            {
                etPublic.reduceDiamond(serverID,playerTag,1688);
            }
        }
        else if(jieJiaoType.equals("4"))
        {
            if(!etPublic.diamondIsSatisfy(serverID,playerTag,10))
            {
                executeState = 3;
            }
            else
            {
                etPublic.reduceDiamond(serverID,playerTag,10);
            }
        }

        return  executeState;
    }


    //获取随机的物品
    public String getItem()
    {
        return  "100";
    }

    //获取随机物品的数目
    public int getItemNumber()
    {
        return 5;
    }



    public Timestamp getFreeJieJiaoTime(String playerTag, String serverID)
    {
        String tbHeroInfo = "hero"+serverID;
        Map heroMap = searchLine("SELECT *FROM "+tbHeroInfo+" WHERE playerTag="+"'"+playerTag+"'");
        Timestamp freeJieJiaoTime = (Timestamp) heroMap.get("freeJieJiaoTime");
        return freeJieJiaoTime;
    }

    //是否在免费时间内
    public boolean isFreeTime(Timestamp freeJieJiaoTime)
    {

        long ragTime = TimeManager.getInstance().gapTime
                (freeJieJiaoTime,new Timestamp(System.currentTimeMillis()));
        if(ragTime>21600)  //21600 6小时转化成秒
        {
            return  true;
        }
        return  false;

    }





}
