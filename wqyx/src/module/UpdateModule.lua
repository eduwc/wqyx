local UpdateModule = class("UpdateModule")


function UpdateModule:receiveData(head,jsondata)	
	if head == "CALLHERO"  then
		G_ModuleManager:notify(jsondata,"MHero",head)
	elseif head == "QIANGHUA" or head == "JINJIE" then
		G_ModuleManager:notify(jsondata,"MMyHero",head)
	elseif head == "AODINGDAO" then	
		G_ModuleManager:notify(jsondata,"MAoDingDao",head)
	end
end


return UpdateModule