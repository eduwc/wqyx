local OtherModule = class("OtherModule",cc.load("mvc").AppBase)


function OtherModule:receiveData(head,jsondata)	
	if head == "SERVERLIST" then
		
	end
end


return OtherModule