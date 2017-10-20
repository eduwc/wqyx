package game.net.datapackage.hero;

import base.net.websocket.CHCManager;
import game.mysql.entity.hero.ETMyHero;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/10/10 0010.
 */
public class DPMyHero implements DataPackage {
    private ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        ETMyHero etMyHero = new ETMyHero();
        String functionType = (String) dataJson.get("functionType");
        String heroID = (String) dataJson.get("heroID");
        if (functionType.equals("qianghua"))
        {
            int state = etMyHero.qiangHua(playerTag,serverID,heroID);

            JSONObject jb = new JSONObject();
            if(state==1)
            {
                jb.put("head", GHeadVar.SC_UPDATE_QIANGHUA);
                jb.put("state",1);
            }
            else if(state==2)
            {
                jb.put("head", GHeadVar.SC_TIP_FLOAT);
                jb.put("tipInfo","道具数量不足");
            }
            else if(state==3)
            {
                jb.put("head", GHeadVar.SC_TIP_FLOAT);
                jb.put("tipInfo","金币数量不足");
            }


            _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));

        }
        else if(functionType.equals("jinjie"))
        {

            int state = etMyHero.jinjie(playerTag,serverID,heroID);

            JSONObject jb = new JSONObject();
            if(state==1)
            {
                jb.put("head", GHeadVar.SC_UPDATE_JINJIE);
                jb.put("state",1);
            }
            else if(state==2)
            {
                jb.put("head", GHeadVar.SC_TIP_FLOAT);
                jb.put("tipInfo","道具数量不足");
            }
            else if(state==3)
            {
                jb.put("head", GHeadVar.SC_TIP_FLOAT);
                jb.put("tipInfo","金币数量不足");
            }


            _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
        }

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
