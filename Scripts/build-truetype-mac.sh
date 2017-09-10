#!/bin/bash
# This bash script generates TrueType version of Source Han Fonts.
# Note that this script depends on FontTools, Adobe's AFDKO and otRebuilder, all of which could be found on GitHub. Apple's Font Tools for xCode could be found at developer.apple.com/fonts.

# In one folder, convert OTF files into TTF in UPM 2048.
function otf2ttf() {
  for fontPath in *.otf
  do
    fontFileName="${fontPath##*/}"
    fontFile="${fontFileName%.*}"
    ../../../otrebuild-mac --otf2ttf --UPM 2048 --removeGlyphNames --O1 -o $fontFile.ttf $fontPath
  done
}

# Convert subset OTFs.
function convertSubset() {
  for folder in CN HK JP KR TW
  do
    cd $folder
    otf2ttf
    mv -f *.ttf ../../../subset/
    cd ..
  done
}

# Convert full OTFs.
function convertFull() {
  for folder in Japanese Korean SimplifiedChinese TraditionalChinese TraditionalChineseHK JapaneseHW KoreanHW SimplifiedChineseHW TraditionalChineseHW TraditionalChineseHKHW
  do
    cd $folder
    otf2ttf
    mv -f *.ttf ../../../full/
    cd ..
  done
}

# Convert mono OTFs.
function convertMono() {
  for folder in Bold ExtraLight Heavy Light Medium Normal Regular
  do
    cd $folder
    cd OTC
    otf2ttf
    mv -f *.ttf ../../../mono/
    cd ../..
  done
}

# Clean-up & recreate of output folders.
rm -rf subset
rm -rf full
rm -rf mono
rm -rf output
mkdir subset
mkdir full
mkdir mono
mkdir output

# Convert Source Han Sans Subset OTFs.
cd source-han-sans-2.004R/SubsetOTF
convertSubset
cd ../..

# Convert Source Han Serif Subset OTFs.
cd source-han-serif-2.001R/SubsetOTF
convertSubset
cd ../..

# Convert Source Han Sans full OTFs.
cd source-han-sans-2.004R/OTF
convertFull
cd ../..

# Convert Source Han Serif full OTFs.
cd source-han-serif-2.001R/OTF
convertFull
cd ../..

# Convert Source Han Sans Mono full OTFs.
cd source-han-mono-1.002
convertMono
cd ..

# Make Source Han Sans TTC files.
cd full
otf2otc -o SourceHanSans-Bold.ttc SourceHanSansSC-Bold.ttf SourceHanSansTC-Bold.ttf SourceHanSansHC-Bold.ttf SourceHanSans-Bold.ttf SourceHanSansK-Bold.ttf
otf2otc -o SourceHanSans-ExtraLight.ttc SourceHanSansSC-ExtraLight.ttf SourceHanSansTC-ExtraLight.ttf SourceHanSansHC-ExtraLight.ttf SourceHanSans-ExtraLight.ttf SourceHanSansK-ExtraLight.ttf
otf2otc -o SourceHanSans-Heavy.ttc SourceHanSansSC-Heavy.ttf SourceHanSansTC-Heavy.ttf SourceHanSansHC-Heavy.ttf SourceHanSans-Heavy.ttf SourceHanSansK-Heavy.ttf
otf2otc -o SourceHanSans-Light.ttc SourceHanSansSC-Light.ttf SourceHanSansTC-Light.ttf SourceHanSansHC-Light.ttf SourceHanSans-Light.ttf SourceHanSansK-Light.ttf
otf2otc -o SourceHanSans-Medium.ttc SourceHanSansSC-Medium.ttf SourceHanSansTC-Medium.ttf SourceHanSansHC-Medium.ttf SourceHanSans-Medium.ttf SourceHanSansK-Medium.ttf
otf2otc -o SourceHanSans-Normal.ttc SourceHanSansSC-Normal.ttf SourceHanSansTC-Normal.ttf SourceHanSansHC-Normal.ttf SourceHanSans-Normal.ttf SourceHanSansK-Normal.ttf
otf2otc -o SourceHanSans-Regular.ttc SourceHanSansSC-Regular.ttf SourceHanSansTC-Regular.ttf SourceHanSansHC-Regular.ttf SourceHanSans-Regular.ttf SourceHanSansK-Regular.ttf
otf2otc -o SourceHanSansHW-Bold.ttc SourceHanSansHWSC-Bold.ttf SourceHanSansHWTC-Bold.ttf SourceHanSansHWHC-Bold.ttf SourceHanSansHW-Bold.ttf SourceHanSansHWK-Bold.ttf
otf2otc -o SourceHanSansHW-Regular.ttc SourceHanSansHWSC-Regular.ttf SourceHanSansHWTC-Regular.ttf SourceHanSansHWHC-Regular.ttf SourceHanSansHW-Regular.ttf SourceHanSansHWK-Regular.ttf

