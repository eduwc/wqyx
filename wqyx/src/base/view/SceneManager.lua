local SceneManager 			= class("SceneManager")
SceneManager.runScene 		= nil   --�������еĳ���(��һ��cc.Scene:create())
SceneManager.runGameScene   = nil   --�������е���Ϸ����(�̳���BSScene����)
SceneManager.instance 		= nil

function SceneManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


function SceneManager:changeScene(scene)
	--����
	G_NodeManager:removeAllNode()
	G_ModuleManager:removeAllMoudle()

	--�����³���
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

--���緢�͵ȴ� תȦȦ
function SceneManager:showWaitNet()
	self.runGameScene:showWaitNet()
end

function SceneManager:hideWaitNet()
	self.runGameScene:hideWaitNet()
end

return SceneManager