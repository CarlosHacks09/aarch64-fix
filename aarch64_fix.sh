echo "Are you root? If you are not root, this script will have no effect on your system. Continue?"
read -n1 -r -p "Press any key to continue..." key
dpkg --add-architecture i386
dpkg --add-architecture armhf
sed 's/^deb http/deb [arch=arm64] http/' -i '/etc/apt/sources.list'
touch /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse" | tee /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/i386.list
echo "deb [arch=i386] http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/i386.list
sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list
sudo add-apt-repository universe
sudo apt update
sudo apt full-upgrade -y
sudo reboot
