package game.mysql.entity;

import game.mysql.entity.BaseEntity;

/**
 * Created by Administrator on 2017/9/28 0028.
 */
public class ETPublic extends BaseEntity {
    public void reduceGold(String tableName,String playerTag,int reduceGold)
    {
        String reduceSql = "gold"+"-"+reduceGold;
        update(tableName,"gold",reduceSql,"2","playerTag",playerTag);
    }

    public void addGold(String tableName,String playerTag,int addGold)
    {
        String reduceSql = "gold"+"+"+addGold;
        update(tableName,"gold",reduceSql,"2","playerTag",playerTag);
    }

    public void reduceDiamond(String tableName,String playerTag,int reduceDiamond)
    {
        String reduceSql = "diamond"+"-"+reduceDiamond;
        update(tableName,"diamond",reduceSql,"2","playerTag",playerTag);
    }

    public void addDiamond(String tableName,String playerTag,int addDiamond)
    {
        String reduceSql = "diamond"+"+"+addDiamond;
        update(tableName,"diamond",reduceSql,"2","playerTag",playerTag);
    }
}
