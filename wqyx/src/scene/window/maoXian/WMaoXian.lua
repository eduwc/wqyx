local WMaoXian = class("WMaoXian",require "base.view.BaseNode")
WMaoXian.nodeName				= "WMaoXian"
WMaoXian.wMaoXianDuiLie			= nil
WMaoXian.mMaoXian 				= nil
WMaoXian.MaoXianView 			= nil
WMaoXian.selectedMapId			= "90001"
WMaoXian.tt_maoXianLv 			= nil
WMaoXian.tt_diaoLuoInfo 		= nil
WMaoXian.ig_diaoLuoPic 			= nil
WMaoXian.tt_maoXianCD 			= nil
WMaoXian.tt_tuiJianZhanLi 		= nil
WMaoXian.tt_zhanLiJiaCheng 		= nil
WMaoXian.pl_addHeroBg 			= nil
WMaoXian.bt_beginMaoXian 		= nil
WMaoXian.addHeroItemArr 		= {} --+号和加锁显示(尚未配置,初始状态)
WMaoXian.heroItemArr 			= {nil,nil,nil,nil,nil} --头像显示(已配置)
WMaoXian.addHeroItemArrNow 		= {} ---+号(由配置队长后产生)
WMaoXian.setingHeroIndex 		= 0 --正在配置英雄的位置
WMaoXian.heroIDArr 				= {"","","","",""}  --存储格子位上的英雄ID


-- --必须要实现
function WMaoXian:init(node,nodeName)
	WMaoXian.super:init(node,nodeName)
end


function WMaoXian:ctor(mMaoXian,wMaoXianDuiLie)
	self.MaoXianView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianView.csb")
	self:addChild(self.MaoXianView)


	self.wMaoXianDuiLie = wMaoXianDuiLie
	self.mMaoXian = mMaoXian

	local maoXianNumber = G_CsvManager:getMaoXianNumber()
	local sv_myMaoXianPic = G_ToolsManager:seekChildByName(self.MaoXianView,"sv_myMaoXianPic")
	local scrollviewWidth = maoXianNumber*95
	sv_myMaoXianPic:setInnerContainerSize(cc.size(scrollviewWidth,86))

	
	local maoXianCsv = G_CsvManager:getMaoXianCsv()
	local index = 0
	for i=1,maoXianNumber do
	
		local mapIndex = 90000+i
		local risk_img2 = maoXianCsv[tostring(mapIndex)]["risk_img2"]
		local mapButton = ccui.Button:create("icon/maoXian/"..risk_img2..".png", "icon/maoXian/"..risk_img2..".png")
		mapButton:setPosition(index*95,0)
		mapButton:setAnchorPoint(cc.p(0,0))
		mapButton:setTag(mapIndex)
		mapButton:addTouchEventListener(function(sender, state)
	        if state == 2 then
		    	self.selectedMapId = tostring(sender:getTag())
		    	self:changeInfo(self.selectedMapId,1)
	        end
	    end)
		sv_myMaoXianPic:addChild(mapButton)
		index = index+1
	end

	self.ig_maoXianPic = G_ToolsManager:seekChildByName(self.MaoXianView,"ig_maoXianPic")
	self.tt_maoXianLv = G_ToolsManager:seekChildByName(self.MaoXianView,"tt_maoXianLv")
	self.lb_maoXianLv = G_ToolsManager:seekChildByName(self.MaoXianView,"lb_maoXianLv")
	self.tt_diaoLuoInfo = G_ToolsManager:seekChildByName(self.MaoXianView,"tt_diaoLuoInfo")
	self.ig_diaoLuoPic = G_ToolsManager:seekChildByName(self.MaoXianView,"ig_diaoLuoPic")
	self.tt_maoXianCD = G_ToolsManager:seekChildByName(self.MaoXianView,"tt_maoXianCD")
	self.tt_tuiJianZhanLi = G_ToolsManager:seekChildByName(self.MaoXianView,"tt_tuiJianZhanLi")
	self.tt_zhanLiJiaCheng = G_ToolsManager:seekChildByName(self.MaoXianView,"tt_zhanLiJiaCheng")
	self.pl_addHeroBg = G_ToolsManager:seekChildByName(self.MaoXianView,"pl_addHeroBg")
	self.bt_beginMaoXian = G_ToolsManager:seekChildByName(self.MaoXianView,"bt_beginMaoXian")
	self.bt_beginMaoXian:addTouchEventListener(function(sender, state)
	    if state == 2 then
	    	 local heroListStr =  ""
	    	 for i=1,#self.heroIDArr do	    	
	    	 	if self.heroIDArr[i] ~= "" then
		    	 	heroListStr = heroListStr..self.heroIDArr[i]..";" 	 		
	    	 	end	    	 	
	    	 end
	    	 heroListStr = string.sub(heroListStr, 1, -2)

   			 local jsMsg = {}
	         jsMsg["head"] = CS_DPMaoXian
	         jsMsg["maoXianID"] = self.selectedMapId
	         jsMsg["heroList"]  = heroListStr
	         jsMsg["listID"] = self.wMaoXianDuiLie:getSelectedIndex()   --副本队列中的位置
             G_WebSocketManager:sendMessage(jsMsg)	    	
	    end
	end)	

	self:changeInfo("90001",1)

	self:initAddHeroItem()




