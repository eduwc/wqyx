package game.timer;

import game.mysql.entity.ETPublic;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by Administrator on 2017/11/3 0003.
 */
public class TimingManager {
    private final ConcurrentHashMap xiuYangMap = new ConcurrentHashMap();
    final ETPublic etPublic = new ETPublic();
    String serverID = "";

    public TimingManager(String _serverID)
    {
        serverID = _serverID;
        startXiuYangTiming();
    }

    //删除倒计时完成的修养
    public void deleteXiuYangItem(String _playerTag,String _serverID,String _heroID)
    {
        ConcurrentHashMap xiuYangMap2 = (ConcurrentHashMap)xiuYangMap.get(_playerTag);
        xiuYangMap2.put(_heroID,100);
    }


    private  void startXiuYangTiming()
    {
        //从数据库 获取需要倒计时的内容
        List heroListInfo = etPublic.getAllHeroInfo(serverID);

        ConcurrentHashMap _xiuYangMap = null;
        for(int i = 0 ; i < heroListInfo.size() ; i++) {
            _xiuYangMap = new ConcurrentHashMap();

            String recruitedStr = (String) (((HashMap)heroListInfo.get(i)).get("recruited"));
            String[] recruitedArr = recruitedStr.split(";");


            String xiuYangTime = (String) (((HashMap)heroListInfo.get(i)).get("xiuYangTime"));
            String xiuYangArr[] = xiuYangTime.split(";");

            String playerTag = (String) (((HashMap)heroListInfo.get(i)).get("playerTag"));

            for(int k = 0 ; k < recruitedArr.length ; k++) {
                _xiuYangMap.put(recruitedArr[k], Integer.parseInt( xiuYangArr[k]));
            }
            xiuYangMap.put(playerTag,_xiuYangMap);
        }


        //开启修养定时系统
        TimerTask xiuYangTask = new TimerTask() {
            Iterator iter = xiuYangMap.entrySet().iterator();
            ConcurrentHashMap _xiuYangMap = null;
            Iterator xiuYangMapiter = null;
            @Override
            public void run() {
                while (iter.hasNext()) {
                    Map.Entry entry = (Map.Entry) iter.next();

                    _xiuYangMap = (ConcurrentHashMap)entry.getValue();
                    xiuYangMapiter = _xiuYangMap.entrySet().iterator();

                    while (xiuYangMapiter.hasNext())
                    {
                        Map.Entry _entry = (Map.Entry) xiuYangMapiter.next();
                        if((Integer)_entry.getValue() > 0 || (Integer)_entry.getValue() < 0)
                        {
                            _entry.setValue((Integer)_entry.getValue()-1);
                            System.out.println("输出"+(Integer)_entry.getValue());
                        }
                        else if((Integer)_entry.getValue() == 0)
                        {
                            //写入数据库
                            _entry.setValue((Integer)_entry.getValue()-1);
                            System.out.println("输出"+(Integer)_entry.getValue());
                        }
                    }
                }
                iter = xiuYangMap.entrySet().iterator();
            }
        };
        Timer timerXiuYang = new Timer();
        timerXiuYang.scheduleAtFixedRate(xiuYangTask, 0, 1000);
    }
}
