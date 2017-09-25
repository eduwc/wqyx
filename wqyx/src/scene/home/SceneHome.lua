local SceneHome = class("SceneHome",require "base.view.BSScene")
SceneHome.nodeName				= "SceneHome"
SceneHome.mHome					= nil
SceneHome.sceneHome 			= nil

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
end

return SceneHome