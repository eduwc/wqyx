local BSHttp = class("BSHttp")
BSHttp.xhr = nil
BSHttp.bsModuleAnaly = require("base.module.BSModuleAnaly"):create()





function BSHttp:ctor()
	  self.xhr = cc.XMLHttpRequest:new() -- http请求  
    self.xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING -- 响应类型  
       
end

function BSHttp:sendMessage(message)
	  print("send http message is"..message)
	  self.xhr:open("GET", message) 
	 -- 状态改变时调用  
      local function onReadyStateChange()  
      --  uniStr = string.gsub(self.xhr.response,"\\u","\\\\u")
        local utf8Str= G_ToolsManager:unicodeToUtf8(self.xhr.response)
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