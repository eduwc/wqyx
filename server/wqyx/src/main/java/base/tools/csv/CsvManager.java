package base.tools.csv;

import base.net.websocket.CHCManager;
import com.csvreader.CsvReader;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Administrator on 2017/9/22 0022.
 */
public class CsvManager {
    private static CsvManager _instance = null;
    private HashMap csvMap = new HashMap();

    public static CsvManager getInstance()
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
            CsvReader csvReader = new CsvReader(relativelyPath+"\\"+path);
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


}
