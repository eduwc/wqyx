package game.net.datapackage;

import game.mysql.entity.ETRegister;
import game.var.global.GErrorVar;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/9/1 0001.
 */
public class DPRegister implements DataPackage{
    private  ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String userName = dataJson.get("userName").toString();
        String passWord = dataJson.get("passWord").toString();



        ETRegister et_Register = new ETRegister();
        JSONObject jb = new JSONObject();
        if(et_Register.queryUserinfo(userName))
        {
          //  jb.put("head", GHeadVar.GH_SC_ERROR);
         //   jb.put("error",GErrorVar.GE_SC_HAVEACCOUNT);
           // _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
        }
        else {
            if(et_Register.insert("userinfo",userName,passWord,"null"))
            {
                //发送注册成功消息
          //      jb.put("head", GHeadVar.GH_SC_SWITCH_REGISTER);
           //     jb.put("registState",1);
           //     _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
            };

        }

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
