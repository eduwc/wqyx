local WItem = class("WItem",require "base.view.BaseNode")
WItem.nodeName				= "WItem"
WItem.mItem 				= nil
WItem.pageTagArr 			= {}
WItem.equipCsb 				= nil
WItem.sv_equip  			= nil
WItem.shuLianView 			= nil


-- --必须要实现
function WItem:init(node,nodeName)
	WItem.super:init(node,nodeName)
end


function WItem:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	WItem.super:ctor()

	--可不调用，最好调用
	self.mItem  = require ("module.item.MItem"):create()
	self.mItem:connectView(self)

	self.equipCsb = cc.CSLoader:createNode(CSB_ADDRESS.."csb_equip/Equip.csb")
	self:addChild(self.equipCsb)

	local bt_addEquipSpace = G_ToolsManager:seekChildByName(self.equipCsb,"bt_addEquipSpace")
	bt_addEquipSpace:addTouchEventListener(function(sender, state)
	    if state == 2 then
	    	self:showKuoRongView()
	    end
	end)	


	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_quanBuPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_jianPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_daoPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_qiangPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_faZhangPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_gongPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_huoQiangPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_fuTouPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_duanYiPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_maoZiPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_touKuiPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_changYiPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_duanYiPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_changXuePage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_duanXuePage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_jieZhiPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_xiangLiangPage"))
	table.insert(self.pageTagArr,G_ToolsManager:seekChildByName(self.equipCsb,"bt_moFaShuPage"))


	for i,pageBtn in ipairs(self.pageTagArr) do
		pageBtn:setTag(tonumber(i-1))
		pageBtn:addTouchEventListener(function(sender, state)
	        if state == 2 then
		       self:changePage(pageBtn:getTag())
	        end
	    end)		
	end	


	self.sv_equip = G_ToolsManager:seekChildByName(self.equipCsb,"sv_equip")

end

function WItem:changePage(pageIndex)
	self:showEquip(self.mItem.equipArrManager[pageIndex])	
end


function WItem:showEquip(equipArr)
	self.sv_equip:removeAllChildren()
	local sv_equipHeight = nil
	local equipArrLen = #equipArr
	if equipArrLen <5 then
		sv_equipHeight = 640
	else
		sv_equipHeight = equipArrLen*150
	end
	self.sv_equip:setInnerContainerSize(cc.size(640,sv_equipHeight))
	for i,equipInfo in ipairs(equipArr) do
		local equipItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_equip/EquipItemInfo.csb")
		self.sv_equip:addChild(equipItem)
		equipItem:setPosition(0,sv_equipHeight-((i-1)*150))

		local ig_equipItem = G_ToolsManager:seekChildByName(equipItem,"ig_equipItem")
		ig_equipItem:loadTexture("icon/item/"..G_CsvManager:getInstance():getItemPicID(equipInfo["equipId"])..".png")

		local tt_equipNumber = G_ToolsManager:seekChildByName(equipItem,"tt_equipNumber")
		tt_equipNumber:setString(equipInfo["equipNumber"])


		local lb_equipShuLianItem = G_ToolsManager:seekChildByName(equipItem,"lb_equipShuLianItem")


		local tt_itemNameItem = G_ToolsManager:seekChildByName(equipItem,"tt_itemNameItem")
		tt_itemNameItem:setString(G_CsvManager:getInstance():getItemName(equipInfo["equipId"]))

		local tt_itemZhanLiItem = G_ToolsManager:seekChildByName(equipItem,"tt_itemZhanLiItem")
		tt_itemZhanLiItem:setString(G_CsvManager:getInstance():getOriginalZhanLi(equipInfo["equipId"]))

		local tt_shuLianItem = G_ToolsManager:seekChildByName(equipItem,"tt_shuLianItem")
		tt_shuLianItem:setString("15/25")

		local bt_shuLianInfoItem = G_ToolsManager:seekChildByName(equipItem,"bt_shuLianInfoItem")
		bt_shuLianInfoItem:addTouchEventListener(function(sender, state)
	        if state == 2 then   
	        	self:openShuLianDuView(equipInfo["equipId"])
	        end
	    end)		
	end
end


function WItem:openShuLianDuView(equipId)
	self.shuLianView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_equip/ShuLianDuItem.csb")	
	self:addChild(self.shuLianView) 

	local duanZaoArr = G_CsvManager:getInstance():getDuanZaoArr(equipId)
	local addPropertyShow = "售价+%"
	local index = 1
	for i=1,4 do
		G_GameLog("duanZaoArr[index]"..index)
		local tt_shuLianProperty = G_ToolsManager:seekChildByName(self.shuLianView,"tt_shuLianProperty"..i)  
		if duanZaoArr[index]["forge_award_type"] == "1" then
			addPropertyShow = "售价+%"..((duanZaoArr[index]["award_num"]/10000)*100)
		elseif duanZaoArr[index]["forge_award_type"] == "2" then
			addPropertyShow = "战力+%"..((duanZaoArr[index]["award_num"]/10000)*100)
		end
		tt_shuLianProperty:setString(addPropertyShow)
		if index == 2 then   --跳过第三个，第三个没有数据
			index = index+2
		else
			index = index+1
		end
		
	end	


	local bt_closeShuLianDu = G_ToolsManager:seekChildByName(self.shuLianView,"bt_closeShuLianDu") 
	bt_closeShuLianDu:addTouchEventListener(function(sender, state)
	    if state == 2 then   
	       self:closeShuLianDuView()
	    end
	end)

	
end

function WItem:closeShuLianDuView()
	self.shuLianView:removeFromParent()
end


function WItem:showKuoRongView()
	self:addChild(require("scene.window.item.VItemKuoRong"):create()) 
end

return WItem