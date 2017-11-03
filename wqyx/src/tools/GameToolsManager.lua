local GameToolsManager = class("GameToolsManager")
GameToolsManager.instance = nil


function GameToolsManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


function GameToolsManager:getColor(colorType)
	if colorType == "WHITE" then
		return cc.c3b(255,255,255)
	elseif colorType == "GREEN" then
		return cc.c3b(25,165,25)
	elseif colorType == "BLUE" then
		return cc.c3b(42,72,187)
	elseif colorType == "PURPLE" then
		return cc.c3b(83,63,165)
	elseif colorType == "ORANGE" then
		return cc.c3b(202,103,42)		
	elseif colorType == "RED" then
		return cc.c3b(255,0,0)				
	else
		return cc.c3b(255,255,255)
	end

end


--根据0级白色，1级-绿色，2级-蓝色，3级-紫色，4级-橙色，5级-红色
function GameToolsManager:getColorByLV(colorLv)
	if colorLv == 0 then
		return self:getColor("WHITE")
	elseif colorLv == 1 then
		return  self:getColor("GREEN")
	elseif colorLv == 2 then
		return self:getColor("BLUE")
	elseif colorLv == 3 then
		return  self:getColor("PURPLE")
	elseif colorLv == 4 then
		return  self:getColor("ORANGE")		
	elseif colorLv == 5 then
		return  self:getColor("RED")				
	else
		return self:getColor("WHITE")
	end
end

return GameToolsManager