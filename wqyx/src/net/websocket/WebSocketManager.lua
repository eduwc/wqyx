local WebSocketManager = class("WebSocketManager",require ("base.net.websocket.BSWebsocket"))
WebSocketManager.websocket = nil
WebSocketManager.ip = ""

function WebSocketManager:ctor()
end


return WebSocketManager