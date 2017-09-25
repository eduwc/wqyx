package game.var.global;

/**
 * Created by Administrator on 2017/9/4 0004.
 * 头消息
 */
public class GHeadVar {

    //SC_SWITCH_REGISTER S代表Server,C代表Client SC从服务端发送到客户端消息,CS从客户端发送到服务端消息
   // 规则 1.OPEN_开启新窗口 2.TIP_显示提示信息 3.UPDATE_更新数据 4.SWITCH_切换场景 5.ERROR_错误消息

    //错误消息
    public static String GH_SC_ERROR = "SC_ERROR";


    //**********************注册和登录**************************//

    //注册账号
    public static String GH_SC_SWITCH_REGISTER = "SC_SWITCH_REGISTER";

    //登录
    public static String GH_SC_LOGIN = "SC_SWITCH_LOGIN";


    //**********************进入游戏**************************//
    public static String SC_SWITCH_ENTERGAME = "SC_SWITCH_ENTERGAME";

    //**********************英雄**************************//
    public static String SC_OPEN_HERO = "SC_OPEN_HERO";  //打开英雄界面


}
