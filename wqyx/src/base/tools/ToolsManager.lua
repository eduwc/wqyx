local ToolsManager = class("ToolsManager")
ToolsManager.instance = nil

function ToolsManager:getInstance()
	if self.instance == nil then
		self.instance = self:create()
	end
	return self.instance
end

function ToolsManager:seekChildByName(node,name)
	  local child = nil
      node:enumerateChildren("//"..name,function(needNode)
            child =  needNode
        end)
      return child
end


function ToolsManager:unicodeToUtf8(convertStr)
	local bit = require("bit")
	if type(convertStr)~="string" then
		return convertStr
		    end

		local resultStr=""
		    local i=1
		while true do

		        local num1=string.byte(convertStr,i)
		        local unicode

		        if num1~=nil and string.sub(convertStr,i,i+1)=="\\u" then
		            unicode=tonumber("0x"..string.sub(convertStr,i+2,i+5))
		            i=i+6
		elseif num1~=nil then
		            unicode=num1
		            i=i+1
		        else
		            break
		        end

		        if unicode <= 0x007f then


		            resultStr=resultStr..string.char(bit.band(unicode,0x7f))


		        elseif unicode >= 0x0080 and unicode <= 0x07ff then

		            resultStr=resultStr..string.char(bit.bor(0xc0,bit.band(bit.rshift(unicode,6),0x1f)))

		            resultStr=resultStr..string.char(bit.bor(0x80,bit.band(unicode,0x3f)))


		        elseif unicode >= 0x0800 and unicode <= 0xffff then


		            resultStr=resultStr..string.char(bit.bor(0xe0,bit.band(bit.rshift(unicode,12),0x0f)))

		            resultStr=resultStr..string.char(bit.bor(0x80,bit.band(bit.rshift(unicode,6),0x3f)))

		            resultStr=resultStr..string.char(bit.bor(0x80,bit.band(unicode,0x3f)))


		        end

    end

	resultStr=resultStr..'\0'

	return resultStr

end



--按照顺序加载 取值的时候是csv["1001"].title
--1001是表格中第一行id的名字
function ToolsManager:loadCsvByID(filePath)   
    -- 读取文件  
    local data = cc.FileUtils:getInstance():getStringFromFile(filePath);  
  
    -- 按行划分  
    local lineStr = string.split(data, '\n');  
    local titles = string.split(lineStr[1], ","); 

    local arrs = {};  
    for i = 2, #lineStr, 1 do  
        local content = string.split(lineStr[i], ",");  
 
 		lineArrs = {}
        for j = 1, #titles, 1 do  
            lineArrs[titles[j]] = content[j];  
        end  
        arrs[content[1]] = lineArrs
    end  
  
    return arrs;  
end  

--按照顺序加载 取值的时候是csv[1].title
function ToolsManager:loadCsvByOrder(filePath)   
    -- 读取文件  
    local data = cc.FileUtils:getInstance():getStringFromFile(filePath);  
  
    -- 按行划分  
    local lineStr = string.split(data, '\n');  
    local titles = string.split(lineStr[1], ","); 
    local ID = 1;  
    local arrs = {};  
    for i = 2, #lineStr, 1 do  

        local content = string.split(lineStr[i], ",");  
        arrs[ID] = {};  
        for j = 1, #titles, 1 do  
            arrs[ID][titles[j]] = content[j];  
        end  
  
        ID = ID + 1;  
    end  
  
    return arrs;  
end  




function ToolsManager:bubbleSort(arr)  
    local tmp = 0  
    for i=1,#arr-1 do  
        for j=1,#arr-i do  
            if arr[j] > arr[j+1] then  
                tmp = arr[j]  
                arr[j] = arr[j+1]  
                arr[j+1] = tmp  
            elseif arr[j] == arr[j+1] then
            	tmp = arr[j]  
                arr[j] = arr[j+1]  
                arr[j+1] = tmp 
            end  
        end  
    end 
    return arr 
end 



return ToolsManager