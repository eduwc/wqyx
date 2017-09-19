local BSWebsocket = class("BSWebsocket")
local wsSendText = nil
local bsModuleAnaly = require("base.module.BSModuleAnaly"):create()

local function wsSendTextOpen(strData) 


end 
  
local function wsSendTextMessage(strData) 
   print("get messagessssss %s"..strData)  
    -- local strInfo= "response text msg: "
    -- local str = json.decode(strData) 
    -- print("jieguy"..str["name"]) 
    -- print("get message %s"..strData)   
    bsModuleAnaly:receiveData(strData) 
end 
  
local function wsSendTextClose(strData) 
    print("_wsiSendText websocket instance closed.") 
    wsSendText = nil 
end 
  
local function wsSendTextError(strData) 
    print("sendText Error was fired") 
end 


function BSWebsocket:ctor()
    wsSendText = cc.WebSocket:create("ws://127.0.0.1:9635")     
	if nil ~= wsSendText then 
	    wsSendText:registerScriptHandler(wsSendTextOpen,cc.WEBSOCKET_OPEN) 
	    wsSendText:registerScriptHandler(wsSendTextMessage,cc.WEBSOCKET_MESSAGE) 
	    wsSendText:registerScriptHandler(wsSendTextClose,cc.WEBSOCKET_CLOSE) 
	    wsSendText:registerScriptHandler(wsSendTextError,cc.WEBSOCKET_ERROR) 
	end 
end


function BSWebsocket:sendMessage(message)

     --base64加密 需要时候开启
     if BASE64_USE == true then
         require("mime")
         message=mime.b64(message)
     end


     wsSendText:sendString(json.encode(message)) 
     print("sendMessage-----"..json.encode(message))
end


return BSWebsocket
