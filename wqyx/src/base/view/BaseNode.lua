local BaseNode = class("BaseNode")
BaseNode.nodeName = nil


function BaseNode:receive(json)
end


function BaseNode:init(node,nodeName)
	G_NodeManager:addNode(node,nodeName)
end


return BaseNode