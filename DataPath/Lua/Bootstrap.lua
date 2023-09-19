Bootstrap = {}
-- 核心table，存储所有的控制器
Bootstrap.Controllers = {}

Bootstrap.Start = function()
    -- 将必要的控制器，注册进核心table
    Bootstrap.LoadPage("MainMenuController")
    -- Bootstrap.LoadPage("SignInController")
end

Bootstrap.Update = function()
    -- 遍历所有注册给核心的控制脚本
    for key, value in pairs(Bootstrap.Controllers) do
        if (value.Update ~= nil) then
            -- 调用控制器的Update
            value:Update()
        end
    end
end

Bootstrap.OnDestroy = function()
    for key, value in pairs(Bootstrap.Controllers) do
        if (value.OnDestroy ~= nil) then
            value:OnDestroy()
        end
    end
end

-- 加载控制器脚本至核心table中 并初始化Start()
-- 参数：脚本名称
Bootstrap.LoadPage = function(name)
    -- 加载Controller目录下对应的脚本
    local c = require("Controller/" .. name)
    -- 注册给核心table，这样可以使用生命周期函数
    Bootstrap.Controllers[name] = c
    -- 加载页面时 同时初始化
    c:Start()
end

require("Config")
require("Prefabs")
require("ABManager")
LuaJson = require("dkjson")

--[[

local json = require("dkjson")
-- 解析为lua数据结构
local data = json.decode('[true,"abc",3]')
print(data[2])

]]
