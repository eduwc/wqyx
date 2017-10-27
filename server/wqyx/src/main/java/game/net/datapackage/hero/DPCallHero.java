package game.net.datapackage.hero;

import base.net.websocket.CHCManager;
import game.mysql.entity.hero.ETCallHero;
import game.net.datapackage.DPPublic;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/9/28 0028.
 */
public class DPCallHero implements DataPackage {
    private ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        String heroID = (String) dataJson.get("heroID").toString();
        String callType = (String) dataJson.get("callType");

        ETCallHero etCallHero = new ETCallHero();
        int isExecuteState = etCallHero.callHero(callType,heroID,playerTag,serverID);


        DPPublic dpPublic = new DPPublic();
        if (isExecuteState == 1)
        {
            JSONObject jb = new JSONObject();
            //发送角色信息
            jb.put("head", GHeadVar.SC_UPDATE_CALLHERO);
            jb.put("callState",isExecuteState);

            _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
        }
        else if(isExecuteState == 2)
        {
            dpPublic.sendTip(_chc,"金币不足");
        }
        else if(isExecuteState == 3)
        {
            dpPublic.sendTip(_chc,"钻石不足");
        }
        else if(isExecuteState == 4)
        {
            dpPublic.sendTip(_chc,"请先扩容英雄上限");
        }



    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
