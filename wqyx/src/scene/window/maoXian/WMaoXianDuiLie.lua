local WMaoXianDuiLie = class("WMaoXianDuiLie",require "base.view.BaseNode")
WMaoXianDuiLie.nodeName				= "WMaoXianDuiLie"
WMaoXianDuiLie.mMaoXian 			= nil
WMaoXianDuiLie.duiLieView 			= nil
WMaoXianDuiLie.bt_duiLiePage 		= nil
WMaoXianDuiLie.bt_maoXianPage 		= nil
WMaoXianDuiLie.maoXianView 			= nil
WMaoXianDuiLie.listArr 				= {}
WMaoXianDuiLie.selectedIndex 		= 0
WMaoXianDuiLie.maoXianInfo 			= nil


-- --必须要实现
function WMaoXianDuiLie:init(node,nodeName)
	WMaoXianDuiLie.super:init(node,nodeName)
end

function WMaoXianDuiLie:ctor()
	--必须要调用
	self:init(self,self.nodeName)
	WMaoXianDuiLie.super:ctor()

	-- --可不调用，最好调用
	self.mMaoXian  = require ("module.maoXian.MMaoXian"):create()
	self.mMaoXian:connectView(self)


	self.duiLieView = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianDuiLie.csb")
	self:addChild(self.duiLieView)

	--初始化冒险
	self.maoXianView = require("scene.window.maoXian.WMaoXian"):create(self.mMaoXian,self)
	self.maoXianView:setVisible(false)
	self:addChild(self.maoXianView)


	self.bt_duiLiePage = G_ToolsManager:seekChildByName(self.duiLieView,"bt_duiLiePage")	
	self.bt_duiLiePage:addTouchEventListener(function(sender, state)
	        if state == 2 then
		        self:changePage(1)
	        end
	end)	
	self.bt_maoXianPage = G_ToolsManager:seekChildByName(self.duiLieView,"bt_maoXianPage")	
	self.bt_maoXianPage:addTouchEventListener(function(sender, state)
	        if state == 2 then
		        self:changePage(2)
	        end
	end)


	self.sv_duiLieBg = G_ToolsManager:seekChildByName(self.duiLieView,"sv_duiLieBg")	


end


function WMaoXianDuiLie:initDuiLie(maoXianInfo)

	self.maoXianInfo = maoXianInfo

	local duiLieNumber  = 5

	local scrollviewHeight = duiLieNumber*370
	self.sv_duiLieBg:setInnerContainerSize(cc.size(640,scrollviewHeight))

	for i=0,(duiLieNumber-1) do


		if maoXianInfo[tostring(i+1)] ~= nil then
			self:showMaoXianInfo(i,scrollviewHeight,self.maoXianInfo)
		else
			local maoXianEmpty = cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianEmpty.csb")
			self.sv_duiLieBg:addChild(maoXianEmpty)
			maoXianEmpty:setPosition(0,scrollviewHeight-(i*370))

			local bt_configMaoXian = G_ToolsManager:seekChildByName(maoXianEmpty,"bt_configMaoXian")
			bt_configMaoXian:setTag(i+1)
			bt_configMaoXian:addTouchEventListener(function(sender, state)
			        if state == 2 then
				       --跳转到冒险
				        self.selectedIndex = sender:getTag()
				       	self:changePage(2)
			        end
			end)
			table.insert(self.listArr,bt_configMaoXian)			
		end

	end

end


function WMaoXianDuiLie:changePage(pageID)
	if pageID == 1 then
		G_ToolsManager:setBtnState(self.bt_duiLiePage,false)
		G_ToolsManager:setBtnState(self.bt_maoXianPage,true)


		self.maoXianView:setVisible(false)
		self.sv_duiLieBg:setVisible(true)
	elseif pageID == 2 then
		G_ToolsManager:setBtnState(self.bt_duiLiePage,true)
		G_ToolsManager:setBtnState(self.bt_maoXianPage,false)

		self.sv_duiLieBg:setVisible(false)
		self.maoXianView:setVisible(true)

	end
end

function WMaoXianDuiLie:updataList()
	
end

function WMaoXianDuiLie:getSelectedIndex()
	return self.selectedIndex
end

function WMaoXianDuiLie:showMaoXianInfo(index,scrollviewHeight,maoXianInfo)
		local _maoXianInfo = maoXianInfo[tostring(index+1)]



		local maoXianID = _maoXianInfo["maoXianID"]
		local heroList = _maoXianInfo["heroList"]
		local endTime = _maoXianInfo["endTime"]-G_CURRENTTIMEMILLIS


		local maoXianItem= cc.CSLoader:createNode(CSB_ADDRESS.."csb_maoXian/MaoXianItem.csb")
		maoXianItem:setPosition(0,scrollviewHeight-(index*370))
		self.sv_duiLieBg:addChild(maoXianItem)

		local ig_maoXianPic = G_ToolsManager:seekChildByName(maoXianItem,"ig_maoXianPic")
		local risk_img1 = G_CsvManager:getMaoXianImg1(maoXianID)
		ig_maoXianPic:loadTexture("icon/maoXian/"..risk_img1..".png")

		local pl_maoXianCD = G_ToolsManager:seekChildByName(maoXianItem,"pl_maoXianCD")
		local pl_complete = G_ToolsManager:seekChildByName(maoXianItem,"pl_complete")		
		if endTime>0 then
			pl_complete:setVisible(false)
		else
			pl_maoXianCD:setVisible(false)
		end

		
		local bt_complete = G_ToolsManager:seekChildByName(maoXianItem,"bt_complete")
		bt_complete:addTouchEventListener(function(sender, state)
			    if state == 2 then
			    end
		end)		
		local tt_diaoLuoNumber = G_ToolsManager:seekChildByName(maoXianItem,"tt_diaoLuoNumber")
		tt_diaoLuoNumber:setString("掉落:"..G_CsvManager:getMaoXianPropNum1(maoXianID,1).."-"..G_CsvManager:getMaoXianPropNum2(maoXianID,1))

		local ig_diaoLuoItem = G_ToolsManager:seekChildByName(maoXianItem,"ig_diaoLuoItem")
		ig_diaoLuoItem:loadTexture("res/ui/login/xinqu.png")

		local tt_maoXianCD = G_ToolsManager:seekChildByName(maoXianItem,"tt_maoXianCD")
		tt_maoXianCD:setString("")

		local tt_tuiJianZhanLi = G_ToolsManager:seekChildByName(maoXianItem,"tt_tuiJianZhanLi")
		tt_tuiJianZhanLi:setString("")

		local tt_zhanLiJiaCheng = G_ToolsManager:seekChildByName(maoXianItem,"tt_zhanLiJiaCheng")
		tt_zhanLiJiaCheng:setString(self.mMaoXian:addZhanLi(#heroList))

		local pl_heroInfoBg = G_ToolsManager:seekChildByName(maoXianItem,"pl_heroInfoBg")			

end


return WMaoXianDuiLie