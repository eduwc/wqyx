package game.net.datapackage;

import game.mysql.entity.ETRegister;
import game.var.global.GErrorVar;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/9/4 0004.
 */
public class DPLogin implements DataPackage{
    private  ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String userName = dataJson.get("userName").toString();
        String passWord = dataJson.get("passWord").toString();

        ETRegister et_Register = new ETRegister();
        JSONObject jb = new JSONObject();
        if(et_Register.queryUserinfo(userName))
        {
            //发送登录 成功数据
          /*  jb.put("head", GHeadVar.GH_SC_LOGIN);
            jb.put("loginState", 1);*/
        }
        else {
          //  jb.put("head", GHeadVar.GH_SC_ERROR);
         //   jb.put("error",GErrorVar.GE_SC_ACCOUNTNONENTITY);
          //  _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));

        }

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
