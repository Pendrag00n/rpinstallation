#!/bin/sh
sudo /bin/apt update && sudo /bin/apt upgrade -y && sudo /bin/apt install curl git net-tools neofetch ufw -y && /bin/curl -sSL https://install.pi-hole.net | bash && sudo -E /bin/bash -c "$(curl -s https://raw.githubusercontent.com/mysteriumnetwork/node/master/install.sh)"
