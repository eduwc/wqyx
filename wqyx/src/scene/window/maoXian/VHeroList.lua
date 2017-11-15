local VHeroList = class("VHeroList",require "base.view.BaseNode")
VHeroList.heroListView 		= 	nil
VHeroList.schedulerEntry 	=   nil
VHeroList.surplusTimeArr 	=   {}
VHeroList.heroInfoCsbArr 	=   {}
VHeroList.wMaoXian 			=   nil

function VHeroList:ctor(wMaoXian,heroList)
	self.wMaoXian  = wMaoXian
	self.heroListView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroList.csb")
	self:addChild(self.heroListView)

	local heroListLen = #heroList

	local sv_heroList = G_ToolsManager:seekChildByName(self.heroListView,"sv_heroList")
	local scrollviewHeight = heroListLen*150
	if scrollviewHeight<900 then
		scrollviewHeight = 900
	end
	sv_heroList:setInnerContainerSize(cc.size(640,scrollviewHeight))


	
	local  index  = 1
	for k,heroInfo in pairs(heroList) do
		if heroInfo["isConfiguration"] == 0 then
			local heroInfoCsb = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroListItem.csb")
			heroInfoCsb:setPosition(0,scrollviewHeight-(index*150))
			self.heroListView:addChild(heroInfoCsb)

			local ig_heroListHeroHead = G_ToolsManager:seekChildByName(heroInfoCsb,"ig_heroListHeroHead")		
			ig_heroListHeroHead:loadTexture("icon/hero/"..G_CsvManager:getHeroImg2(k)..".png")

			local ig_heroListStar = G_ToolsManager:seekChildByName(heroInfoCsb,"ig_heroListStar")

			local tt_heroListHeroLv = G_ToolsManager:seekChildByName(heroInfoCsb,"tt_heroListHeroLv")
			tt_heroListHeroLv:setString("Lv"..heroInfo["heroLv"])

			local tt_heroListHeroTitle = G_ToolsManager:seekChildByName(heroInfoCsb,"tt_heroListHeroTitle")
			local tt_heroListHeroZhanLi = G_ToolsManager:seekChildByName(heroInfoCsb,"tt_heroListHeroZhanLi")

			local pl_liaoYang = G_ToolsManager:seekChildByName(heroInfoCsb,"pl_liaoYang")
			local pl_tianJia = G_ToolsManager:seekChildByName(heroInfoCsb,"pl_tianJia")
			local tt_liaoYangTime = G_ToolsManager:seekChildByName(heroInfoCsb,"tt_liaoYangTime")
			if heroInfo["xiuYangTime"] == "0" then
				pl_liaoYang:setVisible(false)
			else
				pl_tianJia:setVisible(false)
			end

			local xiuYangTime = tonumber(heroInfo["xiuYangTime"])
			xiuYangTime = xiuYangTime-G_CURRENTTIMEMILLIS
			table.insert(self.surplusTimeArr,xiuYangTime)
			table.insert(self.heroInfoCsbArr,heroInfoCsb)


			local tt_liaoYangTime = G_ToolsManager:seekChildByName(heroInfoCsb,"tt_liaoYangTime")
			local bt_tianJia = G_ToolsManager:seekChildByName(heroInfoCsb,"bt_tianJia")
			bt_tianJia:setTag(tonumber(k))
			bt_tianJia:addTouchEventListener(function(sender, state)
			    if state == 2 then
			    	self.wMaoXian.mMaoXian:setHeroConfigState(tostring(sender:getTag()),1)
			    	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerEntry)
			    	self.wMaoXian:setHero(sender:getTag())
			    	self:removeFromParent()
			    end
			end)
			local ig_difficulty = G_ToolsManager:seekChildByName(heroInfoCsb,"ig_difficulty")


			index = index +1
		end
	end


	local scheduler = cc.Director:getInstance():getScheduler()
	local function xiuYangTimeTimer( ... )
		for i,surplusTime in ipairs(self.surplusTimeArr) do
			if surplusTime >0 then
				local timeString = G_ToolsManager:getTimeString(surplusTime)
				tt_liaoYangTime = G_ToolsManager:seekChildByName(self.heroInfoCsbArr[i],"tt_liaoYangTime")
				tt_liaoYangTime:setString(timeString)
				self.surplusTimeArr[i] = self.surplusTimeArr[i]-1
			elseif surplusTime == 0 then
				local pl_liaoYang = G_ToolsManager:seekChildByName(self.heroInfoCsbArr[i],"pl_liaoYang")
				pl_liaoYang:setVisible(false)

				local pl_tianJia = G_ToolsManager:seekChildByName(self.heroInfoCsbArr[i],"pl_tianJia")
				pl_tianJia:setVisible(true)

				--防止多次进入这个判断
				self.surplusTimeArr[i] = self.surplusTimeArr[i]-1
			end
		end
	end
	self.schedulerEntry = scheduler:scheduleScriptFunc(xiuYangTimeTimer, 1, false)

end


return VHeroList