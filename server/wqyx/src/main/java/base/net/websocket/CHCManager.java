package base.net.websocket;

import io.netty.channel.ChannelHandlerContext;

import java.util.HashMap;

/**
 * Created by Administrator on 2017/9/22 0022.
 * CHC是ChannelHandlerContext缩写
 */
public class CHCManager {
    private static CHCManager _instance = null;
    private HashMap chcMap = new HashMap();

    public static CHCManager getInstance()
    {
        if(_instance == null)
        {
            _instance = new CHCManager();
        }
        return  _instance;
    }


    public void addCHC(ChannelHandlerContext chc,String playerTag)
    {
        if(!chcMap.containsKey(chc.channel().id()))
        {
            chcMap.put(chc.channel().id(),playerTag);
        }

    }

    public void removeCHC(ChannelHandlerContext chc)
    {
        if(chcMap.containsKey(chc.channel().id()))
        {
            chcMap.remove(chc.channel().id());
        }
    }


    public String getPlayerTag(ChannelHandlerContext chc)
    {
        if(chcMap.containsKey(chc.channel().id()))
        {
            return chcMap.get(chc.channel().id()).toString();
        }
        return "";
    }

    public String getServerID(ChannelHandlerContext chc)
    {
        if(chcMap.containsKey(chc.channel().id()))
        {
            String serverID = ((chcMap.get(chc.channel().id()).toString()).split("-"))[1];
            return serverID;
        }
        return "";
    }


}
