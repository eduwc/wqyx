local WAoDingDao = class("WAoDingDao",require "base.view.BaseNode")
WAoDingDao.nodeName				= "WAoDingDao"
WAoDingDao.mAoDingDao 			= nil
WAoDingDao.aoDingDaoWindow 		= nil
WAoDingDao.tt_jieJiaoFreeTime	= nil
WAoDingDao.pl_jieJiaoShow		= nil



-- --必须要实现
function WAoDingDao:init(node,nodeName)
	WAoDingDao.super:init(node,nodeName)
end

function WAoDingDao:ctor()
	--必须要调用
	self:init(self,self.nodeName)
	WAoDingDao.super:ctor()

	-- --可不调用，最好调用
	self.mAoDingDao  = require ("module.hero.MAoDingDao"):create()
	self.mAoDingDao:connectView(self)

	self.aoDingDaoWindow = cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/AoDingDao.csb")
	self:addChild(self.aoDingDaoWindow)


	local  bt_jiejiaoTuJian = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"bt_jiejiaoTuJian")
	bt_jiejiaoTuJian:addTouchEventListener(function(sender, state)
	        if state == 2 then

	        end
	end)	

	local  bt_duihuanyuanfen = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"bt_duihuanyuanfen")
	bt_duihuanyuanfen:addTouchEventListener(function(sender, state)
	        if state == 2 then

	        end
	end)



	local  bt_chongZhiJieJiao = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"bt_chongZhiJieJiao")
	bt_chongZhiJieJiao:addTouchEventListener(function(sender, state)
	        if state == 2 then
				local jsMsg = {}
	            jsMsg["head"] = CS_DPAoDingDao
	            jsMsg["jieJiaoType"] = "4"    --1.走访 2.钻石结交 3.十连钻石结交 4.重置
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)


	local  bt_zouFang = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"bt_zouFang")
	bt_zouFang:addTouchEventListener(function(sender, state)
	        if state == 2 then
				local jsMsg = {}
	            jsMsg["head"] = CS_DPAoDingDao
	            jsMsg["jieJiaoType"] = "1"    --1.走访 2.钻石结交 3.十连钻石结交
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)


	local  bt_jieJiao = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"bt_jieJiao")
	bt_jieJiao:addTouchEventListener(function(sender, state)
	        if state == 2 then
				local jsMsg = {}
	            jsMsg["head"] = CS_DPAoDingDao
	            jsMsg["jieJiaoType"] = "2"    --1.走访 2.钻石结交  3.十连钻石结交
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)


	local  bt_jieJiaoShiLian = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"bt_jieJiaoShiLian")
	bt_jieJiaoShiLian:addTouchEventListener(function(sender, state)
	        if state == 2 then
				local jsMsg = {}
	            jsMsg["head"] = CS_DPAoDingDao
	            jsMsg["jieJiaoType"] = "3"    --1.走访 2.钻石结交 3.十连钻石结交
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)


	self.tt_jieJiaoFreeTime = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"tt_jieJiaoFreeTime")
	self.pl_jieJiaoShow = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"pl_jieJiaoShow")

end


function WAoDingDao:showJieJiaoResult(jieJiaoResule)
	local len = G_ToolsManager:getTableLen(jieJiaoResule)
	self.pl_jieJiaoShow:removeAllChildren()
	local index = 0
	for i,v in ipairs(jieJiaoResule) do
		local jieJiaojson = json.decode(v)
		local itemPropId = 0
		local itemPropNumber = 0
		for k,v in pairs(jieJiaojson) do
			itemPropId = k
			itemPropNumber = v
		end

		local jieJiaoItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_public/smallBgItem.csb")
		self.pl_jieJiaoShow:addChild(jieJiaoItem)
		if len == 1 then
			jieJiaoItem:setPosition(250,100)
		else 
			local xPosition = index*125
			if xPosition>500 then
				local xPosition2 = (index-5)*125
				jieJiaoItem:setPosition(xPosition2,0)
			else
				jieJiaoItem:setPosition(xPosition,170)
			end			
		end
		
		
		local  ig_item = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"ig_item")
		ig_item:loadTexture("icon/item/"..G_CsvManager:getInstance():getItemPicID(itemPropId)..".png")

		local  tt_itemName = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"tt_itemName")
		tt_itemName:setString(G_CsvManager:getInstance():getItemName(itemPropId))

	    local  tt_itemNumber = G_ToolsManager:seekChildByName(self.aoDingDaoWindow,"tt_itemNumber")
	    tt_itemNumber:setString("X"..itemPropNumber)
		index = index+1
	end

end



return WAoDingDao