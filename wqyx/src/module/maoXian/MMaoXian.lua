local MMaoXian = class("MMaoXian",require "base.module.BaseModule")
MMaoXian.moduleName			= "MMaoXian"
MMaoXian.vMaoXianDuiLie 	= nil
MMaoXian.calledHeroArr 		= nil
MMaoXian.qiangHuaLvArr 		= nil
MMaoXian.jinjieLvArr		= nil
MMaoXian.heroExpArr 		= nil
MMaoXian.heroLvArr 			= nil
MMaoXian.xiuYangTimeArr 	= nil
MMaoXian.callHeroInfoArr    = {}
MMaoXian.maoXianInfo 		= nil




function MMaoXian:connectView(node)
	self.vMaoXianDuiLie = node
end

function MMaoXian:init(module,moduleName)	
	MMaoXian.super:init(module,moduleName)
end

function MMaoXian:ctor()
	self:init(self,self.moduleName)
end

function MMaoXian:receive(msg,head)
	if head == "MAOXIAN" then
		self.calledHeroArr 		= string.split(msg["calledInfo"],";")
		self.qiangHuaLvArr 		= string.split(msg["qiangHuaLv"],";")
		self.jinjieLvArr 		= string.split(msg["jinjieLv"],";")
		self.heroExpArr		 	= string.split(msg["exp"],";")
		self.heroLvArr 			= string.split(msg["lv"],";")
		self.xiuYangTimeArr 	= string.split(msg["xiuYangTime"],";")
		self.maoXianInfo 		= msg["maoXianInfo"]
		G_CURRENTTIMEMILLIS 	= msg["currentTimeMillis"]

		for i=1,#self.calledHeroArr do
			local infoTab = {}
			infoTab["qiangHuaLv"] 		= self.qiangHuaLvArr[i]
			infoTab["jinjieLv"] 		= self.jinjieLvArr[i]
			infoTab["heroExp"] 			= self.heroExpArr[i]
			infoTab["heroLv"] 			= self.heroLvArr[i]
			infoTab["xiuYangTime"] 		= self.xiuYangTimeArr[i]
			infoTab["isConfiguration"] 	= 0
			infoTab["heroID"] 			= self.calledHeroArr[i]   --特殊用途

			self.callHeroInfoArr[self.calledHeroArr[i]] = infoTab
		end

		self.vMaoXianDuiLie:initDuiLie(self:getMaoXianInfo())
	elseif head == "BEGINMAOXIAN" then

	end
end

function MMaoXian:getCalledHeroInfo()
	return self.callHeroInfoArr
end

--configState 0.没有配置 1.已经配置
function MMaoXian:setHeroConfigState(heroID,configState)
	if heroID~= "" then
		self.callHeroInfoArr[heroID]["isConfiguration"] = configState
	end	
end


function MMaoXian:getCalledHero(index)
	return self.calledHeroArr[index]
end

function MMaoXian:getQiangHuaLv(index)
	return self.qiangHuaLvArr[index]
end

function MMaoXian:getJinJieLv(index)
	return self.jinjieLvArr[index]
end

function MMaoXian:getHeroExp(index)
	return self.heroExpArr[index]
end

function MMaoXian:getHeroLv(index)
	return self.heroLvArr[index]
end

function MMaoXian:xiuYangTime(index)
	return self.xiuYangTimeArr[index]
end

function MMaoXian:getMaoXianInfo()
	return self.maoXianInfo
end


function MMaoXian:addZhanLi(number)
	if number == 1 then
		return "0%"
	else 
		return ""..(number-1).."0%"
	end
	
end

function MMaoXian:getOpenStr(index)
	if index < 5 then
		return ""..((index-1)*10).."级解锁"
	elseif index == 5 then
		return "50级解锁"
	end
end



return MMaoXian