package base.file.configuration;

import java.io.*;
import java.util.Iterator;
import java.util.Properties;

/**
 * Created by Administrator on 2017/8/29 0029.
 */
public class ConfigurationManager {
    private static ConfigurationManager instance;


    public static ConfigurationManager getInstance() {
        if (instance == null)
        {
         instance = new ConfigurationManager();
        }

        return instance;
    }

    public boolean writeCMFile(String fileName,Properties prop, boolean isaddTo)
    {
        FileOutputStream oFile;
        try {
            if (isaddTo)
            {
                oFile = new FileOutputStream(fileName+".properties", true);//true表示追加打开
            }
            else
            {
                oFile = new FileOutputStream(fileName+".properties", false);//true表示追加打开
            }
            prop.store(oFile, "config file");
            oFile.close();
            return  true;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return  false;


    }


    public Properties readCMFile(String fileName) throws IOException {

        Properties prop = new Properties();
        FileInputStream fis = new FileInputStream(fileName+".properties");//属性文件流
        prop.load(fis);     ///加载属性列表
        fis.close();

        return  prop;
    }

}
