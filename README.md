[English](README-EN.md)

# 思源 TrueType
**思源黑体、思源宋体和思源等宽的 TrueType 版本**

**思源黑体**、**思源宋体**以及**思源等宽**是由 Adobe 主导开发的开源及跨中日韩地区的多语言字库。这些字库的 OpenType/CFF 文件以及 CID 源文件均由 [SIL 开源字库协议，版本 1.1](http://scripts.sil.org/OFL) 授权（另请参阅[常见问题](http://scripts.sil.org/cms/scripts/page.php?item_id=OFL-FAQ_web)）。

本项目在完整保留曲线精度、尺寸和功能的前提下，提供思源所有字体的 **TrueType 版本**。TrueType 格式在 Microsoft Windows、Microsoft Office 以及前端领域的兼容性要优于 OpenType/CFF (OTF) 格式。本项目提供的所有 TrueType 字体均可与思源 OTF 原版无缝替换，无需返工修订设计文稿。


## 下载与安装

请前往[**发布页面**](https://github.com/Pal3love/Source-Han-TrueType/releases)下载最新版本的压缩包，解压后即可得到 TTF/TTC 字体文件。当前页面的“Code”按钮仅包含转换所需的代码和源文件，不包含 TrueType 字体。

* [macOS](https://support.apple.com/en-us/HT201749)
* [Linux](https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116)
* [Windows](https://www.microsoft.com/en-us/Typography/TrueTypeInstall.aspx)
* **Windows 用户请注意**：从 Windows 10 1809 开始，Windows 会将字体文件默认安装到用户文件夹下，该行为可能会导致一部分软件找不到字体。建议在字体文件上单击右键，选择“为所有用户安装”，以全局安装。


## 技术规格

* **OpenType 功能（竖排支持等）**：完整收录
* **Microsoft Office Style-Link**：加粗按钮（B）链接常规与粗体字重
* **Microsoft Office 字体嵌入**：支持 Word、Excel、PowerPoint 等软件的字体嵌入功能
* **封装格式**：完整版为 TrueType Collection (TTC)，子集版为 TrueType (TTF)
* **曲线格式**：二次贝塞尔曲线
* **曲线精度（UPM）**：2048，即原版 OpenType/CFF 三次曲线的无损转换
* **屏显渲染策略**：全字号亚像素抗锯齿（Windows 10）


## 可变版本

Adobe 官方已提供思源黑体和思源宋体可变版 TrueType 字体，请前往以下发布页面下载。

* [思源黑体可变版](https://github.com/adobe-fonts/source-han-sans/releases)
* [思源宋体可变版](https://github.com/adobe-fonts/source-han-serif/releases)


## Adobe 软件的行高过大问题

Adobe 软件（如 Photoshop、Illustrator）的行高过大问题是由 OTF 原版字体中的“3 em vertical dash”字符所导致的。思源字体的全局字框为了容纳该字符而撑得很高。本项目与思源 OTF 原版的所有功能保持完全一致，因而**不会**修改该设计。**如需修正行高的版本，请前往[梦源字体系列](https://github.com/Pal3love/dream-han-cjk)，**该系列除修正行高之外，更提供了多达 29 个字重的丰富选择。**


## 编译

如需在本地完成转换过程，请参考以下指南。

### 硬盘空间

脚本将生成约 5 GB 临时文件。临时文件将在运行结束时自动删除。

### 平台依赖

本项目支持 Windows Linux 子系统（WSL）与 macOS 平台。请先确保以下依赖已安装：

* Python 3.8 及以上
* PyPI 包管理（`pip`）
* `pip install afdko`: [Adobe Font Development Kit for OpenType (AFDKO)](https://github.com/adobe-type-tools/afdko)
* `sudo apt install zip`（仅供 WSL，macOS 已自带）
* `sudo apt install rename`（仅供 WSL，macOS 已自带）

### 执行脚本

* WSL: `cd` 进 script 目录后，执行 `./build_ttfs.sh wsl <最大并行数>`
* macOS: `cd` 进 script 目录后，执行 `./build_ttfs.sh mac <最大并行数>`
* 其中，**最大并行数**决定最多并行处理的字体数量。每个字体占用约 1.5 CPU 线程和最多 600 MB 内存，请根据自己的电脑配置酌情选择。譬如，AMD Ryzen 9 3950X 可将此参数设为 28，在内存足够的情况下，可达 97% CPU 使用率。
* 脚本运行完成后，最终字体的 ZIP 压缩包将位于根目录下新创建的 release 目录内。运行过程中产生的临时文件将会在结束时自动删除。


## 更多信息

如需获取 Adobe 思源系列字体的设计、使用以及其他信息，请访问以下官方 GitHub 仓库。

* [思源黑体](https://github.com/adobe-fonts/source-han-sans)
* [思源宋体](https://github.com/adobe-fonts/source-han-serif)
* [思源等宽](https://github.com/adobe-fonts/source-han-mono)
