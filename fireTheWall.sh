#!/bin/bash
# ms1450
#./fireTheWall.sh
# Optional Arguments: -s To allow SSH, -h To allow HTTP, HTTPS
#
ufw disable
ufw reset
ufw enable
echo "Setting Up Firewall..."
ufw default deny incomming
ufw default allow outgoing
while getopts sh flag
do
    case "${flag}" in
        s) ufw allow ssh;;
	h) ufw allow 80;ufw allow 443;;	
    esac
done
ufw reload
echo "Done";
