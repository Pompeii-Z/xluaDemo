using System.IO;
using UnityEditor;
using UnityEngine;

//Editor AB包导出工具
public class ExportAB
{
    [MenuItem("AB包导出/Windows")]
    static void ForWin()
    {
        BuildAB(BuildTarget.StandaloneWindows64);
    }

    [MenuItem("AB包导出/Android")]
    static void ForAndroid()
    {
        BuildAB(BuildTarget.Android);
    }

    [MenuItem("AB包导出/IOS")]
    static void ForIOS()
    {
        BuildAB(BuildTarget.iOS);
    }

    private static void BuildAB(BuildTarget platform)
    {
        string path = "DataPath/AB";
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }
        //全路径为：项目名/AssetBundles

        //AB包存储路径，压缩格式LZ4 | 如果有了也强制重新导出AB包，平台Win64
        BuildPipeline.BuildAssetBundles(
            path,
            BuildAssetBundleOptions.ChunkBasedCompression | BuildAssetBundleOptions.ForceRebuildAssetBundle,
            platform
                    );

        Debug.Log("导出完成：" + Application.dataPath.Substring(0, Application.dataPath.Length - 6) + path);
    }
}
