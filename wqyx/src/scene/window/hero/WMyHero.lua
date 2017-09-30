local WMyHero = class("WMyHero",require "base.view.BaseNode")
WMyHero.nodeName				= "WMyHero"
WMyHero.mMyHero					= nil
WMyHero.myheroView				= nil
WMyHero.sv_myHeroHead			= nil

-- --必须要实现
function WMyHero:init(node,nodeName)
	WMyHero.super:init(node,nodeName)
end


function WMyHero:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	WMyHero.super:ctor()

	-- --可不调用，最好调用
	self.mMyHero  = require ("module.hero.mMyHero"):create()
	self.mMyHero:connectView(self)

	self.myheroView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/MyHero.csb")
	self:addChild(self.myheroView)	


	self.sv_myHeroHead = G_ToolsManager:seekChildByName(self.myheroView,"sv_myHeroHead")
end

return WMyHero