ABManager = {}
ABManager.Path = Config.ABPath
--所有被加载过的AB文件
ABManager.Files = {}

-- 此处遗忘可查看Project:AssetBundleTest下的Load.cs
-- 总AB包文件
local master = CS.UnityEngine.AssetBundle.LoadFromFile(ABManager.Path .. "/AB");
-- 总AB包的Manifest
ABManager.Manifest = master:LoadAsset("AssetBundleManifest", typeof(CS.UnityEngine.AssetBundleManifest))
master:Unload(false)

--加载AB文件（加载依赖的AB文件）
function ABManager:LoadFile(name)
	if (ABManager.Files[name] ~= nil)
	then
		return
	end

	--  所有的依赖文件
	local dependencies = ABManager.Manifest:GetAllDependencies(name)
	-- 这里的数据结构为C语言 索引从0开始
	for i = 0, dependencies.Length - 1
	do
		local file = dependencies[i]

		--如果依赖的文件没有被加载过，则调用递归的加载
		if (ABManager.Files[file] == nil)
		then
			ABManager:LoadFile(file)
		end
	end

	--将AB包加载，并放入管理器的Files变量下
	ABManager.Files[name] = CS.UnityEngine.AssetBundle.LoadFromFile(ABManager.Path .. "/" .. name);
end

--加载资源
--参数1：AB包文件名
--参数2：资源名称
--参数3：返回资源的类型
function ABManager:LoadAsset(file, name, type)
	--判断AB包是否加载过
	if (ABManager.Files[file] == nil)
	then
		print("没有这个文件")
		return nil
	else
		return ABManager.Files[file]:LoadAsset(name, type) -- LoadAsset函数重载
	end
end

--卸载AB文件
function ABManager:UnloadFile(file)
	if (ABManager.Files[file] ~= nil)
	then
		ABManager.Files[file]:Unload(false);
	end
end
