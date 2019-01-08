#!/bin/bash
# This bash script generates TrueType version of Source Han Sans Subset.
# Note that this script depends on Adobe's AFDKO and otrebuilder, both on GitHub.

# Convert otf files into ttf files with UPM 2048.
for folder in CN TW HK JP KR
do
	cd $folder
	for fontPath in *.otf
	do
		fontFileName="${fontPath##*/}"
		fontFilePre="${fontFileName%.*}"
		../otrebuild --otf2ttf --UPM 2048 --removeGlyphNames --O1 -o $fontFilePre.ttf $fontPath
		rm $fontPath
	done
	cd ..
done
