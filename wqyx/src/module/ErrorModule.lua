local ErrorModule = class("ErrorModule")


function ErrorModule:receiveData(head,jsondata)	
	if head == "ERROR" then
		G_SceneManager:showTip(jsondata["error"])
	end
end


return ErrorModule