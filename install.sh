#!/bin/bash

# Important step
# Before installing, do the patitionning in macOS
# Create two partitions beside your macOS partition:
#	- boot --> 280Mb
#	- linux --> all the space left

##############################
#### Step for ISO install ####
##############################

############
### Install: https://wiki.archlinux.org/index.php/Installation_guide
############

# Set keymap
# loadkeys fr-pc

# Connect to network through WiFi
# ip link set <interface> up
# echo -e "ctrl_interface=/run/wpa_supplicant\nupdate_config=1" > /etc/wpa_supplicant/wpa_supplicant.conf
# wpa_passphrase <SSID> <passphrase> >> /etc/wpa_supplicant/wpa_supplicant.conf
# killall wpa_supplicant && wpa_supplicant -B -i <interface> -c /etc/wpa_supplicant/wpa_supplicant.conf
# dhclient

# Update the System Clock
# timedatectl set-ntp true

##############
### Encryption: https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition
##############

# All partitionning has already been done in macOS

# Format and encrypt the non-boot partition
# cryptsetup -y -v luksFormat /dev/<partition>
# cryptsetup open /dev/<partition> cryptroot
# mkfs.ext4 /dev/mapper/cryptroot
# mount /dev/mapper/cryptroot /mnt

# Check if all work and remount
# umount /mnt
# cryptsetup close cryptroot
# cryptsetup open /dev/<partition> cryptroot
# mount /dev/mapper/cryptroot /mnt

# Format the boot partition
# mkfs.ext4 /dev/<boot_partition>
# mkfs.fat -F32 /dev/<boot_partition> --> for EFI system
# parted <boot_partition> set esp on 
# mkdir /mnt/boot
# mount /dev/<boot_partition> /mnt/boot

# Set all closest country mirror's packages in the list
# vim /etc/pacman.d/mirrorlist

# Install essential packages
# pacstrap /mnt base base-devel linux linux-firmware intel-ucode efibootmgr

# Generate an fstab file
# genfstab -U /mnt >> /mnt/etc/fstab

# Chroot in /mnt
# arch-chroot /mnt

# Install Live minimal Packages
# curl https://github.com/<path_to_startpackages>
# pacman -S $(cat startpackages)

# Set the Timezone
# ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
# hwclock --systohc

# Set the localization
# vim /etc/locale.gen --> Uncomment the line fr_FR.UTF-8
# locale-gen
# vim /etc/locale.conf --> Add in this new file the line: LANG=fr_FR.UTF-8

# Create hostname file
# vim /etc/hostname --> Write your hostname
# vim /etc/hosts --> Write this in it:
# 
# 127.0.0.1		localhost
# ::1			localhost
# 127.0.1.1		hostname.localdomain hostname

# Recreate mkinitcpio
# vim /etc/mkinitcpio.conf --> change HOOKS line with this line:
# 	- HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck)
# mkinitcpio -P 

# Setup the bootloader to live with macOS UEFI  
# bootctl --path=/boot install
# vim /boot/loader/loader.conf --> Write this:
#	- default arch.conf
# 	- timeout 4
#	- editor no
# blkid --> Get the UUID of the encrypted partition
# vim /boot/loader/entries/arch.conf --> Write this:
#	- title Arch Linux
#	- linux /vmlinuz-linux
#	- initrd /intel-code.img
#	- initrd /initramfs-linux.img
#	- options cryptdevice=UUID=<uuid_of_partition>:cryptroot root=/dev/mapper/cryptroot quiet rw intel_iommu=on

# Set root passwd
# passwd

# Then reboot the system, hold Option and choose EFI --> Select Arch

##############################

############################################
#### Userland install and configuration ####
############################################

# This part must be launched with the root account
# after the OS Installation

# Setup WiFi Network

modprobe brcmfmac
sed -i -e 's/blacklist brcmfmac/#blacklist brcmfmac'

read -p "Enter your Wireless Interface: " wint
ip link set $wint up
echo -e "ctrl_interface=/run/wpa_supplicant\nupdate_config=1" > /etc/wpa_supplicant/wpa_supplicant.conf

read -p "Enter the SSID: " ssid
read -ps "Enter the passphrase: " passphrase
wpa_passphrase $ssid $passphrase >> /etc/wpa_supplicant/wpa_supplicant.conf

killall wpa_supplicant && wpa_supplicant -B -i $wint -c /etc/wpa_supplicant/wpa_supplicant.conf
dhclient

# Update the system
pacman -Syy
pacman -Syu

# Install zsh
pacman -S zsh

# install Xorg



# Create new user and add to Sudo group






