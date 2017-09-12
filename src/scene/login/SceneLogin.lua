local SceneLogin = class("SceneLogin",require "base.scene.BSScene")


function SceneLogin:onCreate()
	SceneLogin.super:onCreate()

	    local scene = cc.CSLoader:createNode("MainScene.csb")

	self:addToBgLayer(scene)

    local account = scene:getChildByName("TF_Account")
    account:setString("输入账号")

     local passWord = scene:getChildByName("TF_PassWord")
     passWord:setString("输入密码")


	    local btn = scene:getChildByName("Button_Confirm")
        btn:addTouchEventListener(function(sender, state)
	        if state == 0 then
	        
	        elseif state == 1 then
	        
	        elseif state == 2 then	   
	        	local jsRegister = {}
	            jsRegister["userName"] = account:getString()
	            jsRegister["passWord"] = passWord:getString()
         		require ("net.http.HttpManager"):create():sendRegisterMessage(json.encode(jsRegister))   
	        else
	         
	        end
	    end)


	    local LoginBtn = scene:getChildByName("Button_Login")
        LoginBtn:addTouchEventListener(function(sender, state)
	        if state == 0 then
	             account:setString("began")
	        elseif state == 1 then
	            account:setString("moved")
	        elseif state == 2 then
	   

	        	local js = {}
	            js["head"] = "DPLogin"
	            js["userName"] = account:getString()
	            js["passWord"] = passWord:getString()
	             G_WebSocketManager:sendMessage(js)

	        else
	            account:setString("cancelled")
	        end
	    end)
end

return SceneLogin