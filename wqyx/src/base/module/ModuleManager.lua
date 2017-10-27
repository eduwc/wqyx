local ModuleManager  = class("ModuleManager")
ModuleManager.moduleTable 		= {}
ModuleManager.instance 			= nil


function ModuleManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end

function ModuleManager:addModule(module,moduleName)
	if moduleName == nil then
		error("your moduleName is nil")
		return
	else
		self.moduleTable[moduleName] = module
		G_GameLog("ModuleManager-addModule moduleName is->"..moduleName)
	end

end

function ModuleManager:notify(json,moduleName,...)
    if moduleName == nil then
		error("your moduleName is nil")
		return
	else
		self.moduleTable[moduleName]:receive(json,...)
	end
end

function ModuleManager:removeModule(moduleName)
	self.moduleTable[moduleName] = nil
end

function ModuleManager:removeAllMoudle()
	if self.moduleTable ~=nil then
		for k,v in pairs(self.moduleTable) do
			v = nil
		end
	end 
end


function ModuleManager:getModuleCount()
	local count = 0  
	for k,v in pairs(self.moduleTable) do  
	    count = count + 1  
	end  
	return count
end


return ModuleManager