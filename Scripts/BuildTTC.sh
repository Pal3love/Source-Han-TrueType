#!/bin/bash
# This bash script generates TrueType version of Source Han Sans.
# Note that this script depends on Adobe's AFDKO and otRebuilder, both of which could be found on GitHub. Apple's Font Tools for XCode could be found at developer.apple.com/fonts.

# Clean-up of previous output files.
rm -rf Full

# Create the work folder.
mkdir temp

# Locate to the source directory.
cd source-han-sans-2.000R/OTF

# Copy source files to the temporary directory.
for folder in Japanese JapaneseHW Korean KoreanHW SimplifiedChinese SimplifiedChineseHW TraditionalChinese TraditionalChineseHK TraditionalChineseHKHW TraditionalChineseHW
do
	cd $folder
	cp *.otf ../../../temp/
	cd ..
done

# Locate to the work directory.
cd ../../temp

# Convert otf files into ttf files in UPM 2048.
for fontPath in *.otf
do
	fontFileName="${fontPath##*/}"
	fontFilePre="${fontFileName%.*}"
	../otrebuild-mac --otf2ttf --UPM 2048 --removeGlyphNames --O1 -o $fontFilePre.ttf $fontPath
done

# Pack ttf files into ttc files.
mkdir Full
otf2otc -o Full/SourceHanSans-ExtraLight.ttc SourceHanSansSC-ExtraLight.ttf SourceHanSansTC-ExtraLight.ttf SourceHanSansHC-ExtraLight.ttf SourceHanSans-ExtraLight.ttf SourceHanSansK-ExtraLight.ttf
otf2otc -o Full/SourceHanSans-Light.ttc SourceHanSansSC-Light.ttf SourceHanSansTC-Light.ttf SourceHanSansHC-Light.ttf SourceHanSans-Light.ttf SourceHanSansK-Light.ttf
otf2otc -o Full/SourceHanSans-Normal.ttc SourceHanSansSC-Normal.ttf SourceHanSansTC-Normal.ttf SourceHanSansHC-Normal.ttf SourceHanSans-Normal.ttf SourceHanSansK-Normal.ttf
otf2otc -o Full/SourceHanSans-Regular.ttc SourceHanSansSC-Regular.ttf SourceHanSansTC-Regular.ttf SourceHanSansHC-Regular.ttf SourceHanSans-Regular.ttf SourceHanSansK-Regular.ttf
otf2otc -o Full/SourceHanSans-Medium.ttc SourceHanSansSC-Medium.ttf SourceHanSansTC-Medium.ttf SourceHanSansHC-Medium.ttf SourceHanSans-Medium.ttf SourceHanSansK-Medium.ttf
otf2otc -o Full/SourceHanSans-Bold.ttc SourceHanSansSC-Bold.ttf SourceHanSansTC-Bold.ttf SourceHanSansHC-Bold.ttf SourceHanSans-Bold.ttf SourceHanSansK-Bold.ttf
otf2otc -o Full/SourceHanSans-Heavy.ttc SourceHanSansSC-Heavy.ttf SourceHanSansTC-Heavy.ttf SourceHanSansHC-Heavy.ttf SourceHanSans-Heavy.ttf SourceHanSansK-Heavy.ttf
otf2otc -o Full/SourceHanSansHW-Regular.ttc SourceHanSansHWSC-Regular.ttf SourceHanSansHWTC-Regular.ttf SourceHanSansHWHC-Regular.ttf SourceHanSansHW-Regular.ttf SourceHanSansHWK-Regular.ttf
otf2otc -o Full/SourceHanSansHW-Bold.ttc SourceHanSansHWSC-Bold.ttf SourceHanSansHWTC-Bold.ttf SourceHanSansHWHC-Bold.ttf SourceHanSansHW-Bold.ttf SourceHanSansHWK-Bold.ttf

# Apple's ftxmakettc also does the same job.
# ftxmakettc SourceHanSansSC-ExtraLight.ttf SourceHanSansTC-ExtraLight.ttf SourceHanSansHC-ExtraLight.ttf SourceHanSans-ExtraLight.ttf SourceHanSansK-ExtraLight.ttf output/SourceHanSans-ExtraLight.ttc
# ftxmakettc SourceHanSansSC-Light.ttf SourceHanSansTC-Light.ttf SourceHanSansHC-Light.ttf SourceHanSans-Light.ttf SourceHanSansK-Light.ttf output/SourceHanSans-Light.ttc
# ftxmakettc SourceHanSansSC-Normal.ttf SourceHanSansTC-Normal.ttf SourceHanSansHC-Normal.ttf SourceHanSans-Normal.ttf SourceHanSansK-Normal.ttf output/SourceHanSans-Normal.ttc
# ftxmakettc SourceHanSansSC-Regular.ttf SourceHanSansTC-Regular.ttf SourceHanSansHC-Regular.ttf SourceHanSans-Regular.ttf SourceHanSansK-Regular.ttf output/SourceHanSans-Regular.ttc
# ftxmakettc SourceHanSansSC-Medium.ttf SourceHanSansTC-Medium.ttf SourceHanSansHC-Medium.ttf SourceHanSans-Medium.ttf SourceHanSansK-Medium.ttf output/SourceHanSans-Medium.ttc
# ftxmakettc SourceHanSansSC-Bold.ttf SourceHanSansTC-Bold.ttf SourceHanSansHC-Bold.ttf SourceHanSans-Bold.ttf SourceHanSansK-Bold.ttf output/SourceHanSans-Bold.ttc
# ftxmakettc SourceHanSansSC-Heavy.ttf SourceHanSansTC-Heavy.ttf SourceHanSansHC-Heavy.ttf SourceHanSans-Heavy.ttf SourceHanSansK-Heavy.ttf output/SourceHanSans-Heavy.ttc
# ftxmakettc SourceHanSansHWSC-Regular.ttf SourceHanSansHWTC-Regular.ttf SourceHanSansHWHC-Regular.ttf SourceHanSansHW-Regular.ttf SourceHanSansHWK-Regular.ttf output/SourceHanSansHW-Regular.ttc
# ftxmakettc SourceHanSansHWSC-Bold.ttf SourceHanSansHWTC-Bold.ttf SourceHanSansHWHC-Bold.ttf SourceHanSansHW-Bold.ttf SourceHanSansHWK-Bold.ttf output/SourceHanSansHW-Bold.ttc

# Locate to the root directory.
mv Full ../
cd ..

# Clean-ups
rm -rf temp
