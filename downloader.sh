#!/bin/bash
#License: This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
echo "Not just a downloader, this can be used to update to latest version of minecraft!"
read -e -p "linux osx or solaris?: " choice

#Directorizer
case $choice in
"linux")
mkdir -p ~/minecraftBV/bin/ && cd ~/minecraftBV/bin/
  ;;
"osx")
mkdir -p ~/Library/Application\ Support/minecraft/bin/ && cd ~/Library/Application\ Support/minecraft/bin/
  ;;
"solaris")
mkdir -p ~/minecraftBV/bin/ && cd ~/minecraftBV/bin/
  ;;
esac

#Downloader
case $choice in
"linux")
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/linux_natives.jar -o linux_natives.jar
  ;;
"osx")
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/macosx_natives.jar -o macosx_natives.jar
  ;;
"solaris")
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/solaris_natives.jar -o solaris_natives.jar
  ;;
esac
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/lwjgl.jar -o lwjgl.jar
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/jinput.jar -o jinput.jar
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/lwjgl_util.jar -o lwjgl_util.jar
curl --create-dirs http://s3.amazonaws.com/MinecraftDownload/minecraft.jar -o minecraft.jar

#Natives extractor
unzip *_natives.jar -d natives
rm *_natives.jar

echo "DONE!! Ready to launch!"
