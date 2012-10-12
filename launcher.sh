#!/bin/bash
#Alex's Minecraft launcher
#License: This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
read -e -p "linux osx or solaris?: " choice
read -e -p "Username: " user
echo "NOTE: Password is not needed unless you have a premium account and want to log in."
read -e -p "Password: " pass
#Game Launcher
case $choice in
"linux")
cd ~/minecraftBV/bin/; java -Xms512M -Xmx1024M  -Xincgc -cp "minecraft.jar:jinput.jar:lwjgl.jar:lwjgl_util.jar" -Dorg.lwjgl.librarypath="$(pwd)/natives" -Dnet.java.games.input.librarypath="$(pwd)/natives" net.minecraft.client.Minecraft $user $pass
  ;;
"osx")
cd ~/Library/Application\ Support/minecraft/bin; java -Xms512M -Xmx1024M  -Xincgc -cp "minecraft.jar:jinput.jar:lwjgl.jar:lwjgl_util.jar" -Dorg.lwjgl.librarypath="$(pwd)/natives" -Dnet.java.games.input.librarypath="$(pwd)/natives" net.minecraft.client.Minecraft $user $pass
  ;;
"solaris")
cd ~/minecraftBV/bin/; java -Xms512M -Xmx1024M  -Xincgc -cp "minecraft.jar:jinput.jar:lwjgl.jar:lwjgl_util.jar" -Dorg.lwjgl.librarypath="$(pwd)/natives" -Dnet.java.games.input.librarypath="$(pwd)/natives" net.minecraft.client.Minecraft $user $pass
  ;;
esac
