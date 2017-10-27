local TipModule = class("TipModule")

function TipModule:receiveData(head,jsondata)	
	if head == "FLOAT" then
		G_SceneManager:showTip(jsondata["tipInfo"])
	end
end

return TipModule