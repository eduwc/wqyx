package game.net.datapackage.login;

import base.net.websocket.CHCManager;
import game.mysql.entity.login.ETEnterGame;
import game.net.datapackage.DataPackage;
import game.var.global.GErrorVar;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

import java.sql.ResultSet;
import java.util.HashMap;

/**
 * Created by Administrator on 2017/9/20 0020.
 */
public class DPEnterGame implements DataPackage {
    private ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String userName = dataJson.get("userName").toString();
        String serverID = dataJson.get("serverID").toString();

        //保存ChannelHandlerContext,放在这边是因为登录只会响应一次
        CHCManager.getInstance().addCHC(_chc,userName+"-"+serverID);

        ETEnterGame etEnterGame = new ETEnterGame();
        JSONObject jb = new JSONObject();
        if(etEnterGame.queryPlayerInfo(userName))
        {
            HashMap info = etEnterGame.searchPlayerInfo(userName,serverID);

            //发送角色信息
            jb.put("head", GHeadVar.SC_SWITCH_ENTERGAME);
            jb.put("lv",info.get("lv"));
            jb.put("sex",info.get("sex"));
            jb.put("playerName",info.get("playerName"));
            jb.put("headTag",info.get("headTag"));
            jb.put("diamond",info.get("diamond"));
            jb.put("gold",info.get("gold"));
            jb.put("heroKuoRongNumber",info.get("heroKuoRongNumber"));
            jb.put("equipKuoRongNumber",info.get("equipKuoRongNumber"));

        }
        else
        {
            //创建角色信息
            etEnterGame.inserUserInfo(userName,serverID);
            String[] info = etEnterGame.inserPlayerInfo();

            //发送角色数据

            jb.put("head", GHeadVar.SC_SWITCH_ENTERGAME);
            jb.put("lv",1);
            jb.put("sex",2);
            jb.put("playerName",info[0]);
            jb.put("headTag",info[1]);
            jb.put("diamond",0);
            jb.put("gold",0);
            jb.put("heroKuoRongNumber",0);
            jb.put("equipKuoRongNumber",0);


        }
        _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
