/*
 在lua中实现页面加载和数据保存
 */
using UnityEngine;
using XLua;

//映射生命周期到lua
public delegate void LifeCycle();

//将Lua与Lua核心表对应的结构体
[GCOptimize]
public struct LuaBootstrap
{
    public LifeCycle Start;
    public LifeCycle Update;
    public LifeCycle OnDestroy;
}

public class Bootstrap : MonoBehaviour
{
    //Lua的核心table
    private LuaBootstrap bootstrap;

    // 调用Lua代码
    void Start()
    {
        DontDestroyOnLoad(this);

        xLuaEnv.Instance.DoString("require('Bootstrap')");

        //将lua的核心table,导入到C#端
        bootstrap = xLuaEnv.Instance.Global.Get<LuaBootstrap>("Bootstrap");
        bootstrap.Start();
    }

    void Update()
    {
        bootstrap.Update();
    }

    private void OnDisable()
    {
        bootstrap.OnDestroy();

        //释放Lua环境前，需要将导出到C#的Lua回调函数进行释放
        bootstrap.Start = null;
        bootstrap.Update = null;
        bootstrap.OnDestroy = null;
    }

    // 释放lua代码
    void OnDestroy()
    {
        xLuaEnv.Instance.Free();
    }
}
