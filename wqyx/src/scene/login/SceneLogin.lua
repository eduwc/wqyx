-----------------***********登录界面********************----------------------
local SceneLogin 				= class("SceneLogin",require "base.scene.BSScene")
SceneLogin.isRegist 			= false
SceneLogin.loginScene 			= nil
SceneLogin.nodeName				= "SceneLogin"
SceneLogin.mLogin           	= nil
SceneLogin.frame 		    	= nil
SceneLogin.pl_selectedServer	= nil
SceneLogin.pl_serverList		= nil
SceneLogin.selectedServerID 	= nil   --选中的服务器ID
SceneLogin.userName				= nil
SceneLogin.bt_enterGame			= nil

SceneLogin.lastCheckBox			= nil   --上一个选中的checkBox
SceneLogin.lyNotice				= nil   --notic公告




-- --必须要实现
function SceneLogin:init(node,nodeName)
	SceneLogin.super:init(node,nodeName)
end

function SceneLogin:onCreate()
	--必须要调用
	self:init(self,self.nodeName)
	SceneLogin.super:onCreate()

	--可不调用，最好调用
	self.mLogin  = require ("module.login.MLogin"):create()
	self.mLogin:init(self)




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
 			 self.loginScene:removeChild(self.frame)
 			 self:loadFrame()
	        end
	    end)

	local bt_login = G_ToolsManager:seekChildByName(self.loginScene,"bt_login_change")
		bt_login:addTouchEventListener(function(sender, state)
	        if state == 2 then
	        	print("denglu ")
 			 self.isRegist = false
 			 self.loginScene:removeChild(self.frame)
 			 self:loadFrame()
	        end
	    end)

end



function SceneLogin:loadFrame()		
	local tf_account     = nil
	local tf_password    = nil
	if self.isRegist == false then
		local loginBtn    = nil
		self.frame = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/LoginFrame.csb")
		loginBtn = G_ToolsManager:seekChildByName(self.frame,"bt_login")
		loginBtn:addTouchEventListener(function(sender, state)
	        if state == 2 then
	            local jsLogin = {}
	            jsLogin["userName"] = tf_account:getString()
	            jsLogin["passWord"] = tf_password:getString()
	            self.userName = tf_account:getString()
         		G_HttpManager:sendLoginMessage(json.encode(jsLogin))   
	        end
	    end)
	else
		local registBtn    = nil
		self.frame = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/RegistFrame.csb")
		registBtn = G_ToolsManager:seekChildByName(self.frame,"bt_regist")
        registBtn:addTouchEventListener(function(sender, state)
	        if state == 2 then
	            local jsRegister = {}
	            jsRegister["userName"] = tf_account:getString()
	            jsRegister["passWord"] = tf_password:getString()
	            self.userName = tf_account:getString()
         		G_HttpManager:sendRegisterMessage(json.encode(jsRegister))  
	        end
	    end)
	end

	
	self.loginScene:addChild(self.frame)
	self.frame:setPosition(0,240)

    tf_account = G_ToolsManager:seekChildByName(self.frame,"tf_account")

    tf_password = G_ToolsManager:seekChildByName(self.frame,"tf_password")
  
end

function SceneLogin:showSelected(serverName,serverID)
	self:showNotice()
	self.selectedServerID = serverID
	self.loginScene:removeChild(self.frame)

	local pl_bottombg = G_ToolsManager:seekChildByName(self.loginScene,"pl_bottombg")
	pl_bottombg:removeAllChildren()
	

	self.pl_selectedServer = G_ToolsManager:seekChildByName(self.loginScene,"pl_selectedServer")
	self.pl_selectedServer:setVisible(true)


	local selectedServer = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/SelectedServer.csb")
	self.pl_selectedServer:addChild(selectedServer)


	local tt_serverName = G_ToolsManager:seekChildByName(selectedServer,"tt_serverName")
	tt_serverName:setString(serverName)

	--查看服务器列表
	local bt_changeServer = G_ToolsManager:seekChildByName(selectedServer,"bt_changeServer")
	bt_changeServer:addTouchEventListener(function(sender, state)
	        if state == 2 then
 			   self:showServerList()
	        end
	end)

	--进入游戏
	self.bt_enterGame = G_ToolsManager:seekChildByName(self.loginScene,"bt_enterGame")
	self.bt_enterGame:addTouchEventListener(function(sender, state)
	        if state == 2 then
 	      		local jsEnterGame = {}
	            jsEnterGame["userName"] = self.userName
	            jsEnterGame["serverID"] = self.selectedServerID
         		G_HttpManager:sendEnterGameMessage(json.encode(jsEnterGame))  
	        end
	end)
	self:controlEnterGameBtn(true)

