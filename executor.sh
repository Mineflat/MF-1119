#!/bin/bash

#DIRECTORY="test_data" # создано автоматически
DIRECTORY="/root/MFIP-1119/not-autocreated/" # создано НЕ автоматически

find "$DIRECTORY" -type f | while read -r file; do
	echo -e "- \e[1;34m$file:\e[0m"
# Uses all things
#	/root/MFIP-1119/source/MFIP-1119/MFIP-1119/bin/Debug/net8.0/MFIP-1119 $1 "$file" $2
# Only LibMIME, bit with magic-files
	/root/MFIP-1119/source/FileTypeDetector/bin/Release/net8.0/linux-x64/publish/FileTypeDetector "$file"
done
