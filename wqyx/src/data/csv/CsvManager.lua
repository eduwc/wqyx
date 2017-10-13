local CsvManager = class("CsvManager")
CsvManager.instance = nil
CsvManager.hero = nil
CsvManager.prop = nil


function CsvManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


--��ʼ������csv�б�
function CsvManager:ctor()
	self.hero = G_ToolsManager:getInstance():loadCsvByID("data/csv/hero.csv")
	self.prop = G_ToolsManager:getInstance():loadCsvByID("data/csv/prop.csv")			 
end

--��ȡheroCsv�б�
function CsvManager:getHeroCsv()
	return self.hero
end

--��ȡprop�б�
function CsvManager:getPropCsv()
	return self.prop
end


return CsvManager