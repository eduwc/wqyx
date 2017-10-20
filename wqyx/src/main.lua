
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"


-- function bubble_sort(arr)  
--     -- body  
--     local tmp = 0  
  
--     for i=1,#arr-1 do  
--         for j=1,#arr-i do  
--             if arr[j] > arr[j+1] then  
--                 tmp = arr[j]  
--                 arr[j] = arr[j+1]  
--                 arr[j+1] = tmp  
--             elseif arr[j] == arr[j+1] then
--             	tmp = arr[j]  
--                 arr[j] = arr[j+1]  
--                 arr[j+1] = tmp 
--             end  
--         end  
--     end 
--     return  arr
-- end  

local function main()
	--初始化框架(必要)
	require "base.InitBase"
	InitBase:init()
	require "global.GlobalVar"



 -- 	local arr = {1,20,-1,30,23,21,-108,55,26,55,-2}  
 -- local arr = {"1","20","-1"}  
 --    local arr2 = bubble_sort(arr)  
 --      for i,v in ipairs(arr2) do  
 --        print(i,v)  
 --    end  



    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
