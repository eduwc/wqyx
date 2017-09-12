require "base.scene.BSScene"
local SceneHome = class("SceneHome",BSScene)

function SceneHome:onCreate()
	SceneHome.super:onCreate()
	local scene = cc.CSLoader:createNode("Home.csb")

	self:addToBgLayer(scene)
end

return SceneHome