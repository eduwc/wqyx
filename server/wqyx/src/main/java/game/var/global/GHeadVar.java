package game.var.global;

/**
 * Created by Administrator on 2017/9/4 0004.
 * 头消息
 */
public class GHeadVar {

    //SC_SWITCH_REGISTER S代表Server,C代表Client SC从服务端发送到客户端消息,CS从客户端发送到服务端消息
   // 规则 1.OPEN_开启新窗口 2.TIP_显示提示信息 3.UPDATE_更新数据 4.SWITCH_切换场景 5.ERROR_错误消息


    //**********************提示**************************//

    public static String SC_TIP_FLOAT           = "SC_TIP_FLOAT";  //漂浮提示

    //**********************进入游戏**************************//
    public static String SC_SWITCH_ENTERGAME    = "SC_SWITCH_ENTERGAME";

    //**********************英雄**************************//
    public static String SC_OPEN_HERO = "SC_OPEN_HERO";  //打开英雄界面
    public static String SC_UPDATE_CALLHERO         = "SC_UPDATE_CALLHERO";     //召唤英雄
    public static String SC_UPDATE_QIANGHUA         = "SC_UPDATE_QIANGHUA";     //强化英雄
    public static String SC_UPDATE_JINJIE           = "SC_UPDATE_JINJIE";       //进阶英雄
    public static String SC_UPDATE_AODINGDAO        = "SC_UPDATE_AODINGDAO";    //奥丁岛
    public static String SC_UPDATE_HEROKUORONG      = "SC_UPDATE_HEROKUORONG";  //英雄扩容

    //**********************道具**************************//
    public static String SC_OPEN_ITEM = "SC_OPEN_ITEM";  //打开道具界面


}
