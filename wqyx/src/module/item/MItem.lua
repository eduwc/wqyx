local MItem = class("MItem",require "base.module.BaseModule")
MItem.moduleName			= "MItem"
MItem.vItem 				= nil
--0全部，1-剑 2-刀 3-枪 4-法杖 5-弓 6-火枪 7-斧头 8-头盔 9-帽子 10-长衣 11-短衣 12-长靴 13-短靴
--14-戒指 15-项链 16-宝物 17-时装
MItem.equipArrManager 		= {}



function MItem:connectView(node)
	self.vItem = node
end

function MItem:init(module,moduleName)	
	MItem.super:init(module,moduleName)
end

function MItem:ctor()
	self:init(self,self.moduleName)
end



function MItem:receive(msg,head)
	if head == "ITEM" then
		local equipInfo = msg["equipInfo"]

		local index = 0
		for i,equipJsonArr in ipairs(equipInfo) do
			local equipItenInfoArr = {}
			for k,equipItenInfo in ipairs(equipJsonArr) do
				 local decodeItemInfo = json.decode(equipItenInfo)
				 table.insert(equipItenInfoArr,k,decodeItemInfo)
			end
			table.insert(self.equipArrManager,index,equipItenInfoArr)
			index = index+1
		end
		self.vItem:showEquip(self.equipArrManager[0])
	end
end

return MItem