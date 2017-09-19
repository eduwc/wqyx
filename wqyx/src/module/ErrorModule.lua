local ErrorModule = class("ErrorModule")


function ErrorModule:receiveData(head,jsondata)	
	if head == "TIP" then
		print("error message"..jsondata["error"])
		G_SceneManager:showTip(jsondata["error"])
	end
end


return ErrorModule