package game.net.datapackage;

import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/9/29 0029.
 */
public class DPPublic implements DataPackage {

    public void sendTip(ChannelHandlerContext chc,String tipInfo)
    {
        JSONObject jb = new JSONObject();
        //发送角色信息
        jb.put("head", GHeadVar.SC_TIP_FLOAT);
        jb.put("tipInfo",tipInfo);

        chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
    }


    public void sendUnsatisfyTip(ChannelHandlerContext chc,int executeState)
    {
        if(executeState==2)
        {
            sendTip(chc,"金币数量不足");
        }
        else if(executeState==3)
        {
            sendTip(chc,"钻石数量不足");
        }
    }


    public void analyData(JSONObject dataJson) {

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {

    }
}
