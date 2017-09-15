local OtherModule = class("OtherModule",cc.load("mvc").AppBase)


function OtherModule:receiveData(head,jsondata)	
	if head == "SERVERLIST" then
		print("OtherModule")
		print(jsondata["list"]["serversList"][1]["ip"])
		G_NodeManager:notify(jsondata["list"],"SceneLogin")
	end
end


return OtherModule