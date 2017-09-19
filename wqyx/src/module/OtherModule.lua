local OtherModule = class("OtherModule")


function OtherModule:receiveData(head,jsondata)	
	if head == "SERVERLIST" then
		G_ModuleManager:notify(jsondata,"MLogin",head)
	end
end


return OtherModule