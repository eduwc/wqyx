
local Testlua  = class("Testlua",cc.load("mvc").AppBase)



-- function Testlua:create()
-- 	-- body
-- end

function Testlua:init(node)
	G_Test = node
end

function Testlua:out()
	print("result-------Testlua:out()")
end

return Testlua