end

--改变内容
function WMaoXian:changeInfo(mapID,mapLv)
	local risk_img1 = G_CsvManager:getMaoXianImg1(mapID)
	self.ig_maoXianPic:loadTexture("icon/maoXian/"..risk_img1..".png")

	self.lb_maoXianLv:setPercent((1/50)*100)
	self.tt_maoXianLv:setString("1/"..G_CsvManager:getMaoXianUpLevelNum(mapID,mapLv))

	self.tt_diaoLuoInfo:setString("掉落:"..G_CsvManager:getMaoXianPropNum1(mapID,mapLv).."-"..G_CsvManager:getMaoXianPropNum2(mapID,mapLv))
	--self.ig_diaoLuoPic:loadTexture()
	self.tt_maoXianCD:setString("冒险CD:"..G_CsvManager:getMaoXianRecuperateCd(mapID).."分钟")
	self.tt_tuiJianZhanLi:setString(G_CsvManager:getMaoXianRiskRecommendPower(mapID))

end


function WMaoXian:initAddHeroItem()
	for i=1,5 do
		local addHeroItem = nil
		if i == 1 then
			addHeroItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroAddItem.csb")		
			local bt_maoXianAddHero = G_ToolsManager:seekChildByName(addHeroItem,"bt_maoXianAddHero")
			bt_maoXianAddHero:setTag(i)
			bt_maoXianAddHero:addTouchEventListener(function(sender, state)
			    if state == 2 then
			    	self.setingHeroIndex = sender:getTag()
			    	if self.heroItemArr[self.setingHeroIndex] == nil then
			    		self:addChild(require("scene.window.maoXian.VHeroList"):create(self,self.mMaoXian:getCalledHeroInfo()))			    		
			    	end
			    	
			    end
			end)			
		else 
			addHeroItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianLockItem.csb")
			local tt_lvLock = G_ToolsManager:seekChildByName(addHeroItem,"tt_lvLock")
			tt_lvLock:setString(self.mMaoXian:getOpenStr(i))
		end	
		addHeroItem:setPosition((i-1)*125,0)
		self.pl_addHeroBg:addChild(addHeroItem)	
		table.insert(self.addHeroItemArr,addHeroItem)		
	end
end


