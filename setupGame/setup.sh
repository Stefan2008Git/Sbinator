#!/bin/bash

echo Hello and welcome to official Sbinator setup for Linux environment, so please take a seat and wait to install important stuff for developing!
sleep 2
echo Checking if you are running setup script as doas/root/sudo user
sleep 2

# Check if you are running script as sudo user
if [[ $EUID -ne 0 ]]; then
   echo This script must be run as root 
   exit 1
fi

# Checks what Linux distribution you have and what package manager you use
if command -v apt-get &> /dev/null; then
    DISTRO="debian"
elif command -v dnf &> /dev/null; then
    DISTRO="fedora"
elif command -v pacman &> /dev/null; then
    DISTRO="arch"
elif command -v zypper &> /dev/null; then
    DISTRO="opensuse"
elif command -v eopkg &> /dev/null; then
    DISTRO="solus"
else
    echo This Linux distribution does not have Haxe package available on official repo, so aborting!
    exit 1
fi

PACKAGE_TO_INSTALL="haxe" # Haxe package

case "$DISTRO" in
    "debian")
        echo Detected Debian-based system. Installing Haxe using apt.
        apt-get update
        apt-get install "$PACKAGE_TO_INSTALL"
        ;;
    "fedora")
        echo Detected Fedora-based system. Installing Haxe using dnf.
        dnf install "$PACKAGE_TO_INSTALL"
        ;;
    "arch")
        echo Detected Arch-based system. Installing Haxe using pacman.
        pacman -S "$PACKAGE_TO_INSTALL"
        ;;
    "opensuse")
        echo Detected openSUSE-based system. Installing Haxe using zypper
        zypper install "$PACKAGE_TO_INSTALL"
        ;;
    "solus")
        echo Detected SolusOS-based system. Installing Haxe using eopkg
        eopkg install "$PACKAGE_TO_INSTALL"
        ;;
    *)
        echo "No specific package manager found for $DISTRO."
        exit 1
        ;;
esac

echo "Haxe is installed sucessfully on $DISTRO!"
sleep 5
echo Making Haxelib directory on home folder and setuping it
mkdir ~/.local/share/haxelib && haxelib setup ~/.local/share/haxelib
sleep 2
echo Downloading and installing all required Haxelib libraries for compiling the game "(Note that this will depend on your internet speed)"..
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install lime
haxelib install lime-samples
haxelib install openfl
haxelib install hxcpp
haxelib install hxdiscord_rpc
sleep 2
echo All required libraries for Haxelib are downloaded and installed successfully. Setuping Lime..
haxelib run lime setup
sleep 1
echo Setup is done. You can check library list here
haxelib list
