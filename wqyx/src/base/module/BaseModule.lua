local BaseModule = class("MLogin")
BaseModule.moduleName = nil


function BaseModule:receive(json)
end


function BaseModule:init(module,moduleName)
	G_ModuleManager:addModule(module,moduleName)
end


return BaseModule