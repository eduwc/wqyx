local MHero = class("MHero",require "base.module.BaseModule")
MHero.moduleName			= "MHero"
MHero.vHero 				= nil
MHero.uncalledHeroInfo		= {}
MHero.uncalledHeroID		= {}
MHero.calledHeroInfo		= {}
MHero.calledHeroID			= {}
MHero.maxKuoRong 			= nil  --目前最大的扩容数量
MHero.nowHeroNumber   		= 0    --当前所拥有的英雄数目

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

return MHero