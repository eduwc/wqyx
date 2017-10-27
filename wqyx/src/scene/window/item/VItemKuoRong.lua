local VItemKuoRong = class("VItemKuoRong",require "base.view.BaseNode")
VItemKuoRong.equipKuoRongCsb = nil

function VItemKuoRong:ctor()
	self.equipKuoRongCsb = cc.CSLoader:createNode(CSB_ADDRESS.."csb_equip/EquipKuoRong.csb")
	self:addChild(self.equipKuoRongCsb)
	local bt_closeEquipKuoRog = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"bt_closeEquipKuoRog")
	bt_closeEquipKuoRog:addTouchEventListener(function(sender, state)
	   if state == 2 then   
	       self:removeFromParent()
	    end
	end)

	local equipKuoRongArr = G_CsvManager:getInstance():getKuoRong("3")

	local sv_kuoRongItem = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"sv_kuoRongItem")
	local sv_kuoRongItemWidth = #equipKuoRongArr*180
	sv_kuoRongItem:setInnerContainerSize(cc.size(sv_kuoRongItemWidth,400))

	

	for i,kuorogInfo in ipairs(equipKuoRongArr) do
		local equipKuoRongItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_equip/KuoRongItem.csb")
		sv_kuoRongItem:addChild(equipKuoRongItem)
		equipKuoRongItem:setPosition(180*(i-1),0)


		local tt_kuoRongDiamond = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"tt_kuoRongDiamond")
		tt_kuoRongDiamond:setString("开启需要"..kuorogInfo["need_gemstone"])

		local tt_kuoRongEquipNumebr = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"tt_kuoRongEquipNumebr")
		tt_kuoRongEquipNumebr:setString("装备数量+"..kuorogInfo["dilatation_up_num"])

		local ig_kuoRongNo = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"ig_kuoRongNo")
		ig_kuoRongNo:loadTexture("ui/public/".."num"..i..".png")

		local ig_kuoRongItemOpened = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"ig_kuoRongItemOpened")
		local bt_kuoRongOpen = G_ToolsManager:seekChildByName(self.equipKuoRongCsb,"bt_kuoRongOpen")

	end
end

function VItemKuoRong:init()



end


return VItemKuoRong