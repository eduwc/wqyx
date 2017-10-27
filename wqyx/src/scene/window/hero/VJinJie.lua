local VJinJie = class("VJinJie",require "base.view.BaseNode")
VJinJie.jinjieBg 			= nil
VJinJie.selectedHeroInfo  	= nil
VJinJie.mMyHero 			= nil
VJinJie.tt_bfHeroName		= nil
VJinJie.tt_afHeroName 		= nil
VJinJie.tt_zhanli 			= nil
VJinJie.tt_needItemNumber 	= nil
VJinJie.tt_jinJieGold 		= nil
VJinJie.nowJinJieLv			= nil
VJinJie.selectedHeroID 		= nil


function VJinJie:ctor()
	
end

function VJinJie:init(selectedHeroInfo,mMyHero,selectedHeroID)

	self.selectedHeroInfo = selectedHeroInfo
	self.mMyHero = mMyHero
	self.selectedHeroID = selectedHeroID

	self.jinjieBg	= cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/HeroJinJie.csb")
	self:addChild(self.jinjieBg)

	self.nowJinJieLv 		 		= 0  
	local propid 					= "100"
	local itemPicID 				= self.mMyHero:getItemPicID(propid)
	local itemName 				 	= self.mMyHero:getItemName(propid)
	local itemNeedNumber 		 	= self.mMyHero:getJinJieItemNumber(self.nowJinJieLv)
	local jinjieGold 			 	= self.mMyHero:getJinJieGold(self.nowJinJieLv,tonumber(self.selectedHeroInfo["recruit_level"]))
	local zhanli 				 	= self.mMyHero:getJinJieZhanLi(self.nowJinJieLv)

	
	

	local ig_beforJinJie 			= G_ToolsManager:seekChildByName(self.jinjieBg,"ig_beforJinJie")
	ig_beforJinJie:loadTexture("icon/hero/"..self.selectedHeroInfo["hero_img2"]..".png")
	
	self.tt_bfHeroName 			= G_ToolsManager:seekChildByName(self.jinjieBg,"tt_bfHeroName")
	self.tt_bfHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowJinJieLv )

	local ig_afterJinJie 			= G_ToolsManager:seekChildByName(self.jinjieBg,"ig_afterJinJie")
	ig_afterJinJie:loadTexture("icon/hero/"..self.selectedHeroInfo["hero_img2"]..".png")

	self.tt_afHeroName 			= G_ToolsManager:seekChildByName(self.jinjieBg,"tt_afHeroName")
	self.tt_afHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowJinJieLv+1 )

	local ig_needJinJie 			= G_ToolsManager:seekChildByName(self.jinjieBg,"ig_needJinJie")
	ig_needJinJie:loadTexture("icon/item/"..itemPicID..".png")

	local tt_needItemName 			= G_ToolsManager:seekChildByName(self.jinjieBg,"tt_needItemName")
	tt_needItemName:setString(itemName)

	self.tt_needItemNumber 		= G_ToolsManager:seekChildByName(self.jinjieBg,"tt_needItemNumber")
	self.tt_needItemNumber:setString("x"..itemNeedNumber)

	self.tt_zhanli				= G_ToolsManager:seekChildByName(self.jinjieBg,"tt_zhanli")
	self.tt_zhanli:setString(zhanli)

	self.tt_jinJieGold = G_ToolsManager:seekChildByName(self.jinjieBg,"tt_jinJieGold")
	self.tt_jinJieGold:setString(jinjieGold)

	local bt_jinJie = G_ToolsManager:seekChildByName(self.jinjieBg,"bt_jinJie")
	bt_jinJie:addTouchEventListener(function(sender, state)
		if state == 2 then
	        local jsMsg = {}
	        jsMsg["head"] = CS_DPMyHero
	        jsMsg["functionType"] = "jinjie"
	        jsMsg["heroID"] = tostring(self.selectedHeroID)
            G_WebSocketManager:sendMessage(jsMsg)		
		end
	end)
end


--更新结交
function VJinJie:updateJinJieInfo()
	if self.nowJinJieLv <=5 then
		self.nowJinJieLv = self.nowJinJieLv+1

		self.tt_bfHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowJinJieLv)
		self.tt_afHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowJinJieLv+1)

		
		self.tt_zhanli:setString(self.mMyHero:getJinJieZhanLi(self.nowJinJieLv))
		self.tt_needItemNumber:setString("x"..self.mMyHero:getJinJieItemNumber(self.nowJinJieLv))

		self.tt_jinJieGold:setString(self.mMyHero:getJinJieGold(self.nowJinJieLv,tonumber(self.selectedHeroInfo["recruit_level"])))
	end
	
end


return VJinJie