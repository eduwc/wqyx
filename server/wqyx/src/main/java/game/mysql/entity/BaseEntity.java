package game.mysql.entity;

import base.mysql.connectionpool.C3p0PoolManager;
import com.mysql.jdbc.ResultSetMetaData;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/9/1 0001.
 */
public class BaseEntity {
    /**
     *
     * @param tableName  表名
     * @param args       插入的值，不定个数
     * @return
     */
    public boolean insert(String tableName ,String ...args)
    {
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            int argsLen = args.length;
            String sql = "INSERT INTO "+tableName+" VALUES(";
            for (int i=0;i<args.length;i++)
            {

                if(i==argsLen-1)
                {
                    if(args[i].equals("null"))
                    {
                        sql += args[i];
                    }
                    else
                    {
                        sql += "'"+args[i]+"'";
                    }

                }
                else
                {
                    if(args[i].equals("null"))
                    {
                        sql += args[i]+",";
                    }
                    else
                    {
                        sql += "'"+args[i]+"'"+",";
                    }

                }
            }
            sql+=")";
            stmt.execute(sql);
            stmt.close();
            cc.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  true;
    }



    public void insert(String sql)
    {
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            stmt.execute(sql);
            stmt.close();
            cc.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    /**
     *
     * @param tableName  表名
     * @param condition  查询字段名字
     * @param args       查询值
     * @return
     */
    public boolean isExist(String tableName , String condition,String ...args)
    {
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        boolean dataExist = false;
        try {
            Statement stmt =  cc.createStatement();
            int argsLen = args.length;
            String sql = "SELECT *FROM "+tableName+" WHERE "+condition+"="+"'"+args[0]+"'";
            ResultSet resultSet = stmt.executeQuery(sql);
            if(resultSet.next())
            {
                dataExist = true;
            }
            resultSet.close();
            stmt.close();
            cc.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataExist;
    }


    public List search(String sql)
    {
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            ResultSet resultSet = stmt.executeQuery(sql);
            java.sql.ResultSetMetaData rsmd = resultSet.getMetaData();
            int numberOfColumns = rsmd.getColumnCount();
            List list = new ArrayList();
            while(resultSet.next()){

                Map rsTree = new HashMap(numberOfColumns);
                for(int r=1;r<numberOfColumns+1;r++)
                {
                    rsTree.put(rsmd.getColumnName(r),resultSet.getObject(r));
                }
                list.add(rsTree);
            }
            resultSet.close();
            stmt.close();
            cc.close();
            return  list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    //只搜索一行的数据
    public Map searchLine(String sql)
    {
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            ResultSet resultSet = stmt.executeQuery(sql);
            java.sql.ResultSetMetaData rsmd = resultSet.getMetaData();
            int numberOfColumns = rsmd.getColumnCount();
            Map rsTree = new HashMap(numberOfColumns);
            while(resultSet.next()){
                for(int r=1;r<numberOfColumns+1;r++)
                {
                    rsTree.put(rsmd.getColumnName(r),resultSet.getObject(r));
                }
            }
            resultSet.close();
            stmt.close();
            cc.close();
            return  rsTree;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    //只适用于更新一个字段的时候
    //valueType 1是插入 字符串类型的value 2是插入int类型的value

    public boolean update(String tableName ,String field ,String value,String valueType,String condition,String conditionValue)
    {
        boolean isExecuteSucceed = false;
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            String sql = "";
            if(valueType.equals("1"))
            {
                   sql = "UPDATE "+tableName+" SET "+field+"="+"'"+value+"'"+
                    " WHERE "+condition+"="+"'"+conditionValue+"'";
            }
            else
            {
                    sql = "UPDATE "+tableName+" SET "+field+"="+value+
                        " WHERE "+condition+"="+"'"+conditionValue+"'";
            }


            int lineNumber = stmt.executeUpdate(sql);
            if (lineNumber>0)
            {
                isExecuteSucceed = true;
            }
            stmt.close();
            cc.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return  isExecuteSucceed;
    }

    public boolean update(String sql)
    {
        Connection cc =  C3p0PoolManager.getInstance().getConnection();
        try {
            Statement stmt =  cc.createStatement();
            stmt.executeUpdate(sql);
            stmt.close();
            cc.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return  true;
    }

}
