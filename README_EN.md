<p align="center">
<img src="./assets/logo.png" style="width:100px;height:100px;"/>
</p>

<div align="center">

# Yolx

`Yolx` is a modern download tool!

</div>

---

English | [简体中文](../../)

`Yolx` is a modern download tool with "Aria 2" at its core.

## 🙌 Getting Started

To install Yolx, please open the [Release](https://github.com/uiYzzi/Yolx/releases) page on the right, find the latest version, and select the installation package suitable for your current system.

**Watch** the project for updates on the application.

## 🚀 Collaboration

Thank you very much to developers or enthusiasts interested in participating in the `Yolx` project. Share your insights and ideas.

## 🍭 Compilation

### Windows
#### Dependency Installation

1. Follow the [official documentation](https://flutter.cn/docs/get-started/install/windows) to install `Flutter SDK` and [Visual Studio 2022 Build Tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022).

2. Install the packaging tool [Inno Setup 6](https://jrsoftware.org/isinfo.php), and add the [Chinese language packs](https://jrsoftware.org/files/istrans/) `ChineseSimplified.isl` and `ChineseTraditional.isl` to the `C:\Program Files (x86)\Inno Setup 6\Languages` directory.

3. Follow the [official documentation](https://distributor.leanflutter.dev/zh-hans/getting-started/) to install the build tools.
#### Packaging and Building

Run the following command in the project directory to compile and package. After the build is complete, you can find the installation package in the `dist` folder.

```
flutter_distributor release --name windows
```

### Linux
#### Dependency Installation

1. Follow the [official documentation](https://flutter.cn/docs/get-started/install/linux) to install `Flutter SDK`.

2. Enter the following command to install build dependencies:
```
sudo apt-get install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev libayatana-appindicator3-dev
```

3. Follow the [official documentation](https://distributor.leanflutter.dev/zh-hans/getting-started/) to install the build tools.

4. Enter the following command to install packaging dependencies:
```
sudo apt install rpm patchelf locate libfuse2 fuse
wget -O appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod +x appimagetool
sudo mv appimagetool /usr/local/bin/
```

#### Packaging and Building

Run the following command in the project directory to compile and package. After the build is complete, you can find the installation package in the `dist` folder.

```
flutter_distributor release --name linux
```

## 🫸 Acknowledgments
- [LeanFlutter](https://github.com/leanflutter)
- [星火计划 Project Spark](https://gitee.com/spark-store-project)