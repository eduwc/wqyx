Testlua = Testlua2:new()


function Testlua:setNumber(nu)
	self.number = nu
end

function Testlua:out()
	print("result-------"..self.number)
end