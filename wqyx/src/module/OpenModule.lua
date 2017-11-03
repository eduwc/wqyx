local OpenModule = class("OpenModule")


function OpenModule:receiveData(head,jsondata)	
	local runGameScene = G_SceneManager:getRunGameScene()
	if head == "HERO" then
		runGameScene:addToWindow(require("scene.window.hero.WHero"):create())		
		G_ModuleManager:notify(jsondata,"MHero",head)
	elseif head == "ITEM" then
		runGameScene:addToWindow(require("scene.window.item.WItem"):create())		
		G_ModuleManager:notify(jsondata,"MItem",head)
	elseif head == "MAOXIAN" then
		runGameScene:addToWindow(require("scene.window.maoXian.WMaoXianDuiLie"):create())		
		G_ModuleManager:notify(jsondata,"MMaoXian",head)
	end
end


return OpenModule