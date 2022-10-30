#!/usr/bin/sh
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
sudo /usr/bin/curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | /usr/bin/bash && 
# sudo /usr/bin/install filebrowser /usr/local/bin/ && 
#
# SYSTEM CONFIGURATION
#
# STOP SERVICES
#
sudo /usr/bin/systemctl stop mysterium-node.service && 
sudo /usr/bin/systemctl stop pihole-FTL.service && 
#
# USER CREATION AND PERMISSION GRANTING
#
sudo /usr/bin/mkdir /var/lib/filebrowser && sudo /usr/sbin/adduser --system --group --HOME /var/lib/filebrowser/ --shell /usr/sbin/nologin --no-create-home filebrowser && 
sudo /usr/sbin/addgroup --system filebrowser && 
sudo /usr/sbin/adduser --system /sbin/nologin -H -h /var/lib/filebrowser -G filebrowser filebrowser && 
sudo /usr/bin/chown -Rc filebrowser:filebrowser /var/lib/filebrowser && 
sudo /usr/bin/touch /var/log/filebrowser.log && sudo /usr/bin/chown -c filebrowser:filebrowser /var/log/filebrowser.log && 
#
# MOUNT DEVICES AND REPLACE DEFAULT CONFIGURATION FILES WITH PRODUCTION ONES
#
sudo echo "UUID=d6689ad7-957a-4bfa-ab9b-5122a7ba077e /media/DataTraveler auto nosuid,nodev,nofail 0 0" >> /etc/fstab && 
if [ -f "/etc/motd" ]; then
sudo /usr/bin/rm /etc/motd 
else
sudo /usr/bin/cp motd /etc/motd
fi
if [ -d "/var/lib/mysterium-node/keystore/" ]; then
sudo /usr/bin/rm -rf /var/lib/mysterium-node/keystore
else
sudo /usr/bin/cp -r keystore/ /var/lib/mysterium-node/
fi
sudo /usr/bin/cp filebrowser.service /etc/systemd/filebrowser.service &&
sudo /usr/bin/mkdir /etc/filebrowser/ && sudo /usr/bin/cp .filebrowser.toml /etc/filebrowser/ && 
#
# ENABLE AND START SERVICES
#
# sudo /usr/bin/systemctl edit --force --full filebrowser && 
sudo /usr/bin/systemctl enable mysterium-node.service && sudo /usr/bin/systemctl start mysterium-node.service &&
sudo /usr/bin/systemctl enable stop pihole-FTL.service && sudo /usr/bin/systemctl start stop pihole-FTL.service &&
exit 0
