local MHero = class("MHero",require "base.module.BaseModule")
MHero.moduleName			= "MHero"
MHero.vLogin 				= nil
MHero.uncalledHeroInfo		= nil

function MHero:connectView(node)
	self.vLogin = node
end

function MHero:init(module,moduleName)	
	MHero.super:init(module,moduleName)
end

function MHero:ctor()
	self:init(self,self.moduleName)
end


function MHero:receive(msg,head)
	if head == "HERO" then
	   self.uncalledHeroInfo = msg
	end

end

return MHero