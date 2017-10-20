package game.net.datapackage.item;

import base.net.websocket.CHCManager;
import game.mysql.entity.item.ETItem;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/10/17 0017.
 */
public class DPItem implements DataPackage {
    private  ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        ETItem etEquip = new ETItem();
        JSONArray equipJson = etEquip.openEquip(playerTag,serverID);


        JSONObject jb = new JSONObject();
        //发送角色信息
        jb.put("head", GHeadVar.SC_OPEN_ITEM);
        jb.put("equipInfo",equipJson);

        _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
