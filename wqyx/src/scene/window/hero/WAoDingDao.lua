local WAoDingDao = class("WAoDingDao",require "base.view.BaseNode")
WAoDingDao.nodeName				= "WAoDingDao"


-- --����Ҫʵ��
function WAoDingDao:init(node,nodeName)
	WAoDingDao.super:init(node,nodeName)
end

function WAoDingDao:ctor()
		--����Ҫ����
	self:init(self,self.nodeName)
	WAoDingDao.super:ctor()

	-- --�ɲ����ã���õ���
	-- self.mhero  = require ("module.hero.MHero"):create()
	-- self.mhero:connectView(self)
end


return WAoDingDao