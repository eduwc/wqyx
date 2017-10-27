
--***************管理*****************--
G_ToolsManager 		=  require ("base.tools.ToolsManager"):getInstance()
G_NodeManager  		=  require ("base.view.NodeManager"):getInstance()
G_ModuleManager  	=  require ("base.module.ModuleManager"):getInstance()
G_SceneManager		=  require ("base.view.SceneManager"):getInstance()


--***************打印*****************--
function G_GameLog(str)
 	 print(str)
end
