package game.net.datapackage.maoXian;

import base.net.websocket.CHCManager;
import game.mysql.entity.hero.ETHeroView;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/11/1 0001.
 */
public class DPMaoXianDuiLie implements DataPackage {
    private  ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        ETHeroView etHeroView = new ETHeroView();
        String called = etHeroView.searchcalled(playerTag,serverID);


        JSONObject jb = new JSONObject();

        jb.put("head", GHeadVar.SC_OPEN_MAOXIAN);
        jb.put("calledInfo",called);
        jb.put("qiangHuaLv",etHeroView.getQiangHuaLv());
        jb.put("jinjieLv",etHeroView.getJinJieLv());
        jb.put("exp",etHeroView.getExp());
        jb.put("lv",etHeroView.getLv());
        jb.put("xiuYangTime",etHeroView.getXiuYangTime());
        jb.put("currentTimeMillis",System.currentTimeMillis()/1000);
        jb.put("maoXianInfo",etHeroView.getMaoXianInfo(playerTag,serverID));

        _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));

    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
