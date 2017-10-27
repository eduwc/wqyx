local MPublic = class("MPublic",require "base.module.BaseModule")
MPublic.moduleName				= "MPublic"
MPublic.instance 				= nil
MPublic.playerInfo 				= nil



function MPublic:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


function MPublic:init(module,moduleName)	
	MPublic.super:init(module,moduleName)
end

function MPublic:ctor()
	self:init(self,self.moduleName)
end

function MPublic:receive(msg,head)
	if head == IN_PlAYERINFO then
		self.playerInfo = json.decode(msg)
	end
end

function MPublic:getHeroKuoRongNumber()
	return self.playerInfo["heroKuoRongNumber"]
end

function MPublic:setHeroKuoRongNumber(addNumber)
	self.playerInfo["heroKuoRongNumber"] = self.playerInfo["heroKuoRongNumber"]+addNumber
end

function MPublic:getPlayerLv()
	return self.playerInfo["lv"]
end

return MPublic