local WMaoXianDuiLie = class("WMaoXianDuiLie",require "base.view.BaseNode")
WMaoXianDuiLie.nodeName				= "WMaoXianDuiLie"
WMaoXianDuiLie.mMaoXian 			= nil
WMaoXianDuiLie.duiLieView 			= nil
WMaoXianDuiLie.bt_duiLiePage 		= nil
WMaoXianDuiLie.bt_maoXianPage 		= nil
WMaoXianDuiLie.maoXianView 			= nil

-- --必须要实现
function WMaoXianDuiLie:init(node,nodeName)
	WMaoXianDuiLie.super:init(node,nodeName)
end

function WMaoXianDuiLie:ctor()
	--必须要调用
	self:init(self,self.nodeName)
	WMaoXianDuiLie.super:ctor()

	-- --可不调用，最好调用
	self.mMaoXian  = require ("module.maoXian.MMaoXian"):create()
	self.mMaoXian:connectView(self)


	self.duiLieView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianDuiLie.csb")
	self:addChild(self.duiLieView)

	--初始化冒险
	self.maoXianView = require("scene.window.maoXian.WMaoXian"):create()
	self.maoXianView:setVisible(false)
	self:addChild(self.maoXianView)


	self.bt_duiLiePage = G_ToolsManager:seekChildByName(self.duiLieView,"bt_duiLiePage")	
	self.bt_duiLiePage:addTouchEventListener(function(sender, state)
	        if state == 2 then
		        self:changePage(1)
	        end
	end)	
	self.bt_maoXianPage = G_ToolsManager:seekChildByName(self.duiLieView,"bt_maoXianPage")	
	self.bt_maoXianPage:addTouchEventListener(function(sender, state)
	        if state == 2 then
		        self:changePage(2)
	        end
	end)


	self.sv_duiLieBg = G_ToolsManager:seekChildByName(self.duiLieView,"sv_duiLieBg")	


end


function WMaoXianDuiLie:changePage(pageID)
	if pageID == 1 then
		G_ToolsManager:setBtnState(self.bt_duiLiePage,false)
		G_ToolsManager:setBtnState(self.bt_maoXianPage,true)


		self.maoXianView:setVisible(false)
		self.sv_duiLieBg:setVisible(true)
	elseif pageID == 2 then
		G_ToolsManager:setBtnState(self.bt_duiLiePage,true)
		G_ToolsManager:setBtnState(self.bt_maoXianPage,false)

		self.sv_duiLieBg:setVisible(false)
		self.maoXianView:setVisible(true)

	end
end


return WMaoXianDuiLie