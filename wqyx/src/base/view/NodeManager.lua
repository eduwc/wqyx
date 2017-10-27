local NodeManager  			= class("NodeManager")
NodeManager.nodeTable 		= {}
NodeManager.instance 		= nil


function NodeManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end

function NodeManager:addNode(node,nodeName)
	if nodeName == nil then
		error("your nodeName is nil")
		return
	else
		self.nodeTable[nodeName] = node
		G_GameLog("NodeManager-addNode NodeName is->"..nodeName)
	end

end

function NodeManager:notify(json,nodeName,...)
    if nodeName == nil then
		error("your nodeName is nil")
		return
	else
		self.nodeTable[nodeName]:receive(json,...)
	end
end

function NodeManager:removeNode(nodeName)
	self.nodeTable[nodeName] = nil
end

function NodeManager:removeAllNode()
	if self.nodeTable ~= nil then
		for k,v in pairs(self.nodeTable) do
			v = nil
		end
	end
end


function NodeManager:getNodeCount()
	local count = 0  
	for k,v in pairs(self.nodeTable) do  
	    count = count + 1  
	end  
	return count
end


return NodeManager