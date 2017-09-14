local WebSocketManager = class("BaseWebsocket",cc.load("mvc").AppBase)
local websocket = nil

function WebSocketManager:onCreate()
	websocket = require ("base.net.websocket.BSWebsocket"):create()
end

function WebSocketManager:sendMessage(message)
	websocket:sendMessage(message)
end

return WebSocketManager