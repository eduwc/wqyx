require "global.TransferVar"
--***********网络*****************--

--websocket管理类
--初始化网络
G_WebSocketManager = require ("net.websocket.WebSocketManager"):create()
G_HttpManager	   = require ("net.http.HttpManager"):getInstance()
G_CsvManager	   = require ("data.csv.CsvManager"):getInstance()
G_DataManager	   = require ("data.DataManager"):getInstance()
G_ModulePublic	   = require ("module.public.MPublic"):getInstance()




--****************普通变量*******************----
G_ZHUANJING = {}
G_ZHUANJING["1"] = "剑"
G_ZHUANJING["2"] = "刀"
G_ZHUANJING["3"] = "枪"
G_ZHUANJING["4"] = "法杖"
G_ZHUANJING["5"] = "弓"
G_ZHUANJING["6"] = "斧头"
G_ZHUANJING["7"] = "枪弩"
G_ZHUANJING["8"] = "头盔"
G_ZHUANJING["9"] = "帽子"
G_ZHUANJING["10"] = "长衣"
G_ZHUANJING["11"] = "短衣"
G_ZHUANJING["12"] = "长裤"
G_ZHUANJING["13"] = "短裤"
G_ZHUANJING["14"] = "戒指"
G_ZHUANJING["15"] = "项链"
G_ZHUANJING["16"] = "书"
G_ZHUANJING["17"] = "时装"


--****************内部通信消息*******************----
REQUESTHERO 	= "in_requestHero"
RESPONDHERO 	= "in_respondHero"
IN_PlAYERINFO   = "in_playerInfo"
























