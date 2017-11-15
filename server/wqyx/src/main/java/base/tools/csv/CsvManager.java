package base.tools.csv;

import base.net.websocket.CHCManager;
import com.csvreader.CsvReader;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/**
 * Created by Administrator on 2017/9/22 0022.
 */
public class CsvManager {
    private static CsvManager _instance = null;
    private HashMap csvMap = new HashMap();
    private HashMap kuoRongInfoMap = new HashMap();

    public static synchronized CsvManager getInstance()
    {
        if(_instance == null)
        {
            _instance = new CsvManager();
        }
        return  _instance;
    }


    //只需要填写相对根目录的路径就好
    public void loadCsv(String path,String csvName)
    {
        String relativelyPath=System.getProperty("user.dir");
        ArrayList headArr = new ArrayList();
        try {
            CsvReader csvReader = new CsvReader(relativelyPath+"\\"+path,',',Charset.forName("UTF-8"));
            try {
                csvReader.readHeaders();
                String headValues = csvReader.getRawRecord();
                String[] arr = headValues.split(",");
                for (int i=0;i<arr.length;i++)
                {
                    headArr.add(arr[i]);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                HashMap readCsv = new HashMap();
                while (csvReader.readRecord()){
                    String[] itemArr = csvReader.getRawRecord().split(",");
                    HashMap _headMap = new HashMap();
                    for (int k=0;k<itemArr.length;k++)
                    {
                        _headMap.put(headArr.get(k),csvReader.get(k));
                    }
                    readCsv.put(csvReader.get(0).toString(),_headMap);
                }
                csvMap.put(csvName,readCsv);
                csvReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }


    public HashMap getCsvMap(String csvName)
    {
        return (HashMap) csvMap.get(csvName);
    }

    //*****************扩容******************

    public void setKuoRongInfo()
    {
        HashMap kuoRongMap = getCsvMap("dilatation_up");

        //扩容类型
        // 1-资源仓库数量 // 2-资源各资源上限  // 3-道具装备数量
        // 4-英雄数量  // 10-锻造栏 //  11-冒险队列

        HashMap ziYaunCang = new HashMap();
        HashMap ziYaun = new HashMap();
        HashMap item = new HashMap();
        HashMap hero = new HashMap();
        HashMap duanZao = new HashMap();
        HashMap maoXian = new HashMap();

        kuoRongInfoMap.put("1",ziYaunCang);
        kuoRongInfoMap.put("2",ziYaun);
        kuoRongInfoMap.put("3",item);
        kuoRongInfoMap.put("4",hero);
        kuoRongInfoMap.put("10",duanZao);
        kuoRongInfoMap.put("11",maoXian);


        Iterator iter = kuoRongMap.entrySet().iterator();
        while (iter.hasNext())
        {
            HashMap.Entry entry = (HashMap.Entry) iter.next();
            HashMap val = (HashMap)entry.getValue();

            HashMap hp = (HashMap)kuoRongInfoMap.get(val.get("dilatation_up_type"));
            hp.put((String)val.get("dilatation_up_level"),val);

        }
    }


    public HashMap getKuoRongInfo(String kuorongLv,String kuoRongType)
    {
        return  (HashMap) ((HashMap)kuoRongInfoMap.get(kuoRongType)).get(kuorongLv);
    }



    //**************************冒险********************************
    public int getMaoXianCd(String maoXianID)
    {
        HashMap riskMap = getCsvMap("risk");
        return  Integer.parseInt((String) ((HashMap)riskMap.get(maoXianID)).get("risk_cd"))  ;
    }

}
