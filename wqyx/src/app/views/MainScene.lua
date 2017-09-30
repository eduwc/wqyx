local MainScene = class("MainScene", cc.load("mvc").ViewBase)





function MainScene:onCreate()


   -- local heroCsv =  G_CsvManager:getInstance():getHeroCsv()
   -- print("heroCsv"..heroCsv["1004"]["hero_img2"])


 --   require ("scene.login.SceneLogin"):create()
 --    -- add background image
 -- --    display.newSprite("HelloWorld.png")
 -- --        :move(display.center)
 -- --        :addTo(self)

 -- --    -- add HelloWorld label
 -- --    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
 -- --        :move(display.cx, display.cy + 200)
 -- --        :addTo(self)


 -- --        local uiLayout = GUIReader:shareReader():widgetFromJsonFile("DemoLogin/DemoLogin.ExportJson"


 -- --    -- autoUpdateScene = require("AutoUpdateScene")
 -- --    -- autoUpdateScene:create():addTo(self)
    

 -- --    local ct = Testluabing:getInstance()
 -- --    ct:setNumber(53)
 -- --    print("jiegsdf"..ct:getNumber())

 -- --    wsSendText = cc.WebSocket:create("ws://127.0.0.1:9635")     
	-- -- if nil ~= wsSendText then 
	-- --     wsSendText:registerScriptHandler(wsSendTextOpen,cc.WEBSOCKET_OPEN) 
	-- --     wsSendText:registerScriptHandler(wsSendTextMessage,cc.WEBSOCKET_MESSAGE) 
	-- --     wsSendText:registerScriptHandler(wsSendTextClose,cc.WEBSOCKET_CLOSE) 
	-- --     wsSendText:registerScriptHandler(wsSendTextError,cc.WEBSOCKET_ERROR) 
	-- -- end 

    

    local scene = cc.CSLoader:createNode(CSB_ADDRESS.."MainScene.csb")
    self:addChild(scene)



 --    local account = scene:getChildByName("TF_Account")
 --    account:setString("你大爷的")

 --    local scrollView = scene:getChildByName("ScrollView_Test")
 --    --设置滚动区域
 --    scrollView:setInnerContainerSize(cc.size(100*10, 93));
 --    --是否显示滚动条
 --    scrollView:setScrollBarEnabled(false); 

 --    for i=0,10 do
 --        local sp = ccui.Button:create("shezhi0.png")
 --        sp:setAnchorPoint(ccp(0,0)) 
 --        sp:setPosition(i*100,0)
 --        scrollView:addChild(sp)
 --        sp:addClickEventListener(function(sender)
 --            sp:setScale(0.5)
 --        end)
 --    end

       
    --   local toolsManager =  require ("base.tools.ToolsManager"):getInstance()
       local btn = G_ToolsManager:seekChildByName(scene,"Button_Confirm")
       
         
        -- local btn
        -- scene:enumerateChildren("//Button_Confirm",function(node)
        --     btn = node
        -- end)


       -- local btn = scene:seekWidgetByName("Panel_1.")
        btn:addTouchEventListener(function(sender, state)
        if state == 0 then
        --     account:setString("began")
        elseif state == 1 then
         --   account:setString("moved")
        elseif state == 2 then
            --     local js = {}
            -- js["head"] = "DPRegister"
            -- js["userName"] = "test"
            -- js["passWord"] = "123456"
            --  G_WebSocketManager:sendMessage(js)


    -- js2 = {["head"]="SC_SWITCH_REGISTER",["registState"]=1}
    -- local js = json.decode(js2.to)
    --    local headRule = string.split(js["head"],"_")[2]
  --  local headInfo = string.split(js["head"],"_")[3]


  --  print("headRule"..headRule)
   -- print("headInfo"..headInfo)


            --千万不要写成require ("scene.login.SceneLogin"):create()  create()会自动在changeScene中调用
            G_SceneManager:changeScene(require ("scene.login.SceneLogin"))


            

  



        --    account:setString("end")
        else
         --   account:setString("cancelled")
        end

     end)
 -- --    -- btn:addClickEventListener(function(sender)
         
 -- --    --           -- require("mime")
 -- --    --           --  y=mime.b64("diego:password")
 -- --    --             wsSendText:sendString(account:getString()) 
 -- --    --     end)



end




return MainScene
