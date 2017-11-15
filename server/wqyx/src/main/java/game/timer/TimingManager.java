package game.timer;

import base.tools.csv.CsvManager;
import game.mysql.entity.ETPublic;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by Administrator on 2017/11/3 0003.
 */
public class TimingManager {
    private static TimingManager _instance = null;
    private final ConcurrentHashMap xiuYangMap = new ConcurrentHashMap();
    final ETPublic etPublic = new ETPublic();
    String serverID = "";

    public static synchronized TimingManager getInstance()
    {
        if(_instance == null)
        {
            _instance = new TimingManager();
        }
        return  _instance;
    }


    public TimingManager()
    {
        //TODO serverID需要配置到配置表
        serverID = "1";
      //  startXiuYangTiming();
        startMaoXian();
    }


    //删除倒计时完成的修养
    public void deleteXiuYangItem(String _playerTag,String _heroID)
    {
        ConcurrentHashMap _xiuYangMap = (ConcurrentHashMap)xiuYangMap.get(_playerTag);
        _xiuYangMap.put(_heroID,0);
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
                        if((Integer)_entry.getValue() > 0)
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


    //*************************冒险****************************//

    private ConcurrentHashMap maoXianCDMap = new ConcurrentHashMap();
    private ConcurrentHashMap maoXianCDItemMap = new ConcurrentHashMap();
    private void startMaoXian()
    {
        TimerTask maoXianTask = new TimerTask() {
            Iterator iter = maoXianCDMap.entrySet().iterator();
            ConcurrentHashMap _maoXianMap = null;
            Iterator maoXianCDiter = null;
            public void run() {
                while (iter.hasNext()) {
                    Map.Entry entry = (Map.Entry) iter.next();

                    _maoXianMap = (ConcurrentHashMap)entry.getValue();
                    maoXianCDiter = _maoXianMap.entrySet().iterator();
                    while (maoXianCDiter.hasNext())
                    {
                        Map.Entry _entry = (Map.Entry) maoXianCDiter.next();
                        int endTime = (Integer)_entry.getValue()-1;
                        _entry.setValue(endTime);
                        System.out.println("冒险倒计时"+(Integer)_entry.getValue());
                        if(endTime<=0)
                        {
                            maoXianCDiter.remove();
                        }
                    }
                }
                iter = maoXianCDMap.entrySet().iterator();
            }
        };


        Timer timerMaoXian = new Timer();
        timerMaoXian.scheduleAtFixedRate(maoXianTask, 0, 1000);
    }

    /**
     *
     * @param playerTag
     * @param maoXianIndex  冒险队列序号
     */
    public void insertMaoXianCd(String playerTag,String maoXianIndex,Integer cdTime)
    {
        maoXianCDItemMap.put(maoXianIndex,cdTime);
        if (maoXianCDMap.get(playerTag) == null)
        {
            maoXianCDMap.put(playerTag,maoXianCDItemMap);
        }

    }
}
