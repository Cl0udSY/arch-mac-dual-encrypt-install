#!/bin/bash

tempSoftDir=tempSoft
localBin=~/.local/bin

function installFirefoxDev()
{
	firefoxDir=~/.local/.mozilla
	mkdir $firefoxDir
	wget "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
	tar -jxvf "firefox-*"
	mv ./firefox $firefoxDir
	ln -s $firefoxDir/firefox $localBin
}

function installRadare2()
{
	git clone https://github.com/radareorg/radare2
	cd radare2
	./sys/install.sh
	cd ..
	rm -rf ./radare2
	read -p "URL of the latest image of Cutter: " cutterVersion
	mv cutter* $localBin

}

# Install Alsa for Sound (check if pulseaudio needed)
pacman -S alsa-utils # Kernel Sound Driver

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Put all home's . conf file in home
cp home/* ~/

# To check conf and tweaks conf modif --> "dconf watch /"
# Set all users standard config (mouse, kb layout, shortcut, background, etc...)
cp background/<name_of_file> /usr/share/backgrounds/gnome/
cp ./conf/dconf/user ~/.config/dconf/

# Configure tweaks --> TODO for extensions check gnome-shell-extensions-installer
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#####
# Install softwares
#####
mkdir $localBin
mkdir $tempSoft
cd $tempSoft

installFirefoxDev
pacman -S xfce4-terminal
pacman -S android-tools android-udev

git clone https://aur.archlinux.org/scrcpy.git
cd scrcpy
makepkg -si
cd ..
rm -rf scrcpy

installRadare2
pacman -S aircrack-ng

#####