# Make Source Han Serif TTC files.
otf2otc -o SourceHanSerif-Bold.ttc SourceHanSerifSC-Bold.ttf SourceHanSerifTC-Bold.ttf SourceHanSerifHC-Bold.ttf SourceHanSerif-Bold.ttf SourceHanSerifK-Bold.ttf
otf2otc -o SourceHanSerif-ExtraLight.ttc SourceHanSerifSC-ExtraLight.ttf SourceHanSerifTC-ExtraLight.ttf SourceHanSerifHC-ExtraLight.ttf SourceHanSerif-ExtraLight.ttf SourceHanSerifK-ExtraLight.ttf
otf2otc -o SourceHanSerif-Heavy.ttc SourceHanSerifSC-Heavy.ttf SourceHanSerifTC-Heavy.ttf SourceHanSerifHC-Heavy.ttf SourceHanSerif-Heavy.ttf SourceHanSerifK-Heavy.ttf
otf2otc -o SourceHanSerif-Light.ttc SourceHanSerifSC-Light.ttf SourceHanSerifTC-Light.ttf SourceHanSerifHC-Light.ttf SourceHanSerif-Light.ttf SourceHanSerifK-Light.ttf
otf2otc -o SourceHanSerif-Medium.ttc SourceHanSerifSC-Medium.ttf SourceHanSerifTC-Medium.ttf SourceHanSerifHC-Medium.ttf SourceHanSerif-Medium.ttf SourceHanSerifK-Medium.ttf
otf2otc -o SourceHanSerif-Regular.ttc SourceHanSerifSC-Regular.ttf SourceHanSerifTC-Regular.ttf SourceHanSerifHC-Regular.ttf SourceHanSerif-Regular.ttf SourceHanSerifK-Regular.ttf
otf2otc -o SourceHanSerif-SemiBold.ttc SourceHanSerifSC-SemiBold.ttf SourceHanSerifTC-SemiBold.ttf SourceHanSerifHC-SemiBold.ttf SourceHanSerif-SemiBold.ttf SourceHanSerifK-SemiBold.ttf
cd ..

