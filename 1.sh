#!/bin/sh
sudo /bin/apt update && 
sudo /bin/apt upgrade -y &&
# INSTALL PACKAGES FROM RASPBIAN REP
sudo /bin/apt install curl git net-tools neofetch ufw -y && 
# INSTALL OTHER PACKAGES
sudo /bin/curl -sSL https://install.pi-hole.net | bash && 
sudo -E /bin/bash -c "$(curl -s https://raw.githubusercontent.com/mysteriumnetwork/node/master/install.sh)"
# SYSTEM CONFIGURATION
