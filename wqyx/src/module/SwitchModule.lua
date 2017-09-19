local SwitchModule = class("SwitchModule")


function SwitchModule:receiveData(head,jsondata)	
	if head == "REGISTER" then
		require ("scene.home.SceneHome"):create()
	end
end


return SwitchModule