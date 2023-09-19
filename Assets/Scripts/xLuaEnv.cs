using System.IO;
using UnityEngine;
using XLua;

public class xLuaEnv
{
    #region Singleton

    private static xLuaEnv instance = null;

    //单例的核心实现
    public static xLuaEnv Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new xLuaEnv();
            }

            return instance;
        }
    }

    #endregion

    #region Create LuaEnv

    private LuaEnv luaEnv;

    //构造方法 创建单例的时候，Lua运行环境，会一起被创建
    private xLuaEnv()
    {
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(CustomLoader);
    }

    #endregion

    #region Loader

    //创建自定义Lua加载器，这样就可以任意订制项目的Lua脚本的存储位置
    private byte[] CustomLoader(ref string filepath)
    {
        //实际使用时需要指向Application.persistentDataPath
        string path = Application.dataPath;
        path = path.Substring(0, path.Length - 7) + "/DataPath/Lua/" + filepath + ".lua";

        if (File.Exists(path))
        {
            return File.ReadAllBytes(path);
        }
        else
        {
            return null;
        }
    }

    #endregion

    #region Free LuaEnv

    public void Free()
    {
        //释放LuaEnv，同时也释放单例对象，这样下次调单例对象，会再次产生Lua运行环境
        luaEnv.Dispose();
        instance = null;
    }

    #endregion

    #region 封装 Run Lua

    //luaEnv在此类已经私有化，通过封装一次DoString来给外部调用。
    public object[] DoString(string code)
    {
        return luaEnv.DoString(code);
    }

    //返回lua环境的全局变量
    public LuaTable Global
    {
        get { return luaEnv.Global; }
    }

    #endregion
}
