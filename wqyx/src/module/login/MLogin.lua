local MLogin = class("MLogin",cc.load("mvc").AppBase)
MLogin.vLogin 		= nil
MLogin.serverList 	= nil  --服务器列表数据


function MLogin:init(node)
	self.vLogin = node
end

function MLogin:receive(msg)
	self.serverList = msg["list"]
	if msg["lastServerID"] >0 then   --上次选择过服务器 默认显示
		self.vLogin:showSelected(self.serverList["serversList"][msg["lastServerID"]]["name"],msg["lastServerID"])
	else
		self.vLogin:showSelected(self.serverList["serversList"][1]["name"],msg["lastServerID"])
	end

	
end


return MLogin