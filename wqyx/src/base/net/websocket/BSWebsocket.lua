local BSWebsocket = class("BSWebsocket")
local wsSendText = nil
local bsModuleAnaly = require("base.module.BSModuleAnaly"):create()
local isConnect = false

local function wsSendTextOpen(strData) 
    print("get wsSendTextOpen %s")
    isConnect = true
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

end


function BSWebsocket:connect(ip)
    G_GameLog("BSWebsocket-connect ip->"..ip)
    wsSendText = cc.WebSocket:create("ws://"..ip)     
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


    --防止还没连接成功 就发送消息
    if isConnect == false then
        local  callbackEntry = nil
        local function callback(dt)
            if isConnect == true then
                cc.Director:getInstance():getScheduler():unscheduleScriptEntry(callbackEntry)
                wsSendText:sendString(json.encode(message))
                print("sendMessage-----"..json.encode(message))
            end
        end

        callbackEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(callback,0.5,false)
    else
        wsSendText:sendString(json.encode(message))
        print("sendMessage-----"..json.encode(message))
    end

     
end


return BSWebsocket
