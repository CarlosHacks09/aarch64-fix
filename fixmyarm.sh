#!/bin/bash

# Check if user is root
echo "Are you root? If you are not root, this script will have no effect on your system. Continue?"
read -n1 -r -p "Press any key to continue..." key

dpkg --add-architecture i386
dpkg --add-architecture armhf

# Get the current Ubuntu versioncodename
version=$(lsb_release -cs)

# Update sources list based on version
sed -i "s/jammy/$version/g" '/etc/apt/sources.list.d/i386.list'

# Update sources list for i386
touch /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://security.ubuntu.com/ubuntu/$version-security main restricted universe multiverse" | tee /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/$version main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/$version-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/$version-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/i386.list

sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list
sudo add-apt-repository universe
sudo apt update
sudo apt full-upgrade -y

# Ask user for reboot confirmation
echo "The system is now upgraded. Reboot recommended."
read -n1 -r -p "Would you like to reboot now (y/N)? " reboot_choice

if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
  sudo reboot
else
  exit
fi
