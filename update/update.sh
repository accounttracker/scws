#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.co);
versi=$(cat /home/version)
if [[ $versi == 2.0 ]]; then
echo "You Have The Latest Version"
fi
echo "Start Update"

clear
apt-get -y autoremove;
apt upgrade && apt replace -y

echo -e "${green}START UPDATE${NC}"
sleep 5

wget https://raw.githubusercontent.com/anzclan/scws/main/update/kemaskini.sh && chmod +x kemaskini.sh && ./kemaskini.sh

echo -e "${green}UPDATE SELESAI${NC}"
echo " Reboot 5 Sec"
sleep 5
rm -f kemaskini.sh
echo "beta2.0" > /home/version
reboot
