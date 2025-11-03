#!/bin/bash
#scripts of first setting on Linux-server
#step 1 - Update system
echo "updating system..."
sudo apt update && sudo apt upgrade -y
# step 2 - Installing based packet
echo "Install packets"
sudo apt install -u \
	curl \
	vim \
	wget \
	htop \
	net-tools \
	iputils-ping \
	telnet \
	unzip \
	zip \
	gnupg \
	software-properites-common \
	build-essential

#step 3 Create new user
echo "create new users..."
read -p "print new username: " username
useradd -m -s /bin/bash $username
usermod -aG sudo $username
#step 4 Settings for SSH
echo "Setting SSH..."
sed -i 's/#PremitRootLogin prohibit-password/PremitRootLogin no/g' /etc/ssh/ssh_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd
#step 5 Time set
echo "Time set..."
timedatectl set-timezone Europe/Moscow
timedatectl set-ntp true
#Step 6 Firewall
echo "Settings Firewall..."
ufw allow ssh
ufw enable
#Step 7 Clearning
echo "Clear system..."
apt-get autoremove -y
apt-get clean

echo "Settings is done!"
echo "recommend: sudo reboot"
