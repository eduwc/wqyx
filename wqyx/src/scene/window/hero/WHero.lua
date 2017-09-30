local WHero = class("WHero",require "base.view.BaseNode")
WHero.nodeName				= "WHero"
WHero.mhero					= nil
WHero.sv_callHero			= nil
WHero.pl_heroInfo			= nil
WHero.nowCallHeroID			= nil
WHero.unCallHeroItem		= {}

WHero.wMyHero 				= nil
WHero.wAodingDao 			= nil
WHero.bt_aodingdao			= nil
WHero.bt_callHero			= nil
WHero.bt_myHero				= nil

-- --必须要实现
function WHero:init(node,nodeName)
	WHero.super:init(node,nodeName)
end

function WHero:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	WHero.super:ctor()

	--可不调用，最好调用
	self.mhero  = require ("module.hero.MHero"):create()
	self.mhero:connectView(self)


	--初始化我的英雄界面
	self.wMyHero = require("scene.window.hero.WMyHero"):create()
	self.wMyHero:setVisible(false)
	
	--初始化奥丁岛界面	
	self.wAodingDao = require("scene.window.hero.WAoDingDao"):create()
	self.wAodingDao:setVisible(false)	

	self.callHeroWindow = cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/CallHero.csb")
	self:addChild(self.callHeroWindow)	


	self.pl_heroInfo = G_ToolsManager:seekChildByName(self.callHeroWindow,"pl_heroInfo")
	self.pl_heroInfo:addChild(self.wMyHero)
	self.pl_heroInfo:addChild(self.wAodingDao)

	self.sv_callHero = G_ToolsManager:seekChildByName(self.callHeroWindow,"sv_callHero")

	self.bt_callHero = G_ToolsManager:seekChildByName(self.callHeroWindow,"bt_callHero")
	self.bt_callHero:addTouchEventListener(function(sender, state)
	        if state == 2 then
		      self:changePage(1)
	        end
	    end)		

	self.bt_myHero = G_ToolsManager:seekChildByName(self.callHeroWindow,"bt_myHero")
	self.bt_myHero:addTouchEventListener(function(sender, state)
	        if state == 2 then
		      self:changePage(2)
	        end
	    end)	
	
	self.bt_aodingdao = G_ToolsManager:seekChildByName(self.callHeroWindow,"bt_aodingdao")
	self.bt_aodingdao:addTouchEventListener(function(sender, state)
	        if state == 2 then
		      self:changePage(3)
	        end
	    end)

	local bt_returnHero = G_ToolsManager:seekChildByName(self.callHeroWindow,"bt_returnHero")
	bt_returnHero:addTouchEventListener(function(sender, state)
	        if state == 2 then
		       self:removeFromParent()
	        end
	    end)

end