# Make Source Han Mono TTC files.
cd mono
otf2otc -o SourceHanMono-Bold.ttc SourceHanMonoSC-Bold.ttf SourceHanMonoTC-Bold.ttf SourceHanMonoHC-Bold.ttf SourceHanMono-Bold.ttf SourceHanMonoK-Bold.ttf
otf2otc -o SourceHanMono-BoldIt.ttc SourceHanMonoSC-BoldIt.ttf SourceHanMonoTC-BoldIt.ttf SourceHanMonoHC-BoldIt.ttf SourceHanMono-BoldIt.ttf SourceHanMonoK-BoldIt.ttf
otf2otc -o SourceHanMono-ExtraLight.ttc SourceHanMonoSC-ExtraLight.ttf SourceHanMonoTC-ExtraLight.ttf SourceHanMonoHC-ExtraLight.ttf SourceHanMono-ExtraLight.ttf SourceHanMonoK-ExtraLight.ttf
otf2otc -o SourceHanMono-ExtraLightIt.ttc SourceHanMonoSC-ExtraLightIt.ttf SourceHanMonoTC-ExtraLightIt.ttf SourceHanMonoHC-ExtraLightIt.ttf SourceHanMono-ExtraLightIt.ttf SourceHanMonoK-ExtraLightIt.ttf
otf2otc -o SourceHanMono-Heavy.ttc SourceHanMonoSC-Heavy.ttf SourceHanMonoTC-Heavy.ttf SourceHanMonoHC-Heavy.ttf SourceHanMono-Heavy.ttf SourceHanMonoK-Heavy.ttf
otf2otc -o SourceHanMono-HeavyIt.ttc SourceHanMonoSC-HeavyIt.ttf SourceHanMonoTC-HeavyIt.ttf SourceHanMonoHC-HeavyIt.ttf SourceHanMono-HeavyIt.ttf SourceHanMonoK-HeavyIt.ttf
otf2otc -o SourceHanMono-Light.ttc SourceHanMonoSC-Light.ttf SourceHanMonoTC-Light.ttf SourceHanMonoHC-Light.ttf SourceHanMono-Light.ttf SourceHanMonoK-Light.ttf
otf2otc -o SourceHanMono-LightIt.ttc SourceHanMonoSC-LightIt.ttf SourceHanMonoTC-LightIt.ttf SourceHanMonoHC-LightIt.ttf SourceHanMono-LightIt.ttf SourceHanMonoK-LightIt.ttf
otf2otc -o SourceHanMono-Medium.ttc SourceHanMonoSC-Medium.ttf SourceHanMonoTC-Medium.ttf SourceHanMonoHC-Medium.ttf SourceHanMono-Medium.ttf SourceHanMonoK-Medium.ttf
otf2otc -o SourceHanMono-MediumIt.ttc SourceHanMonoSC-MediumIt.ttf SourceHanMonoTC-MediumIt.ttf SourceHanMonoHC-MediumIt.ttf SourceHanMono-MediumIt.ttf SourceHanMonoK-MediumIt.ttf
otf2otc -o SourceHanMono-Normal.ttc SourceHanMonoSC-Normal.ttf SourceHanMonoTC-Normal.ttf SourceHanMonoHC-Normal.ttf SourceHanMono-Normal.ttf SourceHanMonoK-Normal.ttf
otf2otc -o SourceHanMono-NormalIt.ttc SourceHanMonoSC-NormalIt.ttf SourceHanMonoTC-NormalIt.ttf SourceHanMonoHC-NormalIt.ttf SourceHanMono-NormalIt.ttf SourceHanMonoK-NormalIt.ttf
otf2otc -o SourceHanMono-Regular.ttc SourceHanMonoSC-Regular.ttf SourceHanMonoTC-Regular.ttf SourceHanMonoHC-Regular.ttf SourceHanMono-Regular.ttf SourceHanMonoK-Regular.ttf
otf2otc -o SourceHanMono-RegularIt.ttc SourceHanMonoSC-RegularIt.ttf SourceHanMonoTC-RegularIt.ttf SourceHanMonoHC-RegularIt.ttf SourceHanMono-RegularIt.ttf SourceHanMonoK-RegularIt.ttf
cd ..

# Apple's ftxmakettc also does the same job.
# Example:
# ftxmakettc SourceHanSansSC-ExtraLight.ttf SourceHanSansTC-ExtraLight.ttf SourceHanSansHC-ExtraLight.ttf SourceHanSans-ExtraLight.ttf SourceHanSansK-ExtraLight.ttf output/SourceHanSans-ExtraLight.ttc

# UniteTTC.exe also does the same job.
# Example:
# unitettc SourceHanSans-ExtraLight.ttc SourceHanSansSC-ExtraLight.ttf SourceHanSansTC-ExtraLight.ttf SourceHanSansHC-ExtraLight.ttf SourceHanSans-ExtraLight.ttf SourceHanSansK-ExtraLight.ttf

