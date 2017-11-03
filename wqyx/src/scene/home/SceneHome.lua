local SceneHome = class("SceneHome",require "base.view.BSScene")
SceneHome.nodeName				= "SceneHome"
SceneHome.mHome					= nil
SceneHome.sceneHome 			= nil
SceneHome.tip 					= nil
SceneHome.pl_waitNet  			= nil

-- --必须要实现
function SceneHome:init(node,nodeName)
	SceneHome.super:init(node,nodeName)
end

function SceneHome:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	SceneHome.super:ctor()

	--可不调用，最好调用
	self.mHome  = require ("module.home.MHome"):create()
	self.mHome:connectView(self)

	self.sceneHome = cc.CSLoader:createNode(CSB_ADDRESS.."csb_home/Home.csb")
	self:addToBgLayer(self.sceneHome)


	--英雄
	local bt_hero = G_ToolsManager:seekChildByName(self.sceneHome,"bt_hero")
	bt_hero:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	--请求打开hero窗口
	        	local jsMsg = {}
	            jsMsg["head"] = CS_DPHeroView
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)	

	--道具
	local bt_item = G_ToolsManager:seekChildByName(self.sceneHome,"bt_item")
	bt_item:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	--请求打开道具窗口
	        	local jsMsg = {}
	            jsMsg["head"] = CS_DPItem
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)

	--冒险
	local bt_adventure = G_ToolsManager:seekChildByName(self.sceneHome,"bt_adventure")
	bt_adventure:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	--请求打开道具窗口
	        	local jsMsg = {}
	            jsMsg["head"] = CS_DPMaoXianDuiLie
             	G_WebSocketManager:sendMessage(jsMsg)
	        end
	end)

	


	--*****************初始化场景必须资源**************************
	self.tip = cc.CSLoader:createNode(CSB_ADDRESS.."csb_public/Tip.csb")
	self.tip:setVisible(false)
	self:addToTipLayer(self.tip)


	local waitNet = cc.CSLoader:createNode(CSB_ADDRESS.."csb_public/WaitNet.csb")
	self.pl_waitNet   =  G_ToolsManager:seekChildByName(waitNet,"pl_waitNet")	
	self.pl_waitNet:setVisible(false)
	self:addToLoadingLayer(waitNet)	


end


function SceneHome:showTip(str)
	local tt_tip   =  G_ToolsManager:seekChildByName(self.tip,"tt_tip")
	tt_tip:setString(str)
	self.tip:setPosition(0,300)
	self.tip:setVisible(true)

	local  callbackEntry = nil
	local function callback(dt)
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(callbackEntry)
		self.tip:setVisible(false)
	end

	callbackEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(callback, 1, false)
end


function SceneHome:showWaitNet()
	self.pl_waitNet:setVisible(true)	
end

function SceneHome:hideWaitNet()
	self.pl_waitNet:setVisible(false)
end



return SceneHome