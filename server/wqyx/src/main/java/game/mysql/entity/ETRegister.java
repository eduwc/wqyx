package game.mysql.entity;

import base.mysql.connectionpool.C3p0PoolManager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Administrator on 2017/9/1 0001.
 */
public class ETRegister extends  BaseEntity{

    public boolean queryUserinfo(String username)
    {
        return  isExist("userinfo","username",username);
    }

}
