local CsvManager = class("CsvManager")
CsvManager.instance = nil
CsvManager.hero = nil


function CsvManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


--初始化所有csv列表
function CsvManager:ctor()
	self.hero = G_ToolsManager:getInstance():loadCsvByID("data/csv/hero.csv")	 
end

--获取heroCsv列表
function CsvManager:getHeroCsv()
	return self.hero
end


return CsvManager