# Create subset ZIP files.
cd subset
zip SourceHanSansCN.zip SourceHanSansCN-Bold.ttf SourceHanSansCN-ExtraLight.ttf SourceHanSansCN-Heavy.ttf SourceHanSansCN-Light.ttf SourceHanSansCN-Medium.ttf SourceHanSansCN-Normal.ttf SourceHanSansCN-Regular.ttf
zip SourceHanSansHK.zip SourceHanSansHK-Bold.ttf SourceHanSansHK-ExtraLight.ttf SourceHanSansHK-Heavy.ttf SourceHanSansHK-Light.ttf SourceHanSansHK-Medium.ttf SourceHanSansHK-Normal.ttf SourceHanSansHK-Regular.ttf
zip SourceHanSansJP.zip SourceHanSansJP-Bold.ttf SourceHanSansJP-ExtraLight.ttf SourceHanSansJP-Heavy.ttf SourceHanSansJP-Light.ttf SourceHanSansJP-Medium.ttf SourceHanSansJP-Normal.ttf SourceHanSansJP-Regular.ttf
zip SourceHanSansKR.zip SourceHanSansKR-Bold.ttf SourceHanSansKR-ExtraLight.ttf SourceHanSansKR-Heavy.ttf SourceHanSansKR-Light.ttf SourceHanSansKR-Medium.ttf SourceHanSansKR-Normal.ttf SourceHanSansKR-Regular.ttf
zip SourceHanSansTW.zip SourceHanSansTW-Bold.ttf SourceHanSansTW-ExtraLight.ttf SourceHanSansTW-Heavy.ttf SourceHanSansTW-Light.ttf SourceHanSansTW-Medium.ttf SourceHanSansTW-Normal.ttf SourceHanSansTW-Regular.ttf
zip SourceHanSerifCN.zip SourceHanSerifCN-Bold.ttf SourceHanSerifCN-ExtraLight.ttf SourceHanSerifCN-Heavy.ttf SourceHanSerifCN-Light.ttf SourceHanSerifCN-Medium.ttf SourceHanSerifCN-Regular.ttf SourceHanSerifCN-SemiBold.ttf
zip SourceHanSerifHK.zip SourceHanSerifHK-Bold.ttf SourceHanSerifHK-ExtraLight.ttf SourceHanSerifHK-Heavy.ttf SourceHanSerifHK-Light.ttf SourceHanSerifHK-Medium.ttf SourceHanSerifHK-Regular.ttf SourceHanSerifHK-SemiBold.ttf
zip SourceHanSerifJP.zip SourceHanSerifJP-Bold.ttf SourceHanSerifJP-ExtraLight.ttf SourceHanSerifJP-Heavy.ttf SourceHanSerifJP-Light.ttf SourceHanSerifJP-Medium.ttf SourceHanSerifJP-Regular.ttf SourceHanSerifJP-SemiBold.ttf
zip SourceHanSerifKR.zip SourceHanSerifKR-Bold.ttf SourceHanSerifKR-ExtraLight.ttf SourceHanSerifKR-Heavy.ttf SourceHanSerifKR-Light.ttf SourceHanSerifKR-Medium.ttf SourceHanSerifKR-Regular.ttf SourceHanSerifKR-SemiBold.ttf
zip SourceHanSerifTW.zip SourceHanSerifTW-Bold.ttf SourceHanSerifTW-ExtraLight.ttf SourceHanSerifTW-Heavy.ttf SourceHanSerifTW-Light.ttf SourceHanSerifTW-Medium.ttf SourceHanSerifTW-Regular.ttf SourceHanSerifTW-SemiBold.ttf
mv -f *.zip ../output/
cd ..

# Create full ZIP file.
cd full
zip SourceHanSans.zip SourceHanSans-Bold.ttc SourceHanSans-ExtraLight.ttc SourceHanSans-Heavy.ttc SourceHanSans-Light.ttc SourceHanSans-Medium.ttc SourceHanSans-Normal.ttc SourceHanSans-Regular.ttc
zip SourceHanSansHW.zip SourceHanSansHW-Bold.ttc SourceHanSansHW-Regular.ttc
zip SourceHanSerifThin.zip SourceHanSerif-ExtraLight.ttc SourceHanSerif-Light.ttc SourceHanSerif-Regular.ttc SourceHanSerif-Medium.ttc
zip SourceHanSerifBold.zip SourceHanSerif-SemiBold.ttc SourceHanSerif-Bold.ttc SourceHanSerif-Heavy.ttc
mv -f *.zip ../output/
cd ..

# Create mono ZIP file.
cd mono
zip SourceHanMono.zip SourceHanMono-Bold.ttc SourceHanMono-ExtraLight.ttc SourceHanMono-Heavy.ttc SourceHanMono-Light.ttc SourceHanMono-Medium.ttc SourceHanMono-Normal.ttc SourceHanMono-Regular.ttc
zip SourceHanMonoIt.zip SourceHanMono-BoldIt.ttc SourceHanMono-ExtraLightIt.ttc SourceHanMono-HeavyIt.ttc SourceHanMono-LightIt.ttc SourceHanMono-MediumIt.ttc SourceHanMono-NormalIt.ttc SourceHanMono-RegularIt.ttc
mv -f *.zip ../output/
cd ..

# Remove all temporary files.
rm -rf subset
rm -rf full
rm -rf mono
