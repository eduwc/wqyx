local SceneManager 			= class("SceneManager")
SceneManager.runScene 		= nil   --正在运行的场景(是一个cc.Scene:create())
SceneManager.runGameScene   = nil   --正在运行的游戏场景(继承于BSScene的类)
SceneManager.instance 		= nil

function SceneManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


function SceneManager:changeScene(scene)
	--清理
	G_NodeManager:removeAllNode()
	G_ModuleManager:removeAllMoudle()

	--运行新场景
	self.runScene = cc.Scene:create()
	cc.Director:getInstance():replaceScene(self.runScene)

	self.runGameScene = scene:create()
	self.runScene:addChild(self.runGameScene)
end

function SceneManager:getRunScene()
	return self.runScene
end

function SceneManager:getRunGameScene()
	return self.runGameScene
end


function SceneManager:showTip(str)
	self.runGameScene:showTip(str)
end

--网络发送等待 转圈圈
function SceneManager:showWaitNet()
	self.runGameScene:showWaitNet()
end

function SceneManager:hideWaitNet()
	self.runGameScene:hideWaitNet()
end

return SceneManager