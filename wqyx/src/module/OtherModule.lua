local OtherModule = class("OtherModule",cc.load("mvc").AppBase)


function OtherModule:receiveData(head,jsondata)	
	if head == "SERVERLIST" then
		G_NodeManager:notify(jsondata,"SceneLogin")
	end
end


return OtherModule