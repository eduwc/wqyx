local MLogin = class("MLogin",cc.load("mvc").AppBase)
MLogin.vLogin 		= nil
MLogin.serverList 	= nil  --�������б�����


function MLogin:init(node)
	self.vLogin = node
end

function MLogin:receive(msg)
	self.serverList = msg["list"]
	if msg["lastServerID"] >0 then   --�ϴ�ѡ��������� Ĭ����ʾ
		self.vLogin:showSelected(self.serverList["serversList"][msg["lastServerID"]]["name"],msg["lastServerID"])
	else
		self.vLogin:showSelected(self.serverList["serversList"][1]["name"],msg["lastServerID"])
	end

	
end


return MLogin