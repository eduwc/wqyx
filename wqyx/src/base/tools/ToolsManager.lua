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



return ToolsManager