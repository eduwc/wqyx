package game.mysql.entity.login;

import game.mysql.entity.BaseEntity;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import static java.awt.SystemColor.info;

/**
 * Created by Administrator on 2017/9/20 0020.
 */
public class ETEnterGame extends BaseEntity {
    private String tbUserInfo = "userInfo";
    private String tag = "";
    private String serverID = "";
    public boolean queryPlayerInfo(String username)
    {
        return  isExist(tbUserInfo,"username",username);
    }


    public String[] inserPlayerInfo()
    {
        String tbPlayerInfo = "playerInfo"+serverID;
        //生成玩家名字昵称格式为DG111111，其中DG为随机2个大写英文字母，111111为6位不重复的数字
        String playerName = "DG"+123456;
        String headTag = "1";

        insert(tbPlayerInfo,"null",tag,"1","2",playerName,headTag);

        String[] info = {playerName,headTag};
        return info;


    }

    public void inserUserInfo(String userName,String _serverID)
    {
        //生成唯一标识
        serverID = _serverID;
        tag = userName+"-"+serverID;
        insert(tbUserInfo,"null",userName,tag);
    }

    public HashMap searchPlayerInfo(String userName, String _serverID)
    {
        String[] rstArr = new String[4];
        String tbPlayerInfo = "playerInfo"+_serverID;
        tag = userName+"-"+_serverID;
        String sql = "SELECT *FROM "+tbPlayerInfo+" WHERE playerTag="+"'"+tag+"'";
        List st = search(sql);
        HashMap hp = null;
        for(Object attribute : st) {
            hp = (HashMap) attribute;
        }

        return hp;
    }

}
