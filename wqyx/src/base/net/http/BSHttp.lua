local BSHttp = class("BSHttp",cc.load("mvc").AppBase)
BSHttp.xhr = nil
BSHttp.bsModuleAnaly = require("base.module.BSModuleAnaly"):create()


local bit = require("bit")

local function unicode_to_utf8(convertStr)


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


        print(unicode)

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

    print(resultStr)

return resultStr

end


function BSHttp:onCreate()
	  self.xhr = cc.XMLHttpRequest:new() -- http请求  
    self.xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  
       
end

function BSHttp:sendMessage(message)
	  print("send http message is"..message)
	  self.xhr:open("GET", message) 
	 -- 状态改变时调用  
      local function onReadyStateChange()  
      --  uniStr = string.gsub(self.xhr.response,"\\u","\\\\u")
        local utf8Str=unicode_to_utf8(self.xhr.response)
        -- 显示状态文本  
        local statusString = "Http Status Code:"..self.xhr.statusText  
        print("http get statusString is"..statusString)  
        print("http get message is"..utf8Str) 
        self.bsModuleAnaly:receiveData(utf8Str) 
      end  
  
      -- 注册脚本回调方法  
      self.xhr:registerScriptHandler(onReadyStateChange)  
      self.xhr:send() -- 发送请求 
end


return BSHttp