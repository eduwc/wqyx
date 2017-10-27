local SwitchModule = class("SwitchModule")


function SwitchModule:receiveData(head,jsondata)	
	if head == "ENTERGAME" then
		G_SceneManager:changeScene(require ("scene.home.SceneHome"))
		G_ModuleManager:notify(jsondata,"MHome",head)
	end
end


return SwitchModule