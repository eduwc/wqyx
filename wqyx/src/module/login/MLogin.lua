local MLogin = class("MLogin",cc.load("mvc").AppBase)
MLogin.vLogin = nil


function MLogin:init(node)
	self.vLogin = node
end

function MLogin:receive(msg)
	self.vLogin:initList()
end


return MLogin