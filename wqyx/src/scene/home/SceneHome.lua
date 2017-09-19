require "base.scene.BSScene"
local SceneHome = class("SceneHome",BSScene)

function SceneHome:ctor()
	SceneHome.super:ctor()
	local scene = cc.CSLoader:createNode("Home.csb")

	self:addToBgLayer(scene)
end

return SceneHome