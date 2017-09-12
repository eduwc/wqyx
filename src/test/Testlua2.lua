Testlua2 = {number = 10}


function Testlua2:new()
	o  = {}
	setmetatable(o,self)
	self.__index = self
	return o
end

function Testlua2:show(num)
	print("resule is "..self.number-num)
end