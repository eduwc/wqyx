package base.mysql.connectionpool;

/**
 * Created by Administrator on 2017/8/30 0030.
 */

import com.mchange.v2.c3p0.*;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

public class C3p0PoolManager {

    private  static  C3p0PoolManager _instance = null;

    public  static  C3p0PoolManager getInstance()
    {
        if(_instance ==null)
        {
            try {
                _instance = new C3p0PoolManager();
            } catch (PropertyVetoException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return  _instance;
    }


    private  ComboPooledDataSource dataSources;
    public C3p0PoolManager() throws PropertyVetoException, SQLException {

        //设置读取c3p0-config.xml 位置
        System.setProperty("com.mchange.v2.c3p0.cfg.xml","E:\\projects\\server\\wqyx\\src\\main\\java\\game\\config\\c3p0-config.xml");
        dataSources = new ComboPooledDataSource("mysql");

    }


    public Connection getConnection()
    {
        try {
            return  dataSources.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  null;
    }
}
