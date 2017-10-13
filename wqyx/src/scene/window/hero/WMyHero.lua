local WMyHero = class("WMyHero",require "base.view.BaseNode")
WMyHero.nodeName				= "WMyHero"
WMyHero.mMyHero					= nil
WMyHero.myheroView				= nil
WMyHero.sv_myHeroHead			= nil
WMyHero.bt_heroInfo				= nil
WMyHero.bt_heroSkill			= nil
WMyHero.bt_qiangHuaPage			= nil
WMyHero.bt_jinJiePage			= nil
WMyHero.heroInfoBg				= nil
WMyHero.qiangHuaView 			= nil
WMyHero.jinJieView 				= nil
WMyHero.pl_hero					= nil
WMyHero.selectedHeroInfo		= nil
WMyHero.selectedHeroID			= nil


-- --必须要实现
function WMyHero:init(node,nodeName)
	WMyHero.super:init(node,nodeName)
end


function WMyHero:ctor()
		--必须要调用
	self:init(self,self.nodeName)
	WMyHero.super:ctor()

	-- --可不调用，最好调用
	self.mMyHero  = require ("module.hero.mMyHero"):create()
	self.mMyHero:connectView(self)

	self.myheroView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/MyHero.csb")
	self:addChild(self.myheroView)	


	self.sv_myHeroHead = G_ToolsManager:seekChildByName(self.myheroView,"sv_myHeroHead")
	self:requestMyhero()

	self.heroInfoBg = G_ToolsManager:seekChildByName(self.myheroView,"heroInfoBg")
	self.pl_hero = G_ToolsManager:seekChildByName(self.myheroView,"pl_hero")
	

	self.qiangHuaView = require("scene.window.hero.VQiangHua"):create()
	self.pl_hero:addChild(self.qiangHuaView)
	self.qiangHuaView:setVisible(false)


	self.jinJieView = require("scene.window.hero.VJinJie"):create()
	self.pl_hero:addChild(self.jinJieView)
	self.jinJieView:setVisible(false)


	self.bt_heroInfo = G_ToolsManager:seekChildByName(self.myheroView,"bt_heroInfo")
	self.bt_heroInfo:addTouchEventListener(function(sender, state)
		if state == 2 then
			self:changePage(1)					
		end
	end)	


	self.bt_heroSkill = G_ToolsManager:seekChildByName(self.myheroView,"bt_heroSkill")
	self.bt_heroSkill:addTouchEventListener(function(sender, state)
		if state == 2 then
			self:changePage(2)					
		end
	end)

	self.bt_qiangHuaPage = G_ToolsManager:seekChildByName(self.myheroView,"bt_qiangHuaPage")
	self.bt_qiangHuaPage:addTouchEventListener(function(sender, state)
		if state == 2 then
			self:changePage(3)		
			self.qiangHuaView:init(self.selectedHeroInfo,self.mMyHero,self.selectedHeroID)	
		end
	end)

	self.bt_jinJiePage = G_ToolsManager:seekChildByName(self.myheroView,"bt_jinJiePage")
	self.bt_jinJiePage:addTouchEventListener(function(sender, state)
		if state == 2 then
			self:changePage(4)		
			self.jinJieView:init(self.selectedHeroInfo,self.mMyHero,self.selectedHeroID)				
		end
	end)	


end

--请求查询已召唤的英雄
function WMyHero:requestMyhero()
	local jsMsg = {}
	G_ModuleManager:notify(jsMsg,"MHero",REQUESTHERO)

end

