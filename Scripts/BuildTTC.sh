#!/bin/bash
# This bash script generates TrueType version of Source Han Sans.
# Note that this script depends on Adobe's AFDKO and otrebuilder, both on GitHub.

# Unpack otc files into separate otf files.
for font in *.ttc; do otc2otf $font; done

# Check and fix any potential checksum errors caused by AFDKO's otc2otf.
for font in *.otf; do sfntedit -f $font; done

# Convert otf files into ttf files with UPM 2048.
for fontPath in *.otf
do
	fontFileName="${fontPath##*/}"
	fontFilePre="${fontFileName%.*}"
	./otrebuild --otf2ttf --UPM 2048 --removeGlyphNames --O1 -o $fontFilePre.ttf $fontPath
done

# Pack ttf files into ttc files
mkdir output
otf2otc -o output/SourceHanSans-ExtraLight.ttc SourceHanSansSC-ExtraLight.ttf SourceHanSansTC-ExtraLight.ttf SourceHanSansHC-ExtraLight.ttf SourceHanSans-ExtraLight.ttf SourceHanSansK-ExtraLight.ttf
otf2otc -o output/SourceHanSans-Light.ttc SourceHanSansSC-Light.ttf SourceHanSansTC-Light.ttf SourceHanSansHC-Light.ttf SourceHanSans-Light.ttf SourceHanSansK-Light.ttf
otf2otc -o output/SourceHanSans-Normal.ttc SourceHanSansSC-Normal.ttf SourceHanSansTC-Normal.ttf SourceHanSansHC-Normal.ttf SourceHanSans-Normal.ttf SourceHanSansK-Normal.ttf
otf2otc -o output/SourceHanSans-Regular.ttc SourceHanSansSC-Regular.ttf SourceHanSansTC-Regular.ttf SourceHanSansHC-Regular.ttf SourceHanSans-Regular.ttf SourceHanSansK-Regular.ttf
otf2otc -o output/SourceHanSans-Medium.ttc SourceHanSansSC-Medium.ttf SourceHanSansTC-Medium.ttf SourceHanSansHC-Medium.ttf SourceHanSans-Medium.ttf SourceHanSansK-Medium.ttf
otf2otc -o output/SourceHanSans-Bold.ttc SourceHanSansSC-Bold.ttf SourceHanSansTC-Bold.ttf SourceHanSansHC-Bold.ttf SourceHanSans-Bold.ttf SourceHanSansK-Bold.ttf
otf2otc -o output/SourceHanSans-Heavy.ttc SourceHanSansSC-Heavy.ttf SourceHanSansTC-Heavy.ttf SourceHanSansHC-Heavy.ttf SourceHanSans-Heavy.ttf SourceHanSansK-Heavy.ttf
otf2otc -o output/SourceHanSansHW-Regular.ttc SourceHanSansHWSC-Regular.ttf SourceHanSansHWTC-Regular.ttf SourceHanSansHWHC-Regular.ttf SourceHanSansHW-Regular.ttf SourceHanSansHWK-Regular.ttf
otf2otc -o output/SourceHanSansHW-Bold.ttc SourceHanSansHWSC-Bold.ttf SourceHanSansHWTC-Bold.ttf SourceHanSansHWHC-Bold.ttf SourceHanSansHW-Bold.ttf SourceHanSansHWK-Bold.ttf

# Clean-ups
rm -f *.ttc
rm -f *.otf
rm -f *.ttf
