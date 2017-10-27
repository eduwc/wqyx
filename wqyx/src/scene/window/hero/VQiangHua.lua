local VQiangHua = class("VQiangHua",require "base.view.BaseNode")
VQiangHua.qiangHuaBg 			= nil
VQiangHua.selectedHeroInfo  	= nil
VQiangHua.mMyHero 				= nil
VQiangHua.tt_bfHeroName			= nil
VQiangHua.tt_afHeroName 		= nil
VQiangHua.tt_zhanli 			= nil
VQiangHua.tt_needItemNumber 	= nil
VQiangHua.tt_qiangHuaneedGold 	= nil
VQiangHua.nowQiangHuaLv			= nil
VQiangHua.selectedHeroID 		= nil


function VQiangHua:ctor()
	
end

function VQiangHua:init(selectedHeroInfo,mMyHero,selectedHeroID)

	self.selectedHeroInfo = selectedHeroInfo
	self.mMyHero = mMyHero
	self.selectedHeroID = selectedHeroID

	self.qiangHuaBg	= cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/HeroQiangHua.csb")
	self:addChild(self.qiangHuaBg)

	self.nowQiangHuaLv 		 		= 0   --目前强化等级
	local strengthen_need_propid 	= self.selectedHeroInfo["strengthen_need_propid"] 
	local itemPicID 				= self.mMyHero:getQiangHuaItemPicID(strengthen_need_propid)
	local itemName 				 	= self.mMyHero:getQiangHuaItemName(strengthen_need_propid)
	local itemNeedNumber 		 	= self.mMyHero:getQiangHuaItemNumber(self.nowQiangHuaLv)
	local qiangHuaGold 			 	= self.mMyHero:getQiangHuaGold(self.nowQiangHuaLv,tonumber(self.selectedHeroInfo["recruit_level"]))
	local zhanli 				 	= self.mMyHero:getQiangHuaZhanLi(self.nowQiangHuaLv)

	
	

	local ig_beforQiangHua 			= G_ToolsManager:seekChildByName(self.qiangHuaBg,"ig_beforQiangHua")
	ig_beforQiangHua:loadTexture("icon/hero/"..self.selectedHeroInfo["hero_img2"]..".png")
	
	self.tt_bfHeroName 			= G_ToolsManager:seekChildByName(self.qiangHuaBg,"tt_bfHeroName")
	self.tt_bfHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowQiangHuaLv )

	local ig_afterQiangHua 			= G_ToolsManager:seekChildByName(self.qiangHuaBg,"ig_afterQiangHua")
	ig_afterQiangHua:loadTexture("icon/hero/"..self.selectedHeroInfo["hero_img2"]..".png")

	self.tt_afHeroName 			= G_ToolsManager:seekChildByName(self.qiangHuaBg,"tt_afHeroName")
	self.tt_afHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowQiangHuaLv+1 )

	local ig_needQiangHua 			= G_ToolsManager:seekChildByName(self.qiangHuaBg,"ig_needQiangHua")
	ig_needQiangHua:loadTexture("icon/item/"..itemPicID..".png")

	local tt_needItemName 			= G_ToolsManager:seekChildByName(self.qiangHuaBg,"tt_needItemName")
	tt_needItemName:setString(itemName)

	self.tt_needItemNumber 		= G_ToolsManager:seekChildByName(self.qiangHuaBg,"tt_needItemNumber")
	self.tt_needItemNumber:setString("x"..itemNeedNumber)

	self.tt_zhanli				= G_ToolsManager:seekChildByName(self.qiangHuaBg,"tt_zhanli")
	self.tt_zhanli:setString(zhanli)

	self.tt_qiangHuaneedGold = G_ToolsManager:seekChildByName(self.qiangHuaBg,"tt_qiangHuaneedGold")
	self.tt_qiangHuaneedGold:setString(qiangHuaGold)

	local bt_qiangHua = G_ToolsManager:seekChildByName(self.qiangHuaBg,"bt_qiangHua")
	bt_qiangHua:addTouchEventListener(function(sender, state)
		if state == 2 then
	        local jsMsg = {}
	        jsMsg["head"] = CS_DPMyHero
	        jsMsg["functionType"] = "qianghua"
	        jsMsg["heroID"] = tostring(self.selectedHeroID)
            G_WebSocketManager:sendMessage(jsMsg)		
		end
	end)
end


--更新强化信息
function VQiangHua:updateQiangHuaInfo()
	if self.nowQiangHuaLv <=5 then
		self.nowQiangHuaLv = self.nowQiangHuaLv+1

		self.tt_bfHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowQiangHuaLv)
		self.tt_afHeroName:setString(self.selectedHeroInfo["hero_name"].."+"..self.nowQiangHuaLv+1)

		
		self.tt_zhanli:setString(self.mMyHero:getQiangHuaZhanLi(self.nowQiangHuaLv))
		self.tt_needItemNumber:setString("x"..self.mMyHero:getQiangHuaItemNumber(self.nowQiangHuaLv))

		self.tt_qiangHuaneedGold:setString(self.mMyHero:getQiangHuaGold(self.nowQiangHuaLv,tonumber(self.selectedHeroInfo["recruit_level"])))
	end
	
end

return VQiangHua



