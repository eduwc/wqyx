local BSScene = class("BSScene",require "base.scene.BaseNode")
BSScene.gameScene		= nil
BSScene.bgLayer 		= nil    --背景层
BSScene.uiLayer 		= nil	 --UI层	
BSScene.windowLayer 	= nil	 --窗口层
BSScene.guideLayer 		= nil    --引导层
BSScene.effectLayer 	= nil    --特效层
BSScene.tipLayer 		= nil    --消息提示层

function BSScene:init(node,nodeName)
	BSScene.super:init(node,nodeName)
end


function BSScene:onCreate()
	self.gameScene = cc.Scene:create()
	--cc.Director:getInstance():getRunningScene()
	cc.Director:getInstance():replaceScene(self.gameScene)

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



return BSScene