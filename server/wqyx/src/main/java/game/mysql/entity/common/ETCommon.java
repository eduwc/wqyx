package game.mysql.entity.common;

import game.mysql.entity.BaseEntity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/10 0010.
 */
public class ETCommon extends BaseEntity {
    static  ETCommon _instance = null;

    static public ETCommon getInstance()
    {
        if(_instance == null)
        {
            _instance = new ETCommon();

        }
        return  _instance;
    }





}
