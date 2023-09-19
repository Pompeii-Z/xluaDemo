Prefabs = {}

-- 传入资源并生成 初始化面板
function Prefabs:Instantiate(prefab)
    local go = CS.UnityEngine.Object.Instantiate(prefab)

    local trs = go.transform
    trs:SetParent(CS.UnityEngine.GameObject.Find("/Canvas").transform)

    trs.localPosition = CS.UnityEngine.Vector3.zero
    trs.localRotation = CS.UnityEngine.Quaternion.identity
    trs.localScale = CS.UnityEngine.Vector3.one

    trs.offsetMin = CS.UnityEngine.Vector2.zero
    trs.offsetMax = CS.UnityEngine.Vector2.zero

    go.name = prefab.name

    return go
end
