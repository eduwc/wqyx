local MHero = class("MHero",require "base.module.BaseModule")
MHero.moduleName			= "MHero"
MHero.vHero 				= nil
MHero.uncalledHeroInfo		= {}
MHero.uncalledHeroID		= {}
MHero.calledHeroInfo		= {}
MHero.calledHeroID			= {}

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
	   --剔除已召唤的
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
	    --TOOD 排序先放着
 		-- self.uncalledHeroID = G_ToolsManager:bubbleSort(self.uncalledHeroID)
			--       for i,v in ipairs(self.uncalledHeroID) do  
			--         print(i,v)  
			--     end  	
		self.vHero:showItem(self.uncalledHeroInfo,self.calledHeroInfo)
	elseif head == "CALLHERO" then		
		self.vHero:updateCallState(msg["callState"])
	elseif head == REQUESTHERO then
		local jsMsg = {}
		jsMsg["calledHero"] = self.calledHeroInfo
		G_ModuleManager:notify(jsMsg,"MMyHero",RESPONDHERO)
	end

end


function MHero:getTableLen(table)
	local index = 0
	for k,v in pairs(table) do
		index = index+1
	end
	return index
end

return MHero