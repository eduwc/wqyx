local CsvManager = class("CsvManager")
CsvManager.instance 			= nil
CsvManager.hero 				= nil
CsvManager.prop 				= nil
CsvManager.hero_friendship		= nil
CsvManager.forge_exp 			= nil
CsvManager.dilatation_up 		= nil
CsvManager.risk 				= nil
CsvManager.risk_level 			= nil
CsvManager.risk_levelInfo 		= {}  --按照risk_id排列

function CsvManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


--初始化所有csv列表
function CsvManager:ctor()
	self.hero 				= G_ToolsManager:getInstance():loadCsvByID("data/csv/hero.csv")
	self.prop 				= G_ToolsManager:getInstance():loadCsvByID("data/csv/prop.csv")
	self.hero_friendship 	= G_ToolsManager:getInstance():loadCsvByID("data/csv/hero_friendship.csv")	
	self.forge_exp 			= G_ToolsManager:getInstance():loadCsvByID("data/csv/forge_exp.csv")	
	self.dilatation_up 		= G_ToolsManager:getInstance():loadCsvByID("data/csv/dilatation_up.csv")	
	self.risk 				= G_ToolsManager:getInstance():loadCsvByID("data/csv/risk.csv")	
	self.risk_level 		= G_ToolsManager:getInstance():loadCsvByID("data/csv/risk_level.csv")		
	self:setMaoXianLevelInfo() 
end

--*****************英雄**************************

--获取heroCsv列表
function CsvManager:getHeroCsv()
	return self.hero
end

function CsvManager:getHeroImg2(heroID)
	return self.hero[heroID]["hero_img2"]
end


--获取hero_friendship列表
function CsvManager:hero_friendship()
	return self.hero_friendship
end


--*****************道具**************************


--获取prop列表
function CsvManager:getPropCsv()
	return self.prop
end


--获取道具图片ID
function CsvManager:getItemPicID(id)
	return self.prop[id]["img2_id"]	
end

--获取道具名字
function CsvManager:getItemName(id)
	return self.prop[id]["prop_name"]	
end

--获取道具初始战力
function CsvManager:getOriginalZhanLi(id)
	return self.prop[id]["prop_power"]	
end


--*****************锻造**********************
--获取锻造熟练度增加的属性
function CsvManager:getShuLianAddProperty(id)
	return self.forge_exp[id]["award_num"]	
end

--获取一件装备锻造集合
function CsvManager:getDuanZaoArr(id)
	local equipItemArr = {}
	for k,v in pairs(self.forge_exp) do
		if v["prop_id"] == id then
			table.insert(equipItemArr,v)
		end
	end

	local function expLevelSort(a,b)
		return tonumber(a["forge_exp_level"])<tonumber(b["forge_exp_level"])
	end

	table.sort(equipItemArr,expLevelSort)
	return equipItemArr
end


--*****************扩容**********************
--kuoRongType 扩容类型
--1-资源仓库数量
--2-资源各资源上限
--3-道具装备数量
--4-英雄数量
--10-锻造栏
--11-冒险队列
function CsvManager:getKuoRong(kuoRongType)
	local kuoRongArr = {}
	for k,v in pairs(self.dilatation_up) do
		if v["dilatation_up_type"] == kuoRongType then
			table.insert(kuoRongArr,v)
		end
	end

	--从小到大排序
	local function kuoRongsort(a,b)
		local kuoRongValue = nil
		kuoRongValue = tonumber(a["dilatation_up_level"])<tonumber(b["dilatation_up_level"])	
		return kuoRongValue
	end

	table.sort(kuoRongArr,kuoRongsort)
	return kuoRongArr	
end

--*****************冒险**********************
--获取冒险副本总数
function CsvManager:getMaoXianNumber()
	return G_ToolsManager:getTableLen(self.risk)	
end

function CsvManager:getMaoXianCsv()
	return self.risk
end

function CsvManager:getMaoXianImg1(id)
	return self.risk[id]["risk_img1"]
end

function CsvManager:getMaoXianImg2(id)
	return self.risk[id]["risk_img2"]
end

function CsvManager:getMaoXianRecuperateCd(id)
	return self.risk[id]["risk_recuperate_cd"]
end

function CsvManager:getMaoXianRiskRecommendPower(id)
	return self.risk[id]["risk_recommend_power"]
end


function CsvManager:setMaoXianLevelInfo()
	local maoXianNumber = self:getMaoXianNumber()
	for i=1,maoXianNumber do
		local mapID = 90000+i
		local mapLvArr = {}
		for k,v in pairs(self.risk_level) do
			if v["risk_id"] == tostring(mapID) then
				table.insert(mapLvArr,v)
			end
		end

		--从小到大排序
		local function maoXianSort(a,b)
			local value = nil
			value = tonumber(a["risk_up_level"])<tonumber(b["risk_up_level"])	
			return value
		end

		table.sort(mapLvArr,maoXianSort)
		self.risk_levelInfo[tostring(mapID)] = mapLvArr
	end

end

function CsvManager:getMaoXianUpLevelNum(mapID,maoXianLv)
	return self.risk_levelInfo[mapID][maoXianLv]["risk_up_level_num"]
end

function CsvManager:getMaoXianPropNum1(mapID,maoXianLv)
	return self.risk_levelInfo[mapID][maoXianLv]["risk_drop_prop_num1"]
end

function CsvManager:getMaoXianPropNum2(mapID,maoXianLv)
	return self.risk_levelInfo[mapID][maoXianLv]["risk_drop_prop_num2"]
end

function CsvManager:getMaoXianPropNum2(mapID,maoXianLv)
	return self.risk_levelInfo[mapID][maoXianLv]["risk_drop_prop_num2"]
end



return CsvManager