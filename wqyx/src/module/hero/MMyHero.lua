local MMyHero = class("MMyHero",require "base.module.BaseModule")
MMyHero.moduleName			= "MMyHero"
MMyHero.propCsv 			= nil
MMyHero.vMyHero 			= nil
MMyHero.heroServerInfo 		= nil


function MMyHero:connectView(node)
	self.vMyHero = node
end

function MMyHero:init(module,moduleName)	
	MMyHero.super:init(module,moduleName)
end

function MMyHero:ctor()
	self:init(self,self.moduleName)
	self.propCsv = G_CsvManager:getInstance():getPropCsv()
end


function MMyHero:receive(msg,head)
	if head == RESPONDHERO then
		self.heroServerInfo = msg["heroServerInfo"]
		self.vMyHero:initHeroList(msg["calledHero"])
	elseif head == "QIANGHUA" then
		self.vMyHero.qiangHuaView:updateQiangHuaInfo()
	elseif head == "JINJIE" then
		self.vMyHero.jinJieView:updateJinJieInfo()
	end
end

--获取强化所需要的道具图片ID
function MMyHero:getQiangHuaItemPicID(id)
	return self.propCsv[id]["img2_id"]	
end

function MMyHero:getQiangHuaItemName(id)
	return self.propCsv[id]["prop_name"]	
end


--和上面的功能是一样的，上面由于取名疏忽，所以后更新成下面的名字
--获取道具图片ID
function MMyHero:getItemPicID(id)
	return self.propCsv[id]["img2_id"]	
end

--获取道具名字
function MMyHero:getItemName(id)
	return self.propCsv[id]["prop_name"]	
end


--获取强化所需要的道具数量
function MMyHero:getQiangHuaItemNumber(qianghuaLV)
	if 	qianghuaLV == 0 then
		return 1
	elseif qianghuaLV == 1 then
		return 2
	elseif qianghuaLV == 2 then
		return 3
	elseif qianghuaLV == 3 then
		return 4
	elseif qianghuaLV == 4 then	
		return 5
	end
end

--获取强化升级所需要的金钱数
function MMyHero:getQiangHuaGold(qianghuaLV,callLv)
	if 	qianghuaLV == 0 then
		return 1000*callLv*callLv
	elseif qianghuaLV == 1 then
		return 2000*callLv*callLv
	elseif qianghuaLV == 2 then
		return 5000*callLv*callLv
	elseif qianghuaLV == 3 then
		return 10000*callLv*callLv
	elseif qianghuaLV == 4 then	
		return 20000*callLv*callLv
	end
end

--获取强化增加战力
function MMyHero:getQiangHuaZhanLi(qianghuaLV)
	if 	qianghuaLV == 0 then
		return "战力+%0"
	elseif 	qianghuaLV == 1 then
		return "战力+%10"
	elseif qianghuaLV == 2 then
		return "战力+%30"
	elseif qianghuaLV == 3 then
		return "战力+%60"
	elseif qianghuaLV == 4 then
		return "战力+%100"
	elseif qianghuaLV == 5 then	
		return "战力+%200"
	end
end


--获取进阶所需要的道具数量
function MMyHero:getJinJieItemNumber(jinjieLV)
	return jinjieLV+1
end

--获取进阶战力
function MMyHero:getJinJieZhanLi(jinjieLV)
	return jinjieLV*10
end

--获取进阶需要的金币
function MMyHero:getJinJieGold(jinjieLV,callLv)
	local jinjieLV = jinjieLV+1
	return 100*jinjieLV*jinjieLV*callLv*callLv
end


function MMyHero:getJinJieInfo(heroID)
	return self.heroServerInfo[heroID]["jinjieLv"]
end

function MMyHero:getQiangHuaInfo(heroID)
	return self.heroServerInfo[heroID]["qiangHuaLv"]
end

function MMyHero:getExpInfo(heroID)
	return self.heroServerInfo[heroID]["exp"]
end

function MMyHero:getLvInfo(heroID)
	return self.heroServerInfo[heroID]["lv"]
end


return MMyHero