package game.mysql.entity;

/**
 * Created by Administrator on 2017/9/4 0004.
 */
public class ETLogin extends  BaseEntity{
    public boolean queryUserinfo(String username)
    {
        return  isExist("userinfo","username",username);
    }
}
