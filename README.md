<p align="center">
<img src="./assets/logo.png"/>
</p>

<div align="center">

# Yolx

`Yolx` 一款现代化下载工具！
  

</div>

---

`Yolx` 是一款以「Aria 2」作为核心的现代化下载工具。

## 🙌 简单的开始

如果想安装Yolx，请打开右侧的 [Release](/releases) 页面，找到最新版本，并选择适用于当前系统的安装包下载。


**Watch** 项目，以获取应用的更新动态。

## 🚀 协作

非常感谢有兴趣的开发者或爱好者参与 `Yolx` 项目，分享你的见解与思路。

## 🍭 编译

### Windows
#### 依赖安装

1、按照[官方文档](https://flutter.cn/docs/get-started/install/windows)安装`Flutter SDK`以及[Visual Studio 2022 生成工具](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)

2、安装打包工具[Inno Setup 6](https://jrsoftware.org/isinfo.php),并添加[中文语言包](https://jrsoftware.org/files/istrans/) `ChineseSimplified.isl` 和 `ChineseTraditional.isl` 到 `C:\Program Files (x86)\Inno Setup 6\Languages` 目录

3、按照[官方文档](https://distributor.leanflutter.dev/zh-hans/getting-started/)安装构建工具
#### 打包构建

在项目目录运行下面命令进行编译打包，构建完成后可在 `dist` 文件夹内找到安装包

```
flutter_distributor release --name windows
```