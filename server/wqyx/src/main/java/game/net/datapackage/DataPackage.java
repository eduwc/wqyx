package game.net.datapackage;

import io.netty.channel.ChannelHandlerContext;
import org.json.JSONObject;

/**
 * Created by Administrator on 2017/9/1 0001.
 */
public interface DataPackage {
    public void analyData(JSONObject dataJson);
    public void setChannelHandlerContext(ChannelHandlerContext chc);
}
