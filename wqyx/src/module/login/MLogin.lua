local MLogin = class("MLogin",require "base.module.BaseModule")
MLogin.moduleName	= "MLogin"
MLogin.vLogin 		= nil
MLogin.serverList 	= nil  --服务器列表数据


function MLogin:connectView(node)
	self.vLogin = node
end

function MLogin:init(module,moduleName)	
	MLogin.super:init(module,moduleName)
end

function MLogin:ctor()
	self:init(self,self.moduleName)
end


function MLogin:receive(msg,head)
	if head == "SERVERLIST" then
		self.serverList = msg["list"]
		if msg["lastServerID"] >0 then   --上次选择过服务器 默认显示
			self.vLogin:showSelected(self.serverList["serversList"][msg["lastServerID"]]["name"],msg["lastServerID"])
		else
			self.vLogin:showSelected(self.serverList["serversList"][1]["name"],msg["lastServerID"])
		end	
	end

end


function MLogin:getIp(serverID)
	return self.serverList["serversList"][serverID]["ip"]
end



return MLogin