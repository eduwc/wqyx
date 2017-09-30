local DataManager = class("DataManager")
DataManager.instance = nil



function DataManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end


--��ȡר���ı�
--getType  1��ʱ�򷵻� ר���ı�������  2��ʱ�򷵻�ƴ�Ӻõ�ר���ַ����ã�����

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