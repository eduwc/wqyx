local MAoDingDao = class("MAoDingDao",require "base.module.BaseModule")
MAoDingDao.moduleName			= "MAoDingDao"
MAoDingDao.wAoDingDao 			= nil
MAoDingDao.hero_friendshipCsv 	= nil

function MAoDingDao:connectView(node)
	MAoDingDao.wAoDingDao = node
end

function MAoDingDao:init(module,moduleName)	
	MAoDingDao.super:init(module,moduleName)
end

function MAoDingDao:ctor()
	self:init(self,self.moduleName)
	self.hero_friendshipCsv = G_CsvManager:getInstance():getPropCsv()
end


function MAoDingDao:receive(msg,head)
	if head == "AODINGDAO" then
		local jieJiaoResule = json.decode(msg["jieJiaoResule"])
		self.wAoDingDao:showJieJiaoResult(jieJiaoResule)
	end
end


return MAoDingDao