function WMaoXian:setHero(heroID)
	local addHeroItem = nil
	self.addHeroItemArr[self.setingHeroIndex]:setVisible(false)
	self.heroIDArr[self.setingHeroIndex] = tostring(heroID)

	addHeroItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroItem.csb")	
	local bt_heroHead = G_ToolsManager:seekChildByName(addHeroItem,"bt_heroHead")
	bt_heroHead:setTag(self.setingHeroIndex)
	bt_heroHead:addTouchEventListener(function(sender, state)
		if state == 2 then
			self:removeHero(sender:getTag())
		end
	end)
	bt_heroHead:loadTextures("icon/hero/51001a.png","icon/hero/51001a.png","",0)
	self.pl_addHeroBg:addChild(addHeroItem)	
	addHeroItem:setPosition((self.setingHeroIndex-1)*125,0)	
	--队长位置
	if self.setingHeroIndex == 1 then

		self:openHeroGrid(30)
	end	
	self.heroItemArr[self.setingHeroIndex] = addHeroItem

	self:changeZhanLi(self:getHeroArr())
end

function WMaoXian:changeZhanLi(number)
	self.tt_zhanLiJiaCheng:setString(self.mMaoXian:addZhanLi(number))
end

--获取已经配置的人数
function WMaoXian:getHeroArr()
	return #self.heroItemArr
end

--把配置的英雄下架
function WMaoXian:removeHero(heroIndex)
	self.heroItemArr[heroIndex]:removeFromParent()
	self.heroItemArr[heroIndex] = nil
	if heroIndex~= 1 then
		self.addHeroItemArr[heroIndex]:setVisible(true)
		self.mMaoXian:setHeroConfigState(self.heroIDArr[heroIndex],0)
		self.heroIDArr[heroIndex] = ""
	elseif heroIndex == 1 then --队长的位置,取消就全部队员也跟着取消了
		self:restoreHeroGrid()
	end
	
end

--根据队长等级开启格子
function WMaoXian:openHeroGrid(lv)
	if lv >= 10 and lv < 20 then
		self:changeGridState(2)
	elseif lv >= 20 and lv < 30 then
		self:changeGridState(3)
	elseif lv >= 30 and lv < 50 then	
		self:changeGridState(4)
	elseif lv >= 50 then
		self:changeGridState(5)
	end
end

--改变成+号形式
function WMaoXian:changeGridState(openLv)
	for i=2,openLv do
		self.addHeroItemArr[i]:setVisible(false)

		local addHeroItem = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianHeroAddItem.csb")
		local tt_addHeroTag = G_ToolsManager:seekChildByName(addHeroItem,"tt_addHeroTag")
		tt_addHeroTag:setString("添加队员")
		local bt_maoXianAddHero = G_ToolsManager:seekChildByName(addHeroItem,"bt_maoXianAddHero")
		bt_maoXianAddHero:setTag(i)
		bt_maoXianAddHero:addTouchEventListener(function(sender, state)
			if state == 2 then
				self.setingHeroIndex = sender:getTag()
				 if self.heroItemArr[self.setingHeroIndex] == nil then
				    	self:addChild(require("scene.window.maoXian.VHeroList"):create(self,self.mMaoXian:getCalledHeroInfo()))			    		
				 end
				    	
			 end
		end)	
		addHeroItem:setPosition((i-1)*125,0)
		self.pl_addHeroBg:addChild(addHeroItem)	
		self.addHeroItemArrNow[i] = addHeroItem	
		

	end	
end

function WMaoXian:restoreHeroGrid()
	for i=1,5 do		 	
		if self.addHeroItemArrNow[i] ~= nil then
			self.addHeroItemArrNow[i]:removeFromParent()
			self.addHeroItemArrNow[i] = nil
		end		
		if self.heroItemArr[i] ~= nil then
			self.heroItemArr[i]:removeFromParent()
			self.heroItemArr[i] = nil
		end
		
		self.mMaoXian:setHeroConfigState(self.heroIDArr[i],0)
		self.heroIDArr[i] = ""
		self.addHeroItemArr[i]:setVisible(true)
	end
end


return WMaoXian