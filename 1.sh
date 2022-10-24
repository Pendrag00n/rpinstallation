#!/bin/sh
# THIS SCRIPT SHOULD BE RAN IN INSIDE THE "nave" FOLDER!!
#
sudo /usr/bin/apt update && 
sudo /usr/bin/apt upgrade -y && 
#
# INSTALL PACKAGES FROM RASPBIAN REP
#
sudo /usr/bin/apt install curl git net-tools neofetch ufw fail2ban -y && 
#
# INSTALL OTHER PACKAGES
#
sudo /usr/bin/curl -sSL https://install.pi-hole.net | /usr/bin/bash && 
sudo -E /usr/bin/bash -c "$(curl -s https://raw.githubusercontent.com/mysteriumnetwork/node/master/install.sh)" && 
sudo /usr/bin/curl -L https://install.pivpn.io | /usr/bin/bash && 
sudo /usr/bin/curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | /usr/bin/bash && sudo /usr/bin/install filebrowser /usr/local/bin/ && 
#
# SYSTEM CONFIGURATION
#
sudo echo "UUID=d6689ad7-957a-4bfa-ab9b-5122a7ba077e /media/DataTraveler auto nosuid,nodev,nofail 0 0" >> /etc/fstab && 
sudo /usr/bin/systemctl stop mysterium-node.service &&
sudo /usr/bin/rm -rf /var/lib/mysterium-node/keystore && /usr/bin/mv -r keystore/ /var/lib/mysterium-node/ &&
sudo /usr/bin/systemctl enable mysterium-node.service && sudo /usr/bin/systemctl start mysterium-node.service &&
sudo /usr/bin/mv filebrowser.service /etc/systemd/filebrowser.service &&
