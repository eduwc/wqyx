local WMaoXian = class("WMaoXian",require "base.view.BaseNode")
WMaoXian.nodeName				= "WMaoXian"
WMaoXian.MaoXianView 			= nil


-- --必须要实现
function WMaoXian:init(node,nodeName)
	WMaoXian.super:init(node,nodeName)
end


function WMaoXian:ctor()
	self.MaoXianView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianView.csb")
	self:addChild(self.MaoXianView)
end

return WMaoXian