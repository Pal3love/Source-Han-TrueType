#!/bin/bash


maximum_parallels=1
current_parallels=0

script_file_name="build_ttfs.sh"
otrebuild_win="otrebuild_win.exe"
otrebuild_mac="otrebuild_mac"
otrebuild_binary=${otrebuild_win}
otrebuild_wrapper=

binary_folder="binary"
release_folder="release"
script_folder="script"
source_folder="source"
temp_folder="temp"

font_grand_family="SourceHan"
font_mono_typeface="Mono"
font_sans_typeface="Sans"
font_sans_hw_typeface="SansHW"
font_serif_typeface="Serif"
font_lingual_typefaces=(${font_sans_hw_typeface} ${font_mono_typeface})
font_regional_typefaces=(${font_sans_typeface} ${font_serif_typeface})
font_typefaces=(${font_lingual_typefaces[@]} ${font_regional_typefaces[@]})

font_languages=(SC TC HC J K)
font_regions=(CN TW HK JP KR)
font_languages_and_regions=(${font_languages[@]} ${font_regions[@]})

font_mono_italic_appendix="It"
font_shared_weights=(ExtraLight Light Medium Heavy)
font_hw_weights=(Regular Bold)
font_sans_mono_special_weights=(Normal)
font_serif_spectial_weights=(SemiBold)
font_sans_mono_weights=(${font_shared_weights[@]} ${font_hw_weights[@]} ${font_sans_mono_special_weights[@]})
font_serif_weights=(${font_shared_weights[@]} ${font_hw_weights[@]} ${font_serif_spectial_weights[@]})


function print_usage_and_exit() {
    echo "Usage: ${script_file_name} <platform: wsl or mac> <maximum parallel jobs>"
    exit 1
}

function is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}

function set_platform() {
    case $1 in
      wsl)
        ;;
      linux)
        if grep -iq "magic 4d5a" /proc/sys/fs/binfmt_misc/*; then
            # 4d5a == "MZ", i.e. the PE magic.
            # Wine is registered as binfmt handler for PE files.
            # Do nothing; just act like WSL.
            :
        elif wine --help >/dev/null 2>&1; then
            # `wine` command available.
            # Call otrebuilder via `wine otrebuilder.exe`.
            otrebuild_wrapper="wine"
        else
            echo "Wine required"
            print_usage_and_exit
        fi
        ;;
      mac)
        otrebuild_binary=${otrebuild_mac}
        ;;
      *)
        print_usage_and_exit
    esac
    echo "Set platform to $1"
}

function set_parallels() {
    if ! is_number $1; then
        print_usage_and_exit
    elif [ $1 -gt 1 ]; then
        maximum_parallels=$1
    fi
    echo "Set maximum parallel jobs to ${maximum_parallels}"
}

function limit_parallels() {
    current_parallels=`expr ${current_parallels} + 1`
    if [ ${current_parallels} -gt ${maximum_parallels} ]; then
        wait
        current_parallels=1
    fi
}

function convert() {
    for font_path in *.otf; do
        font_file_name="${font_path##*/}"
        font_file="${font_file_name%.*}"
        limit_parallels; {
            ${otrebuild_wrapper} ../../${binary_folder}/${otrebuild_binary} --otf2ttf --UPM 2048 --removeGlyphNames --O1 -o ../../${temp_folder}/${font_file}.ttf ${font_path}
        } &
    done
    wait
}

function rename() {
    pattern=$1
    while [[ $# > 1 ]]; do
        shift
        new_file_name=$(echo "$1" | sed "${pattern}")
        mv $1 ${new_file_name}
    done
}

function add_japanese_language_code() {
    for font_typeface in ${font_typefaces[@]}; do
        rename "s/${font_grand_family}${font_typeface}-/${font_grand_family}${font_typeface}J-/" ${font_grand_family}${font_typeface}-*.ttf
    done
}

function make_ttc() {
    local font_typeface=$1  # Save first argument in a variable
    shift  # Shift all arguments to the left (original $1 gets lost)
    local font_weights=("$@")  # Rebuild the array with rest of arguments
    font_family="${font_grand_family}${font_typeface}"
    for font_weight in ${font_weights[@]}; do
        ttfs=""
        for font_language in ${font_languages[@]}; do
            ttfs+="${font_family}${font_language}-${font_weight}.ttf "
        done
        otf2otc -o ${font_family}-${font_weight}.ttc ${ttfs}
    done
}

function make_ttcs() {
    font_mono_italics=()
    for font_sans_mono_weight in ${font_sans_mono_weights[@]}; do
        font_mono_italics+=("${font_sans_mono_weight}${font_mono_italic_appendix}")
    done
    make_ttc ${font_mono_typeface} ${font_mono_italics[@]}
    make_ttc ${font_mono_typeface} ${font_sans_mono_weights[@]}
    make_ttc ${font_sans_typeface} ${font_sans_mono_weights[@]}
    make_ttc ${font_sans_hw_typeface} ${font_hw_weights[@]}
    make_ttc ${font_serif_typeface} ${font_serif_weights[@]}
}

function compress_ttc() {
    for font_typeface in ${font_typefaces[@]}; do
        limit_parallels; {
            ttcs=""
            for ttc_path in `ls ${font_grand_family}${font_typeface}-*.ttc`; do
                ttcs+="${ttc_path} "
            done
            zip ../${release_folder}/${font_grand_family}${font_typeface}.zip ${ttcs}
        } &
    done
    wait
}

function compress_ttf() {
    for font_typeface in ${font_regional_typefaces[@]}; do
        for font_region in ${font_regions[@]}; do
            limit_parallels; {
                ttfs=""
                for ttf_path in `ls ${font_grand_family}${font_typeface}${font_region}-*.ttf`; do
                    ttfs+="${ttf_path} "
                done
                zip ../${release_folder}/${font_grand_family}${font_typeface}${font_region}.zip ${ttfs}
            } &
        done
    done
    wait
}

function main() {
    # Go to root.
    cd ..

    # Clean up & recreate temp & output folders.
    rm -rf ${temp_folder}
    rm -rf ${release_folder}
    mkdir ${temp_folder}
    mkdir ${release_folder}

    # Convert all OTFs into TTFs.
    cd ${source_folder}/source-han-mono
    convert
    cd ../source-han-sans
    convert
    cd ../source-han-serif
    convert
    cd ../..

    # Insert Japanese language code "J".
    cd ${temp_folder}
    add_japanese_language_code

    # Combine lingual fonts into TTC files.
    make_ttcs

    # Compress font files into ZIPs.
    compress_ttc
    compress_ttf

    # Clean up.
    rm -f *.ttf
    rm -f *.ttc
    cd ..
    rm -rf ${temp_folder}
}


if [ $# != 2 ]; then
    print_usage_and_exit
else
    set_platform $1
    set_parallels $2
    sleep 3
    main
fi
