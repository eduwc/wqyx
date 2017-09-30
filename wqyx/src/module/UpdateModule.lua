local UpdateModule = class("UpdateModule")


function UpdateModule:receiveData(head,jsondata)	
	if head == "CALLHERO" then
		G_ModuleManager:notify(jsondata,"MHero",head)
	end
end


return UpdateModule