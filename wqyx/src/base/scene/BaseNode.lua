local BaseNode = class("BaseNode",cc.load("mvc").AppBase)
BaseNode.nodeName = nil


function BaseNode:receive(json)
	
end

-- function BaseNode:onCreate()
-- 	G_NodeManager:addNode(self)
-- end

function BaseNode:init(node,nodeName)
	G_NodeManager:addNode(self,nodeName)
end


return BaseNode