local WHero = class("WHero",require "base.view.BaseNode")
WHero.nodeName				= "WHero"
WHero.mhero					= nil



-- --必须要实现
function WHero:init(node,nodeName)
	WHero.super:init(node,nodeName)
end

function WHero:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	WHero.super:ctor()

	--可不调用，最好调用
	self.mhero  = require ("module.hero.MHero"):create()
	self.mhero:connectView(self)

	self.callHeroWindow = cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/CallHero.csb")
	self:addChild(self.callHeroWindow)	
end


return WHero