local Controller = {}
Controller.Page = nil
Controller.addGoldBtn = nil
Controller.addDiamondBtn = nil
Controller.addPowerBtn = nil

-- 控制器被加载时，Start生命周期函数执行
-- Lua模拟Start生命周期函数
function Controller:Start()
    -- ab包加载
    ABManager:LoadFile("mainmenu")
    -- 资源加载
    local obj = ABManager:LoadAsset(
        "mainmenu",
        "MainMenu",
        typeof(CS.UnityEngine.Object)
    )

    --加载预制体
    local page = Prefabs:Instantiate(obj)
    Controller.Page = page

    --读取数据模型
    require("DataModel/RoleDataModel")
    RoleDataModel:New()
    local data = RoleDataModel:ReadAllData()

    --初始化页面内容
    page.transform:Find("HeaderCount/Gold/Count"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = data.Gold
    page.transform:Find("HeaderCount/Diamond/Count"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = data.Diamond
    page.transform:Find("HeaderCount/Power/Count"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text =
        "<color=#6DDBFDFF>" .. data.currentPower .. "</color>" .. "/" .. data.maxPower

    --绑定添加金币按钮监听
    self.addGoldBtn = page.transform:Find("HeaderCount/Gold/Add"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.addGoldBtn.onClick:AddListener(Controller.AddGold)

    --绑定添加钻石按钮监听
    self.addDiamondBtn = page.transform:Find("HeaderCount/Diamond/Add"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.addDiamondBtn.onClick:AddListener(Controller.AddDiamond)

    --绑定添加体力按钮监听
    self.addPowerBtn = page.transform:Find("HeaderCount/Power/Add"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.addPowerBtn.onClick:AddListener(Controller.AddPower)
end

-- 添加金币的按钮监听方法
function Controller:AddGold()
    local data = RoleDataModel:AddGold(9)
    Controller.Page.transform:Find("HeaderCount/Gold/Count"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = data
        .Gold
end

-- 添加钻石的按钮监听方法
function Controller:AddDiamond()
    local data = RoleDataModel:AddDiamond(11)
    Controller.Page.transform:Find("HeaderCount/Diamond/Count"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = data
        .Diamond
end

-- 添加钻石的按钮监听方法
function Controller:AddPower()
    local data = RoleDataModel:AddPower(10)
    Controller.Page.transform:Find("HeaderCount/Power/Count"):GetComponent(typeof(CS.UnityEngine.UI.Text)).text =
        "<color=#6DDBFDFF>" .. data.currentPower .. "</color>" .. "/" .. data.maxPower
end

-- 移除按钮监听
function RemoveCallBack()
    if Controller.addGoldBtn ~= nil then
        Controller.addGoldBtn.onClick:RemoveListener(Controller.AddGold)
        Controller.addGoldBtn.onClick:Invoke()

        Controller.addDiamondBtn.onClick:RemoveListener(Controller.AddDiamond)
        Controller.addDiamondBtn.onClick:Invoke()

        Controller.addPowerBtn.onClick:RemoveListener(Controller.AddPower)
        Controller.addPowerBtn.onClick:Invoke()
    end
end

--[[

function Controller:Update()
    print("Menu Update")
end

]]
function Controller:OnDestroy()
    RemoveCallBack()
end

return Controller
