-----------------***********登录界面********************----------------------
local SceneLogin 			= class("SceneLogin",require "base.scene.BSScene")
SceneLogin.isRegist 		= false
SceneLogin.loginScene 		= nil
SceneLogin.nodeName			= "SceneLogin"
local frame 		        = nil




function SceneLogin:init(node,nodeName)
	SceneLogin.super:init(node,nodeName)
end

function SceneLogin:onCreate()
	self:init(self,self.nodeName)
	SceneLogin.super:onCreate()

	self.loginScene = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/Login.csb")
	self:addToBgLayer(self.loginScene)
	self:loadFrame()

	local bt_tourist = G_ToolsManager:seekChildByName(self.loginScene,"bt_tourist")
		bt_tourist:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        end
	    end)

	local bt_regist = G_ToolsManager:seekChildByName(self.loginScene,"bt_regist_change")
		bt_regist:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	print("zhuce ")
 			 self.isRegist = true
 			 self.loginScene:removeChild(frame)
 			 self:loadFrame()
	        end
	    end)

	local bt_login = G_ToolsManager:seekChildByName(self.loginScene,"bt_login_change")
		bt_login:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	print("denglu ")
 			 self.isRegist = false
 			 self.loginScene:removeChild(frame)
 			 self:loadFrame()
	        end
	    end)

end


function SceneLogin:loadFrame()		
	local tf_account     = nil
	local tf_password    = nil
	if self.isRegist == false then
		local loginBtn    = nil
		frame = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/LoginFrame.csb")
		loginBtn = G_ToolsManager:seekChildByName(frame,"bt_login")
		loginBtn:addTouchEventListener(function(sender, state)
	        if state == 2 then
	            local jsLogin = {}
	            jsLogin["userName"] = tf_account:getString()
	            jsLogin["passWord"] = tf_password:getString()
         		G_HttpManager:sendLoginMessage(json.encode(jsLogin))   
	        end
	    end)
	else
		local registBtn    = nil
		frame = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/RegistFrame.csb")
		registBtn = G_ToolsManager:seekChildByName(frame,"bt_regist")
        registBtn:addTouchEventListener(function(sender, state)
	        if state == 2 then
	            local jsRegister = {}
	            jsRegister["userName"] = tf_account:getString()
	            jsRegister["passWord"] = tf_password:getString()
         		G_HttpManager:sendRegisterMessage(json.encode(jsRegister))  
	        end
	    end)
	end

	
	self.loginScene:addChild(frame)
	frame:setPosition(0,240)

    tf_account = G_ToolsManager:seekChildByName(frame,"tf_account")

    tf_password = G_ToolsManager:seekChildByName(frame,"tf_password")
  
end

function SceneLogin:receive(json)
	print(json)
end



return SceneLogin