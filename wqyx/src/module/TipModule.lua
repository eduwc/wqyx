local TipModule = class("TipModule")

function TipModule:receiveData(head,jsondata)	
	if head == "TIP" then
		print("error message"..jsondata["error"])
	end
end

return TipModule