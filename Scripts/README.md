## Prerequisites
1. Python 3
2. `pip install afdko`
3. `pip install fonttools`
4. `pip install cu2qu`
5. `sudo apt install zip` on Windows Ubuntu (WSL)

## Instructions

Extract from ZIP and put the original OTF/OTC font folders here, such as
* `source-han-mono-1.002` 
* `source-han-sans-2.004R`
* `source-han-serif-2.001R`

They can be downloaded using the following links:
* [source-han-sans-2.004R.zip](https://github.com/adobe-fonts/source-han-sans/archive/refs/tags/2.004R.zip)
* [source-han-serif-2.001R.zip](https://github.com/adobe-fonts/source-han-serif/archive/refs/tags/2.001R.zip)
* [source-han-mono-1.002.zip](https://github.com/adobe-fonts/source-han-mono/archive/refs/tags/1.002.zip)

To build with single thread (slow) and low memory requirements (< 2 GB max), run `build-truetype-wsl.sh` on Windows Ubuntu (WSL), or `build-truetype-mac.sh` on macOS.

To build with multi-thread (fast) and high memory requirements (< 20 GB max), run `build-truetype-parallel-wsl.sh` on Windows Ubuntu (WSL), or `build-truetype-parallel-mac.sh` on macOS.
