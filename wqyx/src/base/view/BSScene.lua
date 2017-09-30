local BSScene 			= class("BSScene",cc.Scene)
BSScene.gameScene		= nil
BSScene.bgLayer 		= nil    --背景层
BSScene.uiLayer 		= nil	 --UI层	
BSScene.windowLayer 	= nil	 --窗口层
BSScene.guideLayer 		= nil    --引导层
BSScene.effectLayer 	= nil    --特效层
BSScene.tipLayer 		= nil    --消息提示层
BSScene.loadingLayer 	= nil    --loading层

function BSScene:init(node,nodeName)
	BSScene:init(node,nodeName)
end

function BSScene:receive(json)
end


function BSScene:init(node,nodeName)
	G_NodeManager:addNode(node,nodeName)
end



function BSScene:ctor()
--	self.gameScene = cc.Scene:create()
	--cc.Director:getInstance():getRunningScene()
--	cc.Director:getInstance():replaceScene(self.gameScene)
--	self.gameScene = G_SceneManager:changeScene(self)
	self.gameScene = G_SceneManager:getRunScene()

	self.bgLayer = cc.Layer:create()
	self.gameScene:addChild(self.bgLayer,5)

	self.uiLayer = cc.Layer:create()
	self.gameScene:addChild(self.uiLayer,10)

	self.windowLayer = cc.Layer:create()
	self.gameScene:addChild(self.windowLayer,15)

	self.guideLayer = cc.Layer:create()
	self.gameScene:addChild(self.guideLayer,20)

	self.effectLayer = cc.Layer:create()
	self.gameScene:addChild(self.effectLayer,25)

	self.tipLayer = cc.Layer:create()
	self.gameScene:addChild(self.tipLayer,30)

	self.loadingLayer = cc.Layer:create()
	self.gameScene:addChild(self.loadingLayer,35)	
end


function BSScene:addToBgLayer(node)
	self.bgLayer:addChild(node)
end

function BSScene:addToUiLayer(node)
	self.uiLayer:addChild(node)
end

function BSScene:addToWindow(node)
	self.windowLayer:addChild(node)
end

function BSScene:addToGuide(node)
	self.guideLayer:addChild(node)
end

function BSScene:addToEffectLayer(node)
	self.effectLayer:addChild(node)
end

function BSScene:addToTipLayer(node)
	self.tipLayer:addChild(node)
end

function BSScene:addToLoadingLayer(node)
	self.loadingLayer:addChild(node)
end


function BSScene:receive(json)
end

function BSScene:showTip(str)
end

function BSScene:showWaitNet()
end

function BSScene:hideWaitNet()

end



return BSScene