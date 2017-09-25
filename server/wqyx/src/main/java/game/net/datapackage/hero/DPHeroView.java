package game.net.datapackage.hero;

import base.net.websocket.CHCManager;
import game.mysql.entity.hero.ETHeroView;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/9/22 0022.
 */
public class DPHeroView implements DataPackage {
    private ChannelHandlerContext _chc;

    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);


        ETHeroView etHeroView = new ETHeroView();
        String uncalled = etHeroView.searchUncalled(playerTag,serverID);

        JSONObject jb = new JSONObject();
        //发送角色信息
        jb.put("head", GHeadVar.SC_OPEN_HERO);
        jb.put("uncalledInfo",uncalled);

        _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
