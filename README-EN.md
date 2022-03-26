[简体中文](README.md)

# Source Han TrueType
**TrueType Version of Source Han Sans, Source Han Serif and Source Han Mono**

Adobe-branded *Source Han Sans*, *Source Han Serif*, and *Source Han Mono* are open source Pan-CJK typefaces whose OpenType/CFF fonts and CID-based sources are covered under the terms of the [SIL Open Font License, Version 1.1](http://scripts.sil.org/OFL) (also see the [FAQ](http://scripts.sil.org/cms/scripts/page.php?item_id=OFL-FAQ_web)).

This project provides the lossless *TrueType version* of all Source Han fonts, without any curve accuracy, metrics and functionality change. In general, TrueType format presents better compatibility than OpenType/CFF (OTF) on Microsoft Windows, Microsoft Office and front-end web applications. All TrueType fonts released by this project are interchangeable with the OTF version, so documents using OTF will not need to revise.


## Download and Installation

Please visit the [**release page**](https://github.com/Pal3love/Source-Han-TrueType/releases) to get latest ZIP files containing all TTF/TTC fonts. Clicking "Code" button on this page will only download code and source files without release.

* [macOS](https://support.apple.com/en-us/HT201749)
* [Linux](https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116)
* [Windows](https://www.microsoft.com/en-us/Typography/TrueTypeInstall.aspx)
* **Attention for Windows users**: since the 1809 update, Windows 10 will by default install the font files under user folder instead of `Windows\fonts`, which leads to the missing font issue on some applications. It is recommended to right-click the font files and choose "Install for all users" to install the fonts globally.


## Specification

* **OpenType features including vertical writing support**: all included
* **Microsoft Office style link**: the Bold button (B) links Regular and Bold weight
* **Microsoft Office font embedding**: full supported on Word, Excel, PowerPoint, etc.
* **Font container format**: TrueType Collection (TTC) for language-specific version and TrueType (TTF) for region-specific version
* **Curve format**: quadratic Bézier curve
* **Units-per-em (UPM)**: 2048, i.e. lossless conversion from the OpenType/CFF source
* **Render strategy**: full-range subpixel anti-aliasing (since Windows 10)


## Variable Fonts

The Adobe official repo has provided TrueType version of variable Source Han Sans and Source Han Serif. Please visit their release page to download.

* [Source Han Sans variable](https://github.com/adobe-fonts/source-han-sans/releases)
* [Source Han Serif variable](https://github.com/adobe-fonts/source-han-serif/releases)


## Overlarge Line Height Concern on Adobe Applications

The overlarge line height issue on Adobe applications such as Photoshop and Illustrator is caused by the shape of "3 em vertical dash" glyph from the OTF version. The global font box is overly set to accommodate this glyph. Given the use case of this repo, i.e. full interchangeability from the OTF version, this project **will not** change this design. **To fix it, please visit [Dream Han CJK](https://github.com/Pal3love/dream-han-cjk)**, a Source-Han-inspired open-sourced font project to provide up to 29 weights.


## Compilation

To reproduce the font conversion process locally, please refer to the following guidance.

### Disk Space

~ 5 GB temporary files will be generated. They will be auto deleted at the end of the process.

### Dependency

Windows Subsystem on Linux (WSL) and macOS platform are both supported. Please make sure the following dependencies have set up:

* Python 3.8 and above
* PyPI (`pip`)
* `pip install afdko`: [Adobe Font Development Kit for OpenType (AFDKO)](https://github.com/adobe-type-tools/afdko)
* `sudo apt install zip` (WSL only, already bundled with macOS)
* `sudo apt install rename` (WSL only, already bundled with macOS)

### Build Fonts

* WSL: `cd` into script folder and execute `./build_ttfs.sh wsl <maximum parallel jobs>`
* macOS: `cd` into script folder and execute `./build_ttfs.sh mac <maximum parallel jobs>`
* The **maximum parallel jobs** decides the maximum number of fonts processed in parallel. Each font will take ~ 1.5 CPU threads and up to 600 MB memory. Please choose the best number for your machine. For example, AMD Ryzen 9 3950X is good at 28, taking up to 97% CPU usage, given enough memory.
* After the script, the final ZIP files will be located at new-created release folder. All temporary files will be auto deleted once the script is done.


## More Information

For information about design, usage and more of Source Han fonts, please refer to the following official repos.

* [Source Han Sans](https://github.com/adobe-fonts/source-han-sans)
* [Source Han Serif](https://github.com/adobe-fonts/source-han-serif)
* [Source Han Mono](https://github.com/adobe-fonts/source-han-mono)
