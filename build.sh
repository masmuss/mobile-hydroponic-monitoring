#!/bin/bash

# shellcheck disable=SC2034
current_datetime=$(date +"%Y%m%d_%H%M%S")
version=$(grep -o 'version: .*' pubspec.yaml | sed 's/version: //')

# remove quote from version
version=$(echo "$version" | tr -d "'\"")

# get build type from command line argument (debug or release)
build_type=$1

flutter build apk --"$build_type"

# shellcheck disable=SC2140
build_apk_filename="hydroponic_v$version"_"$build_type"_"$current_datetime.apk"
mv build/app/outputs/flutter-apk/app-"$build_type".apk ~/apk_build/"$build_apk_filename"

printf "build successful: %s\n" "$build_apk_filename"