local BSModuleAnaly = class("BSModuleAnaly")
BSModuleAnaly.switchModule 	= require("module.SwitchModule"):create()
BSModuleAnaly.otherModule 	= require("module.OtherModule"):create()
BSModuleAnaly.errorModule 	= require("module.ErrorModule"):create()   	--弹出提示框，并禁止用户一切操作
BSModuleAnaly.tipModule 	= require("module.TipModule"):create()	 	--弹出提示框	
BSModuleAnaly.openModule 	= require("module.OpenModule"):create()	 	--窗口界面
BSModuleAnaly.updateModule 	= require("module.UpdateModule"):create()	 	--更新数据

--目前只支持json格式
function BSModuleAnaly:receiveData(jsondata)
	--接收数据格式  SC_XXX_YYY  SC代表从服务端到客户端 XXX代表如下head的消息规则 YYY代表要执行的动作 
	--比如 SC_OPEN_HERO  代表打开英雄界面
	--head 规则 1.OPEN_开启新窗口 2.TIP_显示提示信息 3.UPDATE_更新数据 4.SWITCH_切换场景 5.ERROR_错误消息 6.OTHER_其他功能
	local js = json.decode(jsondata) 
	local headRule = string.split(js["head"],"_")[2]
	local headInfo = string.split(js["head"],"_")[3]


	
	if headRule == "OPEN" then
		self.openModule:receiveData(headInfo,js)
	elseif headRule == "TIP" then
		self.tipModule:receiveData(headInfo,js)
	elseif headRule == "UPDATE" then
		self.updateModule:receiveData(headInfo,js)
	elseif headRule == "SWITCH" then	
		self.switchModule:receiveData(headInfo,js)
	elseif headRule == "ERROR" then
	    self.errorModule:receiveData(headInfo,js)
	elseif headRule == "OTHER" then
		self.otherModule:receiveData(headInfo,js)
	end
end

return BSModuleAnaly