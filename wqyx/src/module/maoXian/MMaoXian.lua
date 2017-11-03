local MMaoXian = class("MMaoXian",require "base.module.BaseModule")
MMaoXian.moduleName			= "MMaoXian"
MMaoXian.vMaoXianDuiLie 	= nil



function MMaoXian:connectView(node)
	self.vMaoXianDuiLie = node
end

function MMaoXian:init(module,moduleName)	
	MMaoXian.super:init(module,moduleName)
end

function MMaoXian:ctor()
	self:init(self,self.moduleName)
end

function MMaoXian:receive(msg,head)
end


return MMaoXian