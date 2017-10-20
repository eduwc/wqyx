package game.mysql.entity.item;

import game.mysql.entity.BaseEntity;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/10/17 0017.
 */
public class ETItem extends BaseEntity {

    //打开装备界面
    public JSONArray openEquip(String playerTag,String serverID)
    {
        //equipType类型
        //0全部，1-剑 2-刀 3-枪 4-法杖 5-弓 6-火枪 7-斧头 8-头盔 9-帽子 10-长衣 11-短衣 12-长靴 13-短靴
        //14-戒指 15-项链 16-宝物 17-时装

        JSONArray equipInfo  = new JSONArray();

        JSONArray[] jsonArr = new JSONArray[18];

        for (int i = 0; i <jsonArr.length ; i++) {
            jsonArr[i] = new JSONArray();
        }



        String tableName = "equip"+serverID;
        String searchSql = "SELECT *FROM "+tableName+" WHERE playerTag="+"'"+playerTag+"'";
        List equipList = search(searchSql);
        for(int i = 0 ; i < equipList.size() ; i++) {
            Integer equipType = (Integer) ((HashMap)equipList.get(i)).get("equipType");
            Long equipNumber = (Long) ((HashMap)equipList.get(i)).get("equipNumber");
            String equipId = (String) ((HashMap)equipList.get(i)).get("equipId");

            jsonArr[equipType].put(addItemJson(equipType,equipNumber,equipId).toString());
            jsonArr[0].put(addItemJson(equipType,equipNumber,equipId).toString());

        }

        for (int i = 0; i < jsonArr.length; i++) {
            equipInfo.put(jsonArr[i]);
        }

        return  equipInfo;

    }


    private JSONObject addItemJson(Integer equipType,Long equipNumber,String equipId)
    {
        JSONObject itemJson = new JSONObject();
        itemJson.put("equipType",equipType);
        itemJson.put("equipNumber",equipNumber);
        itemJson.put("equipId",equipId);
        return itemJson;
    }
}
