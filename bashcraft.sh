#!/bin/bash
# bashcraft, a minimal Minecraft launcher and updater
# crafted by Alex (Qwertylex), Alice Jenkinson (0x52a1) and maybe some more
# see https://github.com/Qwertylex/bashcraft/blob/master/README.md for details
# License: This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/

BashCraftVersion="v0.2"

# colors up in this thing
BRed='\033[1;31m'
BBlue='\033[1;34m'
BGreen='\033[1;32m'
BYellow='\033[1;33m'
BWhite='\033[1;37m'
NColor='\033[0m'

StatusInfo() { echo -e "$BBlue::$BWhite $*$NColor"; }
StatusAction() { echo -e "$BGreen::$BWhite $*$NColor"; }
StatusQuestion() { echo -e "$BYellow::$BWhite $*$NColor"; }
StatusError() { echo -e "$BRed::$BWhite $*$NColor"; }
ReadInput() { echo -ne "$BYellow::$BWhite $*$NColor " && read -e; }
ReadSilentInput() { echo -ne "$BYellow::$BWhite $*$NColor " && read -se && echo; }

# define some functions
DoMinecraftUpdate() {
    if [ ! "$MCdir" == "" ]; then # we might as well check if we have a valid dir i guess
        mkdir -p "$MCdir/bin"
        cd "$MCdir/bin"

        StatusInfo "Downloading OS natives..."
        case "$OS" in
            "Linux") curl -s -O http://s3.amazonaws.com/MinecraftDownload/linux_natives.jar;;
            "Darwin") curl -s -O http://s3.amazonaws.com/MinecraftDownload/macosx_natives.jar;;
            "SunOS") curl -s -O http://s3.amazonaws.com/MinecraftDownload/solaris_natives.jar;;
        esac

        StatusInfo "Extracting OS natives..."
        unzip -qq *_natives.jar -d natives
        rm *_natives.jar

        StatusInfo "Downloading LWJGL..."
        curl -s -O http://s3.amazonaws.com/MinecraftDownload/lwjgl.jar
        curl -s -O http://s3.amazonaws.com/MinecraftDownload/jinput.jar
        curl -s -O http://s3.amazonaws.com/MinecraftDownload/lwjgl_util.jar

        StatusInfo "Downloading Minecraft..."
        curl -s -O http://s3.amazonaws.com/MinecraftDownload/minecraft.jar

        StatusAction "Update complete."
    else
        StatusError "Internal error."
    fi
}

PrintHelp() {
    StatusQuestion "bashcraft $BashCraftVersion, a Bash Minecraft launcher"
    StatusQuestion "Usage: $0 [--force-update] [--remove-prefs] [--change-prefs] [--help]"
    StatusQuestion "For more information, see https://github.com/Qwertylex/bashcraft"
}

# determine what OS we're running under
OS=`uname -s`
case "$OS" in
    "Linux"|"SunOS") MCdir=~/.minecraft;;
    "Darwin") MCdir=~/Library/Application\ Support/minecraft;;
    *) StatusError "Unsupported operating system, exiting."; exit 2;;
esac
StatusInfo "OS is $OS, Minecraft directory is $MCdir"

# check command-line parameters
for ARG in "$@"; do
    case "$ARG" in
        "--force-update")
            StatusAction "Forcing Minecraft update"; DoMinecraftUpdate;;
        "--remove-prefs")
            rm "$MCdir/bashcraft-prefs"; exit;;
        "--change-prefs")
            rm "$MCdir/bashcraft-prefs";;
        "--help")
            PrintHelp; exit;;
        *)
            StatusError "Invalid option \"$ARG\", see $0 --help for info"; exit 1;;
    esac
done

# check if minecraft even exists
if [ ! -f "$MCdir/bin/minecraft.jar" ]; then
    # minecraft.jar doesn't exist, hand off to the updater
    StatusAction "minecraft.jar doesn't exist, forcing Minecraft update"
    DoMinecraftUpdate
fi

# check for authentication details
if [ ! -f "$MCdir/bashcraft-prefs" ]; then
    # we don't have any auth details, so request them
    StatusQuestion "No Minecraft authentication details found."
    StatusQuestion "If you don't have a Minecraft account, just press Enter."
    ReadInput "Username:"; username=$REPLY
    if [ ! "a$username" == "a" ]; then
        # we'll only get here if we were actually given a username
        # so, prompt for password here. just a little UX thing i guess
        ReadSilentInput "Password:"; password=$REPLY
    fi

    # save the details
    StatusAction "Saving preferences..."
    echo "username=\"$username\"" >  "$MCdir/bashcraft-prefs"
    echo "password=\"$password\"" >> "$MCdir/bashcraft-prefs"
    echo "MCoptions=\"\""         >> "$MCdir/bashcraft-prefs"
else
    # we have auth details, so load them
    StatusAction "Loading preferences..."
    source "$MCdir/bashcraft-prefs"
fi

# do the actual Minecraft launch
cd "$MCdir/bin"
java -Xms512M -Xmx1024M  -Xincgc \
    -cp "minecraft.jar:jinput.jar:lwjgl.jar:lwjgl_util.jar" \
    -Dorg.lwjgl.librarypath="$(pwd)/natives" \
    -Dnet.java.games.input.librarypath="$(pwd)/natives" \
    net.minecraft.client.Minecraft $username $password $MCoptions
