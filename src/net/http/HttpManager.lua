local HttpManager = class("HttpManager",require ("base.net.http.BSHttp"))

function HttpManager:onCreate()
	  HttpManager.super:onCreate()
end

--messageHead 代表参数头  默认userInfo=
function HttpManager:sendMessage(host,message,messageHead)
	local messageFull = nil 
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
	self:sendMessage("http://127.0.0.1/wqyxweb/login/WqyxYMRegist.php?",message)	
end


function HttpManager:sendLoginMessage(message)
	self:sendMessage("http://127.0.0.1/wqyxweb/login/WqyxYMLogin.php?"..message)
end

return HttpManager