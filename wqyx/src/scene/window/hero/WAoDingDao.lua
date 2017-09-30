local WAoDingDao = class("WAoDingDao",require "base.view.BaseNode")
WAoDingDao.nodeName				= "WAoDingDao"


-- --必须要实现
function WAoDingDao:init(node,nodeName)
	WAoDingDao.super:init(node,nodeName)
end

function WAoDingDao:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	WAoDingDao.super:ctor()

	-- --可不调用，最好调用
	-- self.mhero  = require ("module.hero.MHero"):create()
	-- self.mhero:connectView(self)
end


return WAoDingDao