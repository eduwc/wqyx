local DataManager = class("DataManager")
DataManager.instance = nil



function DataManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


--获取专精文本
--getType  1的时候返回 专精文本的数组  2的时候返回拼接好的专精字符串用，串联

function DataManager:zhuanjinText(heroZhuanJing,getType)
	local zhuanjinArr =  string.split(heroZhuanJing,"|")
	local zhuanjinTextArr = {}
	for k,v in pairs(zhuanjinArr) do
		for m,n in pairs(G_ZHUANJING) do
			if v == m then
				table.insert(zhuanjinTextArr,n)
			end				
		end
	end	

	local zhuanjingStr = ""
	local index = 1
	for k,v in pairs(zhuanjinTextArr) do
		if index<#zhuanjinArr then
			zhuanjingStr = zhuanjingStr..v..","
		else
			zhuanjingStr = zhuanjingStr..v
		end		
		index = index+1
	end

	if getType == 1 then
		return zhuanjinTextArr
	elseif getType == 2 then
		return zhuanjingStr
	end
end




return DataManager