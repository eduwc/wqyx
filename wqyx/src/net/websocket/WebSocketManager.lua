local WebSocketManager = class("BaseWebsocket")
local websocket = nil

function WebSocketManager:ctor()
	websocket = require ("base.net.websocket.BSWebsocket"):ctor()
end

function WebSocketManager:sendMessage(message)
	websocket:sendMessage(message)
end

return WebSocketManager