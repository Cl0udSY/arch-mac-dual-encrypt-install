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

function installRadare2Cutter()
{
	git clone https://github.com/radareorg/radare2
	cd radare2
	./sys/install.sh
	cd ..
	rm -rf ./radare2
	read -p "URL of the latest image of Cutter: " cutterVersion
	mv cutter* $localBin

}

# Configure Git
git config --global core.editor "vim"
git config --global pull.request true
read -p "Username for git: " gituser
git config --global user.name "$gituser"

# Install Alsa for Sound (check if pulseaudio needed)
pacman -S alsa-utils # Kernel Sound Driver

# Install Bluetooth
pacman -S bluez bluez-utils pulseaudio-bluetooth
systemctl enable bluetooth

# Install Oh My ZSH
pacman -R grml-zsh-config powerline-fonts
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Put all home's . conf file in home
cp home/* ~/

# To check conf and tweaks conf modif --> "dconf watch /"
# Set all users standard config (mouse, kb layout, shortcut, background, etc...)
cp background/<name_of_file> /usr/share/backgrounds/gnome/
cp ./conf/dconf/user ~/.config/dconf/

# Configure tweaks --> TODO for extensions check gnome-shell-extensions-installer
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

mkdir $localBin
mkdir $tempSoft
cd $tempSoft

#####
# Install Basic softwares
#####
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ..
rm -rf trizen

pacman -S jdk-openjdk

installFirefoxDev

pacman -S xfce4-terminal
pacman -S android-tools android-udev
trizen -S scrcpy

pacman -S tree
pacman -S imagemagick

#####
# Install Security Softwares
#####
installRadare2Cutter
pacman -S aircrack-ng
pacman -S gdb
trizen -S burpsuite
pacman -S upx

#####