end


function SceneLogin:controlEnterGameBtn(isShow)
	if isShow then
		self.bt_enterGame:setVisible(true)
	else
		self.bt_enterGame:setVisible(false)
	end
end




--初始化服务器列表
function SceneLogin:showServerList()
	self.pl_selectedServer:removeAllChildren()

	self.pl_serverList = G_ToolsManager:seekChildByName(self.loginScene,"pl_serverList")
	
	local serverList = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/ServerList.csb")
	self.pl_serverList:addChild(serverList)


	local sv_serverList = G_ToolsManager:seekChildByName(serverList,"sv_serverList")


	local function selectedEvent(sender,eventType)
	    if eventType == ccui.CheckBoxEventType.selected then
	    	if self.lastCheckBox ~= nil then
	    		self.lastCheckBox:setSelectedState(false)
	    	end
	    	self.lastCheckBox = sender
	    	self.selectedServerID = sender:getTag()
	    elseif eventType == ccui.CheckBoxEventType.unselected then
	    end
 	end  


	local index = 0
	for k,v in pairs(self.mLogin.serverList["serversList"]) do
		local serverIndex = index +1 --服务器ID 要从1开始

		local serverItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/Server.csb")
		
		local cb_selectServer = G_ToolsManager:seekChildByName(serverItem,"cb_selectServer")
		cb_selectServer:setTag(serverIndex)  
		cb_selectServer:addEventListenerCheckBox(selectedEvent) 

		--把上次登录过的服务器标注为打钩
		if self.selectedServerID >0 and serverIndex == self.selectedServerID then
			cb_selectServer:setSelectedState(true)
		end


		--服务器名字
		local tt_serverName = G_ToolsManager:seekChildByName(serverItem,"tt_serverName")
		tt_serverName:setString(v["name"])


		local ig_serverState = G_ToolsManager:seekChildByName(serverItem,"ig_serverState")
		if v["state"] == 1 then   --新服
			ig_serverState:loadTexture("res/ui/login/xinqu.png")
		elseif v["state"] == 2 then --火爆
			ig_serverState:loadTexture("res/ui/login/huobao.png")
		elseif v["state"] == 3 then --维护
			ig_serverState:loadTexture("res/ui/login/huobao.png") --TODO
		end
		
		sv_serverList:addChild(serverItem)
		serverItem:setPosition(0,7500-(index*75)-70)  --7500是滑动的最大高度  --70是cb_selectServer的高度
		index = index+1
	end
	

end

function SceneLogin:showNotice()
	self.lyNotice = cc.CSLoader:createNode(CSB_ADDRESS.."csb_login/Notice.csb")
	self.loginScene:addChild(self.lyNotice)


	local tt_title = G_ToolsManager:seekChildByName(self.lyNotice,"tt_title")

	local tt_content = G_ToolsManager:seekChildByName(self.lyNotice,"tt_content")
	tt_content:ignoreContentAdaptWithSize(false)
	tt_content:setSize(550, 400)
	tt_content:setAnchorPoint(0,0.5)
--	tt_content:setString("")
	

	local bt_closeNotice = G_ToolsManager:seekChildByName(self.lyNotice,"bt_closeNotice")
	bt_closeNotice:addTouchEventListener(function(sender, state)
	        if state == 2 then
 				self.loginScene:removeChild(self.lyNotice)
	        end
	end)	
end



function SceneLogin:receive(json,...)
	self.mLogin:receive(json,...)
end



return SceneLogin