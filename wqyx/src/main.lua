
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()

	--初始化框架(必要)
	require "base.InitBase"
	InitBase:init()
	require "global.GlobalVar"



    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
