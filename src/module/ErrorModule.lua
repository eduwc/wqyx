local ErrorModule = class("ErrorModule",cc.load("mvc").AppBase)


function ErrorModule:receiveData(head,jsondata)	
	if head == "TIP" then
		print("error message"..jsondata["error"])
	end
end


return ErrorModule