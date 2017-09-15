local HttpManager = class("HttpManager",require ("base.net.http.BSHttp"))
HttpManager.instance = nil

function HttpManager:getInstance()
    if self.instance == nil then
        self.instance = self:create()
    end
    return self.instance
end

function HttpManager:onCreate()
	  HttpManager.super:onCreate()
end

--messageHead 代表参数头  默认userInfo=
function HttpManager:sendMessage(host,message,messageHead)
	local messageFull = "" 
   --base64加密 需要时候开启
    if BASE64_USE == true then
         require("mime")
         message=mime.b64(message)
    end
    if messageHead == nil then
    	messageFull = "userInfo="..message
    else
    	messageFull = messageHead..message
    end
	HttpManager.super:sendMessage(host..messageFull)
end



function HttpManager:sendRegisterMessage(message)
	self:sendMessage("http://localhost/wqyxweb/login/WqyxYMRegist.php?",message)	
end


function HttpManager:sendLoginMessage(message)
	self:sendMessage("http://localhost/wqyxweb/login/WqyxYMLogin.php?",message)
end

return HttpManager