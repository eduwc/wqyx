local MHero = class("MHero",require "base.module.BaseModule")
MHero.moduleName			= "MHero"
MHero.vHero 				= nil
MHero.uncalledHeroInfo		= {}   --hero csv数据
MHero.uncalledHeroID		= {}	
MHero.calledHeroInfo		= {}
MHero.calledHeroID			= {}
MHero.maxKuoRong 			= nil  --目前最大的扩容数量
MHero.nowHeroNumber   		= 0    --当前所拥有的英雄数目
MHero.qiangHuaInfo          = nil
MHero.jinJieInfo            = nil
MHero.heroServerInfo        = {}   --hero存储在服务端的数据

function MHero:connectView(node)
	self.vHero = node
end

function MHero:init(module,moduleName)	
	MHero.super:init(module,moduleName)
end

function MHero:ctor()
	self:init(self,self.moduleName)
end



function MHero:receive(msg,head)
	if head == "HERO" then
	   local calledHeroIDArr = string.split(msg["calledInfo"],";")
	   self:setMaxHeroNumber(msg["heroMaxKuoRong"])
	   self:setNowHeroNumber(msg["nowHeroNumber"])
	   self:setQiangHuaInfo(string.split(msg["qiangHuaLv"],";"))
	   self:setJinJieInfo(string.split(msg["jinjieLv"],";"))

	   --存储hero在服务端的相关数据
	   for i,v in ipairs(calledHeroIDArr) do
	   		local heroInfo = {}
	   		heroInfo["qiangHuaLv"] = self:getQiangHuaInfo(i)
	   		heroInfo["jinjieLv"] = self:getJinJieInfo(i)
	   		self.heroServerInfo[v] = heroInfo
	   end


	   local heroCsv =  G_CsvManager:getInstance():getHeroCsv()
	    for k,csvInfo in pairs(heroCsv) do
	   		if csvInfo["if_recruit"] == "1" then
	   				local isExist = false
			   		for n,m in pairs(calledHeroIDArr) do
			   			if k == m then		   				
			   				isExist = true
			   				break
			   			end
			   		end			

			   		if isExist then
			   		   table.insert(self.calledHeroID,csvInfo.recruit_level)
			   		   self.calledHeroInfo[k] = csvInfo
			   		else			   		   
			   		   table.insert(self.uncalledHeroID,csvInfo.recruit_level)
			   		   self.uncalledHeroInfo[k] = csvInfo
			   		end
			end		 
	    end
	    --TOOD CW
 		-- self.uncalledHeroID = G_ToolsManager:bubbleSort(self.uncalledHeroID)
			--       for i,v in ipairs(self.uncalledHeroID) do  
			--         print(i,v)  
			--     end  	
		self.vHero:showItem(self.uncalledHeroInfo,self.calledHeroInfo)
	elseif head == "CALLHERO" then	
		self:setNowHeroNumber(1)	
		self.vHero:updateCallState(msg["callState"])		
	elseif head == REQUESTHERO then
		local jsMsg = {}
		jsMsg["heroServerInfo"] = self.heroServerInfo
		jsMsg["calledHero"] = self.calledHeroInfo
		G_ModuleManager:notify(jsMsg,"MMyHero",RESPONDHERO)
	elseif head == "HEROKUORONG" then
		self:setMaxHeroNumber(msg["heroMaxKuoRong"])		
		self.vHero:updateHeroKuoRong()
	end

end


function MHero:getTableLen(table)
	local index = 0
	for k,v in pairs(table) do
		index = index+1
	end
	return index
end

--获取英雄的最大数目
function MHero:getMaxHeroNumber()
	return self.maxKuoRong	
end

function MHero:setMaxHeroNumber(number)
	self.maxKuoRong  = number
end

function MHero:getNowHeroNumber()
	return self.nowHeroNumber	
end

function MHero:setNowHeroNumber(number)
	self.nowHeroNumber = self.nowHeroNumber+number
end


function MHero:setQiangHuaInfo(qiangHuaInfo)
	self.qiangHuaInfo = qiangHuaInfo
end

--该函数未经经过排序，会与排序后的顺序不相符
function MHero:getQiangHuaInfo(index)
	return self.qiangHuaInfo[index]
end


function MHero:setJinJieInfo(jinJieInfo)
	self.jinJieInfo = jinJieInfo
end

--该函数未经经过排序，会与排序后的顺序不相符
function MHero:getJinJieInfo(index)
	return self.jinJieInfo[index]
end

return MHero