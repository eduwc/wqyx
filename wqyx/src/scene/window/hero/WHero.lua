local WHero = class("WHero",require "base.view.BaseNode")
WHero.nodeName				= "WHero"
WHero.mhero					= nil



-- --����Ҫʵ��
function WHero:init(node,nodeName)
	WHero.super:init(node,nodeName)
end

function WHero:ctor()
		--����Ҫ����
	self:init(self,self.nodeName)
	WHero.super:ctor()

	--�ɲ����ã���õ���
	self.mhero  = require ("module.hero.MHero"):create()
	self.mhero:connectView(self)

	self.callHeroWindow = cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/CallHero.csb")
	self:addChild(self.callHeroWindow)	
end


return WHero