local HeroKuoRong = class("HeroKuoRong",require "base.view.BaseNode")
HeroKuoRong.kuoRongCsb 			 = nil
HeroKuoRong.nowKuoRongItemIndex  = nil  --目前正在扩容的组件编号
HeroKuoRong.kuoRongArr 			 = nil  --存放csv数据
HeroKuoRong.kuoRongItemArr 		 = {}  --存放equipKuoRongItem 实例


function HeroKuoRong:ctor(kuoRongNumber)
	self.kuoRongCsb = cc.CSLoader:createNode(CSB_ADDRESS.."csb_public/PublicKuoRongItem.csb")
	self:addChild(self.kuoRongCsb)
	local bt_closeKuoRog = G_ToolsManager:seekChildByName(self.kuoRongCsb,"bt_closeKuoRog")
	bt_closeKuoRog:addTouchEventListener(function(sender, state)
	   if state == 2 then   
	       self:removeFromParent()
	    end
	end)

	self.kuoRongArr = G_CsvManager:getInstance():getKuoRong("4")


	local sv_kuoRongItem = G_ToolsManager:seekChildByName(self.kuoRongCsb,"sv_kuoRongItem")
	local sv_kuoRongItemWidth = #self.kuoRongArr*180
	sv_kuoRongItem:setInnerContainerSize(cc.size(sv_kuoRongItemWidth,400))


	local tt_KuoRongTip = G_ToolsManager:seekChildByName(self.kuoRongCsb,"tt_KuoRongTip")
	tt_KuoRongTip:setString("君主每升3级，英雄数量+1")
	

	for i,kuorogInfo in ipairs(self.kuoRongArr) do
		local equipKuoRongItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_equip/KuoRongItem.csb")
		sv_kuoRongItem:addChild(equipKuoRongItem)
		equipKuoRongItem:setPosition(180*(i-1),0)

		local tt_kuoRongDiamond = G_ToolsManager:seekChildByName(equipKuoRongItem,"tt_kuoRongDiamond")
		tt_kuoRongDiamond:setString("开启需要"..kuorogInfo["need_gemstone"])

		local tt_kuoRongEquipNumebr = G_ToolsManager:seekChildByName(equipKuoRongItem,"tt_kuoRongEquipNumebr")
		tt_kuoRongEquipNumebr:setString("装备数量+"..kuorogInfo["dilatation_up_num"])

		local ig_kuoRongNo = G_ToolsManager:seekChildByName(equipKuoRongItem,"ig_kuoRongNo")
		ig_kuoRongNo:loadTexture("ui/public/".."num"..i..".png")

		local ig_kuoRongItemOpened = G_ToolsManager:seekChildByName(equipKuoRongItem,"ig_kuoRongItemOpened")
		local bt_kuoRongOpen = G_ToolsManager:seekChildByName(equipKuoRongItem,"bt_kuoRongOpen")
		bt_kuoRongOpen:setTag(i)
		bt_kuoRongOpen:addTouchEventListener(function(sender, state)
		   if state == 2 then   
		   		self.nowKuoRongItem = sender:getTag()
		        local jsMsg = {}
	            jsMsg["head"] = CS_DPHeroKuoRong
             	G_WebSocketManager:sendMessage(jsMsg)
		    end
		end)		
		

		if i<=kuoRongNumber then
			bt_kuoRongOpen:setVisible(false)
			ig_kuoRongItemOpened:setVisible(true)
		else
			bt_kuoRongOpen:setVisible(true)
			ig_kuoRongItemOpened:setVisible(false)
		end
		table.insert(self.kuoRongItemArr,equipKuoRongItem)

	end

end

function HeroKuoRong:updateKuoRong()
	local nowKuoRongItem = self.kuoRongItemArr[self.nowKuoRongItem]
	local bt_kuoRongOpen = G_ToolsManager:seekChildByName(nowKuoRongItem,"bt_kuoRongOpen")
	bt_kuoRongOpen:setVisible(false)
	local ig_kuoRongItemOpened = G_ToolsManager:seekChildByName(nowKuoRongItem,"ig_kuoRongItemOpened")
	ig_kuoRongItemOpened:setVisible(true)
	G_ModulePublic:setHeroKuoRongNumber(1)
end

return HeroKuoRong