package game.net.datapackage.hero;

import base.net.websocket.CHCManager;
import game.mysql.entity.ETPublic;
import game.mysql.entity.hero.ETHeroHuoRong;
import game.net.datapackage.DPPublic;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import game.var.global.GPublicVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/10/26 0026.
 */
public class DPHeroKuoRong implements DataPackage {
    private ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        ETPublic etPublic = new ETPublic();
        ETHeroHuoRong etHeroKuoRong = new ETHeroHuoRong();
        int state  = etHeroKuoRong.heroKuoRong(playerTag,serverID);

        if(state != 1)
        {
            DPPublic dpPublic = new DPPublic();
            dpPublic.sendUnsatisfyTip(_chc,state);
        }
        else
        {
            JSONObject jb = new JSONObject();
            jb.put("head", GHeadVar.SC_UPDATE_HEROKUORONG);
            jb.put("state",1);
            jb.put("heroMaxKuoRong",etPublic.getMaxKuoRongNumber(playerTag,serverID, GPublicVar.KUORONG_HERO));
            _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
        }






    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
