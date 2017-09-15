local Testlua2  = class("Testlua2")
Testlua2.testlua1 = nil


-- function Testlua2:create()
-- --	self.testlua1 = require ("test.Testlua"):create()
-- --	self.testlua1:init(self)

-- 	--cc.Director:getInstance():getScheduler():scheduleScriptFunc(self.callback, 2, false)
-- end


function Testlua2:out()
	print("result-------Testlua2:out(")
end

function Testlua2:ctor()
	self.testlua1 = require ("test.Testlua"):create()
    self.testlua1:init(self)
	print("chuangjian Testlua2:ctor()")
end

function Testlua2:dtor()
	print("chuangjian Testlua2:dtor()")
end



return Testlua2