local VHeroList = class("VHeroList",require "base.view.BaseNode")
VHeroList.heroListView 	= 	nil

function VHeroList:ctor(heroList)
	self.heroListView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroList.csb")
	self:addChild(self.heroListView)

	local heroListLen = G_ToolsManager:getTableLen(heroList)

	local sv_heroList = G_ToolsManager:seekChildByName(uncallItem,"sv_heroList")
	local scrollviewHeight = heroListLen*150
	sv_heroList:setInnerContainerSize(cc.size(640,scrollviewHeight))


	
	local  index  = 0
	for k,v in pairs(heroList) do
		local heroInfo = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroList.csb")
		heroInfo:setPosition(0,scrollviewHeight-(index*150))
		self.heroListView:addChild(heroInfo)

		local ig_heroListHeroHead = G_ToolsManager:seekChildByName(uncallItem,"ig_heroListHeroHead")
		local ig_heroListStar = G_ToolsManager:seekChildByName(uncallItem,"ig_heroListStar")
		local tt_heroListHeroLv = G_ToolsManager:seekChildByName(uncallItem,"tt_heroListHeroLv")
		local tt_heroListHeroTitle = G_ToolsManager:seekChildByName(uncallItem,"tt_heroListHeroTitle")
		local tt_heroListHeroZhanLi = G_ToolsManager:seekChildByName(uncallItem,"tt_heroListHeroZhanLi")

		local pl_liaoYang = G_ToolsManager:seekChildByName(uncallItem,"pl_liaoYang")
		local tt_liaoYangTime = G_ToolsManager:seekChildByName(uncallItem,"tt_liaoYangTime")


		local tt_liaoYangTime = G_ToolsManager:seekChildByName(uncallItem,"tt_liaoYangTime")
		local bt_tianJia = G_ToolsManager:seekChildByName(uncallItem,"bt_tianJia")
		local ig_difficulty = G_ToolsManager:seekChildByName(uncallItem,"ig_difficulty")


		index = index +1
	end

end

return VHeroList