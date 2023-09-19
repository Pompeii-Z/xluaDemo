Config = {}

-- Assets目录
local path = CS.UnityEngine.Application.dataPath

-- AB包目录
Config.ABPath = string.sub(path, 1, #path - 7) .. "/DataPath/AB"
