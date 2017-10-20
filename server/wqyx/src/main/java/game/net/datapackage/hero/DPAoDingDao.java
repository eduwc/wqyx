package game.net.datapackage.hero;

import base.net.websocket.CHCManager;
import game.mysql.entity.hero.ETAoDingDao;
import game.net.datapackage.DPPublic;
import game.net.datapackage.DataPackage;
import game.var.global.GHeadVar;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/10/16 0016.
 */
public class DPAoDingDao implements DataPackage {
    private ChannelHandlerContext _chc;
    public void analyData(JSONObject dataJson) {
        String playerTag = CHCManager.getInstance().getPlayerTag(_chc);
        String serverID = CHCManager.getInstance().getServerID(_chc);

        int executeState = 1;
        ETAoDingDao etAoDingDao = new ETAoDingDao();
        DPPublic dpPublic = new DPPublic();

        JSONObject jb = new JSONObject();
        //--1.走访 2.钻石结交  3.十连钻石结交 4.重置
        String jieJiaoType = (String) dataJson.get("jieJiaoType").toString();
        executeState = etAoDingDao.jieJiao(playerTag,serverID,jieJiaoType);
        if(executeState!=1)
        {
            dpPublic.sendUnsatisfyTip(_chc,executeState);
        }
        else
        {
            int needNumber = 1;
            if(jieJiaoType.equals("3"))
            {
                needNumber = 10;
            }
            JSONArray jieJiaoJsonArr = new JSONArray();
            for (int i = 0; i <needNumber ; i++) {
                JSONObject jieJiaoJsonObj = new JSONObject();
                jieJiaoJsonObj.put(etAoDingDao.getItem(),etAoDingDao.getItemNumber());
                jieJiaoJsonArr.put(jieJiaoJsonObj.toString());
            }

            jb.put("head", GHeadVar.SC_UPDATE_AODINGDAO);
            jb.put("jieJiaoResule",jieJiaoJsonArr.toString());
        }

        _chc.writeAndFlush(new TextWebSocketFrame(jb.toString()));
    }

    public void setChannelHandlerContext(ChannelHandlerContext chc) {
        _chc = chc;
    }
}