function WMyHero:initHeroList(heroList)

	local index = 0
	for k,heroInfo in pairs(heroList) do
			local myHeroItem = 	cc.CSLoader:createNode(CSB_ADDRESS.."csb_hero/MyHeroItem.csb")
			myHeroItem:setPosition(index*90,0)
			self.sv_myHeroHead:addChild(myHeroItem)

			local ig_heroHead = G_ToolsManager:seekChildByName(myHeroItem,"ig_heroHead")
			ig_heroHead:loadTexture("icon/hero/"..heroInfo["hero_img2"]..".png")


			local bt_heroHead = G_ToolsManager:seekChildByName(myHeroItem,"bt_heroHead")
			bt_heroHead:setTag(tonumber(k))

			bt_heroHead:addTouchEventListener(function(sender, state)
			        if state == 2 then			        				        		

				        heroInfo = heroList[tostring(sender:getTag())]	
				        self.selectedHeroID	  = tonumber(sender:getTag())
				        self.selectedHeroInfo = heroInfo

				        local ig_heroBigHead = G_ToolsManager:seekChildByName(self.myheroView,"ig_heroBigHead")
						ig_heroBigHead:loadTexture("icon/hero/"..heroInfo["hero_img1"]..".png")

						local tt_heroName = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroName")
						tt_heroName:setString(heroInfo["hero_name"])

						local tt_heroTitle = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroTitle")
						tt_heroTitle:setString(heroInfo["hero_title"])


						local tt_zhuanjing = G_ToolsManager:seekChildByName(self.myheroView,"tt_zhuanjing")
						local zhuanjinText = G_DataManager:zhuanjinText(heroInfo["hero_master"],2)		
						tt_zhuanjing:setString("专精:"..zhuanjinText)	

						local tt_jingtong = G_ToolsManager:seekChildByName(self.myheroView,"tt_jingtong")
						tt_jingtong:setString("精通:"..zhuanjinText)	

						local tt_skill = G_ToolsManager:seekChildByName(self.myheroView,"tt_skill")
						tt_skill:setString("技能:")	


						local tt_introduce = G_ToolsManager:seekChildByName(self.myheroView,"tt_introduce")
						tt_introduce:setString("介绍:"..heroInfo["hero_explain"])

						local tt_heroLv = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroLv")
						tt_heroLv:setString("LV"..1)
			
						local tt_heroZhanLi = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroZhanLi")
						tt_heroZhanLi:setString("战力"..1)

			        end
		    end)



				--默认显示第一个
				if index == 0 then
					self.selectedHeroInfo = heroInfo
					self.selectedHeroID	  = tonumber(k)

					local ig_heroBigHead = G_ToolsManager:seekChildByName(self.myheroView,"ig_heroBigHead")
					ig_heroBigHead:loadTexture("icon/hero/"..heroInfo["hero_img1"]..".png")

					local tt_heroName = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroName")
					tt_heroName:setString(heroInfo["hero_name"])

					local tt_heroTitle = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroTitle")
					tt_heroTitle:setString(heroInfo["hero_title"])


					local tt_zhuanjing = G_ToolsManager:seekChildByName(self.myheroView,"tt_zhuanjing")
					local zhuanjinText = G_DataManager:zhuanjinText(heroInfo["hero_master"],2)		
					tt_zhuanjing:setString("专精:"..zhuanjinText)	

					local tt_jingtong = G_ToolsManager:seekChildByName(self.myheroView,"tt_jingtong")
					tt_jingtong:setString("精通:"..zhuanjinText)	

					local tt_skill = G_ToolsManager:seekChildByName(self.myheroView,"tt_skill")
					tt_skill:setString("技能:")	


					local tt_introduce = G_ToolsManager:seekChildByName(self.myheroView,"tt_introduce")
					tt_introduce:setString("介绍:"..heroInfo["hero_explain"])

					local tt_heroLv = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroLv")
					tt_heroLv:setString("LV"..1)
			
					local tt_heroZhanLi = G_ToolsManager:seekChildByName(self.myheroView,"tt_heroZhanLi")
					tt_heroZhanLi:setString("战力"..1)					
				end
			

				index = index+1
	end	

end


function WMyHero:changePage(pageID)
	if pageID == 1 then
		G_ToolsManager:setBtnState(self.bt_heroInfo,false)
		G_ToolsManager:setBtnState(self.bt_heroSkill,true)
		G_ToolsManager:setBtnState(self.bt_qiangHuaPage,true)
		G_ToolsManager:setBtnState(self.bt_jinJiePage,true)

		self.heroInfoBg:setVisible(true)
		self.qiangHuaView:setVisible(false)
		self.jinJieView:setVisible(false)
	elseif pageID == 3 then
		G_ToolsManager:setBtnState(self.bt_heroInfo,true)
		G_ToolsManager:setBtnState(self.bt_heroSkill,true)
		G_ToolsManager:setBtnState(self.bt_qiangHuaPage,false)
		G_ToolsManager:setBtnState(self.bt_jinJiePage,true)

		self.heroInfoBg:setVisible(false)
		self.qiangHuaView:setVisible(true)
		self.jinJieView:setVisible(false)
	elseif pageID == 4 then
		G_ToolsManager:setBtnState(self.bt_heroInfo,true)
		G_ToolsManager:setBtnState(self.bt_heroSkill,true)
		G_ToolsManager:setBtnState(self.bt_qiangHuaPage,true)
		G_ToolsManager:setBtnState(self.bt_jinJiePage,false)

		self.heroInfoBg:setVisible(false)
		self.qiangHuaView:setVisible(false)
		self.jinJieView:setVisible(true)
	end
end



return WMyHero