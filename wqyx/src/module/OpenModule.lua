local OpenModule = class("OpenModule")


function OpenModule:receiveData(head,jsondata)	
	local runGameScene = G_SceneManager:getRunGameScene()
	if head == "HERO" then
		runGameScene:addToWindow(require("scene.window.hero.WHero"):create())		
		G_ModuleManager:notify(jsondata,"MHero",head)
	end
end


return OpenModule