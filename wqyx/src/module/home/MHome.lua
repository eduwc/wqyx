local MHome = class("MHome",require "base.module.BaseModule")
MHome.moduleName	= "MHome"
MHome.vLogin 		= nil
MHome.enterGameInfo	= nil


function MHome:connectView(node)
	self.vLogin = node
end

function MHome:init(module,moduleName)	
	MHome.super:init(module,moduleName)
end

function MHome:ctor()
	self:init(self,self.moduleName)
end


function MHome:receive(msg,head)
	if head == "ENTERGAME" then
	   self.enterGameInfo = msg
	end
end

return MHome
