local MMyHero = class("MMyHero",require "base.module.BaseModule")
MMyHero.moduleName			= "MMyHero"


function MMyHero:connectView(node)
	self.vHero = node
end

function MMyHero:init(module,moduleName)	
	MMyHero.super:init(module,moduleName)
end

function MMyHero:ctor()
	self:init(self,self.moduleName)
end


function MMyHero:receive(msg,head)
	
end


return MMyHero