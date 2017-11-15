package game.net.datapackage.maoXian;

import base.net.websocket.CHCManager;
import game.mysql.entity.maoXian.ETMaoXian;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/11/10 0010.
 */
public class DPMaoXian implements DataPackage {
    private  ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        String maoXianID =  (String) dataJson.get("maoXianID");
        String heroList =  (String) dataJson.get("heroList");
        Integer listID = (Integer) dataJson.get("listID");




        ETMaoXian etMaoXian = new ETMaoXian();
        etMaoXian.beginMaoXian(playerTag,serverID,heroList,maoXianID,listID);

        JSONObject jb = new JSONObject();
        jb.put("head", GHeadVar.SC_UPDATE_BEGINMAOXIAN);
        _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));


    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
