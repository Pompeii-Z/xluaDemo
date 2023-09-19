RoleDataModel = {}
-- 数据持久化路径
RoleDataModel.Path = CS.UnityEngine.Application.persistentDataPath .. "/Role.json"

-- 不存在文件则以json格式初始化数据(只执行第一次)
function RoleDataModel:New()
	if (not CS.System.IO.File.Exists(RoleDataModel.Path))
	then
		CS.System.IO.File.WriteAllText(RoleDataModel.Path,
			'{"Gold" : 9, "Diamond" : 30, "currentPower" : 10, "maxPower" : 120}')
	end
end

-- 读取数据，解析为lua的数据结构
function RoleDataModel:ReadAllData()
	if (CS.System.IO.File.Exists(RoleDataModel.Path))
	then
		return LuaJson.decode(CS.System.IO.File.ReadAllText(RoleDataModel.Path))
	else
		return nil
	end
end

-- 添加金币数，修改json文件以持久化保存数据,并返回data。
function RoleDataModel:AddGold(num)
	if (CS.System.IO.File.Exists(RoleDataModel.Path))
	then
		local data = LuaJson.decode(CS.System.IO.File.ReadAllText(RoleDataModel.Path))
		data.Gold = data.Gold + num

		CS.System.IO.File.WriteAllText(RoleDataModel.Path, LuaJson.encode(data))

		return data
	end
end

-- 添加钻石数，修改json文件以持久化保存数据,并返回data。
function RoleDataModel:AddDiamond(num)
	if (CS.System.IO.File.Exists(RoleDataModel.Path))
	then
		local data = LuaJson.decode(CS.System.IO.File.ReadAllText(RoleDataModel.Path))
		data.Diamond = data.Diamond + num

		CS.System.IO.File.WriteAllText(RoleDataModel.Path, LuaJson.encode(data))

		return data
	end
end

-- 添加体力值，修改json文件以持久化保存数据,并返回data。
function RoleDataModel:AddPower(num)
	if (CS.System.IO.File.Exists(RoleDataModel.Path))
	then
		local data = LuaJson.decode(CS.System.IO.File.ReadAllText(RoleDataModel.Path))
		if data.maxPower > data.currentPower then
			data.currentPower = data.currentPower + num
		end

		CS.System.IO.File.WriteAllText(RoleDataModel.Path, LuaJson.encode(data))

		return data
	end
end