function WHero:showItem(uncallList,callList)
	local uncallListLen = self.mhero:getTableLen(uncallList)
	local callListLen = self.mhero:getTableLen(callList)
	local scrollviewHeight = (uncallListLen+callListLen)*380
	self.sv_callHero:setInnerContainerSize(cc.size(640,scrollviewHeight))

	local index  = 0
	for k,heroInfo in pairs(uncallList) do
		local uncallItem = 	cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/CallHeroItem.csb")
		uncallItem:setPosition(0,scrollviewHeight-(index*380))
		self.sv_callHero:addChild(uncallItem)
		--存储起来 方便更新数据
		self.unCallHeroItem[k] = uncallItem

		local ig_heroHead = G_ToolsManager:seekChildByName(uncallItem,"ig_heroHead")
		ig_heroHead:loadTexture("icon/hero/"..heroInfo["hero_img1"]..".png")

		local tt_heroName = G_ToolsManager:seekChildByName(uncallItem,"tt_heroName")
		tt_heroName:setString(heroInfo["hero_name"])

		local tt_heroTitle = G_ToolsManager:seekChildByName(uncallItem,"tt_heroTitle")
		tt_heroTitle:setString(heroInfo["hero_title"])


		local tt_zhuanjing = G_ToolsManager:seekChildByName(uncallItem,"tt_zhuanjing")
		local zhuanjinText = G_DataManager:zhuanjinText(heroInfo["hero_master"],2)		
		tt_zhuanjing:setString("专精:"..zhuanjinText)	

		local tt_jingtong = G_ToolsManager:seekChildByName(uncallItem,"tt_jingtong")
		tt_jingtong:setString("精通:"..zhuanjinText)	

		local tt_skill = G_ToolsManager:seekChildByName(uncallItem,"tt_skill")
		tt_skill:setString("技能:")	


		local tt_introduce = G_ToolsManager:seekChildByName(uncallItem,"tt_introduce")
		tt_introduce:setString("介绍:"..heroInfo["hero_explain"])


		local tt_callCondition = G_ToolsManager:seekChildByName(uncallItem,"tt_callCondition")
		tt_callCondition:setString("招募条件:".."君主等级 "..heroInfo["recruit_level"]..","..heroInfo["recruit_need_gold"].."金币")



		local tt_callNeedDiamond = G_ToolsManager:seekChildByName(uncallItem,"tt_callNeedDiamond")
		tt_callNeedDiamond:setString(heroInfo["recruit_need_gemstone"])
		
		local ig_called = G_ToolsManager:seekChildByName(uncallItem,"ig_called")
		ig_called:setVisible(false)




		local bt_superCall = G_ToolsManager:seekChildByName(uncallItem,"bt_superCall")
		bt_superCall:setTag(tonumber(k))
		bt_superCall:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	self.nowCallHeroID = sender:getTag()
				local jsMsg = {}
	        	jsMsg["head"] = CS_DPCallHero
	            jsMsg["heroID"] = sender:getTag()
	            jsMsg["callType"] = "2"
             	G_WebSocketManager:sendMessage(jsMsg)   
	        end
	    end)

		
		local bt_call = G_ToolsManager:seekChildByName(uncallItem,"bt_call")
		bt_call:setTag(tonumber(k))
		bt_call:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	self.nowCallHeroID = sender:getTag()
	   			local jsMsg = {}
	            jsMsg["head"] = CS_DPCallHero
	            jsMsg["heroID"] = sender:getTag()
	            jsMsg["callType"] = "1"
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	    end)		

		index = index+1
	end



	for k,heroInfo in pairs(callList) do
		local uncallItem = 	cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/CallHeroItem.csb")
		uncallItem:setPosition(0,scrollviewHeight-(index*380))
		self.sv_callHero:addChild(uncallItem)

		local ig_heroHead = G_ToolsManager:seekChildByName(uncallItem,"ig_heroHead")
		ig_heroHead:loadTexture("icon/hero/"..heroInfo["hero_img1"]..".png")

		local tt_heroName = G_ToolsManager:seekChildByName(uncallItem,"tt_heroName")
		tt_heroName:setString(heroInfo["hero_name"])

		local tt_heroTitle = G_ToolsManager:seekChildByName(uncallItem,"tt_heroTitle")
		tt_heroTitle:setString(heroInfo["hero_title"])


		local tt_zhuanjing = G_ToolsManager:seekChildByName(uncallItem,"tt_zhuanjing")
		local zhuanjinText = G_DataManager:zhuanjinText(heroInfo["hero_master"],2)		
		tt_zhuanjing:setString("专精:"..zhuanjinText)	

		local tt_jingtong = G_ToolsManager:seekChildByName(uncallItem,"tt_jingtong")
		tt_jingtong:setString("精通:"..zhuanjinText)	

		local tt_skill = G_ToolsManager:seekChildByName(uncallItem,"tt_skill")
		tt_skill:setString("技能:")	


		local tt_introduce = G_ToolsManager:seekChildByName(uncallItem,"tt_introduce")
		tt_introduce:setString("介绍:"..heroInfo["hero_explain"])


		local pl_callBg = G_ToolsManager:seekChildByName(uncallItem,"pl_callBg")
		pl_callBg:setVisible(false)

		local ig_called = G_ToolsManager:seekChildByName(uncallItem,"ig_called")
		ig_called:setVisible(true)		

		index = index+1
	end

end



function WHero:updateCallState(state)
	if state == 1 then
		local uncallItem = self.unCallHeroItem[tostring(self.nowCallHeroID)]

		local pl_callBg = G_ToolsManager:seekChildByName(uncallItem,"pl_callBg")
		pl_callBg:setVisible(false)

		local ig_called = G_ToolsManager:seekChildByName(uncallItem,"ig_called")
		ig_called:setVisible(true)	
	end
end



function WHero:changePage(pageID)
	if pageID == 1 then
		self.bt_callHero:setBright(false)
		self.bt_callHero:setTouchEnabled(false)

		self.bt_myHero:setBright(true)
		self.bt_myHero:setTouchEnabled(true)

		self.bt_aodingdao:setBright(true)
		self.bt_aodingdao:setTouchEnabled(true)


		self.sv_callHero:setVisible(true)
	    self.wMyHero:setVisible(false)
	    self.wAodingDao:setVisible(false)


	elseif pageID == 2 then
		self.bt_callHero:setBright(true)
		self.bt_callHero:setEnabled(true)
		self.bt_callHero:setTouchEnabled(true)

		self.bt_myHero:setBright(false)
		self.bt_myHero:setTouchEnabled(false)

		self.bt_aodingdao:setBright(true)
		self.bt_aodingdao:setTouchEnabled(true)


		self.sv_callHero:setVisible(false)
	    self.wMyHero:setVisible(true)
	    self.wAodingDao:setVisible(false)

	elseif pageID == 3 then
		self.bt_callHero:setBright(true)
		self.bt_callHero:setTouchEnabled(true)

		self.bt_myHero:setBright(true)
		self.bt_myHero:setTouchEnabled(true)

		self.bt_aodingdao:setBright(false)
		self.bt_aodingdao:setTouchEnabled(false)


		self.sv_callHero:setVisible(false)
	    self.wMyHero:setVisible(false)
	    self.wAodingDao:setVisible(true)		

	end
end


return WHero