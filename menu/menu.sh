#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
NC='\e[0m'

# // Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP )
if [[ $MYIP = $IZIN ]]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
rm -f menu
exit 0
fi
clear

#########################

#EXPIRED
expired=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $3}')
echo $expired > /root/expired.txt
today=$(date -d +1day +%Y-%m-%d)
while read expired
do
	exp=$(echo $expired | curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $3}')
	if [[ $exp < $today ]]; then
		Exp2="\033[1;31mExpired\033[0m"
        else
        Exp2=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $3}')
	fi
done < /root/expired.txt
rm /root/expired.txt
name=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $2}')

# Color Validation
RED='\033[0;31m'                                                                                          
GREEN='\033[0;32m'                                                                                        
ORANGE='\033[0;33m'
BLUE='\033[0;34m'                                                                                         
PURPLE='\033[0;35m'
CYAN='\033[0;36m'                                                                                         
NC='\033[0;37m'
LIGHT='\033[0;37m'
yell='\e[33m'
red='\e[31m'
cyan='\e[36m'
bl='\e[36;1m'



# // VPS Information
# // Domain
domain=$(cat /etc/mon/xray/domain)

# // Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi

# // OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"

# //Download
# // Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"

# // Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"

# // Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"

# // Getting CPU Information
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
Sver=$(cat /home/version)
tele=$(cat /home/contact)
JAM=$(date +%r)
DAY=$(date +%A)
DATE=$(date +%d.%m.%Y)
IPVPS=$(curl -s ipinfo.io/ip )

# // Ver Xray & V2ray
verxray="$(/usr/local/bin/xray -version | awk 'NR==1 {print $2}')"                                                                                                                                                                                                    

# // Bash
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion

clear 
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "\033[30;5;47m                 ⇱ SCRIPT MENU ⇲                  \033[m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"                                                                                    
echo -e "\e[5;33m Isp Name                :${NC}  $ISP"
echo -e "\e[5;33m City                    :${NC}  $CITY"
echo -e "\e[5;33m Domain                  :${NC}  $domain"	
echo -e "\e[5;33m Ip Vps                  :${NC}  $IPVPS"	
echo -e "\e[5;33m Time                    :${NC}  $JAM"
echo -e "\e[5;33m Day                     :${NC}  $DAY"
echo -e "\e[5;33m Date                    :${NC}  $DATE"
echo -e "\e[5;33m Xray Version            :${NC}  ${PURPLE}$verxray${NC}"                                                                                                                                                                                                 
echo -e "\e[5;33m Script Version          :${NC}  ${BLUE}$Sver${NC}"
echo -e "\e[5;33m Telegram                :${NC}  $tele"
echo -e "\e[5;33m Certificate status      :${NC}  \e[33mExpired in ${tlsStatus} days\e[0m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e "\e[33m Traffic\e[0m       \e[33mToday      Yesterday     Month   "
echo -e "\e[33m Download\e[0m      $dtoday    $dyest       $dmon   \e[0m"
echo -e "\e[33m Upload\e[0m        $utoday    $uyest       $umon   \e[0m"
echo -e "\e[33m Total\e[0m       \033[0;36m  $ttoday    $tyest       $tmon  \e[0m "
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "\033[30;5;47m             ⇱ MANTERNETVPN PROJECT ⇲             \033[m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e " [${CYAN}•1${NC}] SSH & OpenVPN Menu  [${CYAN}•5${NC}] STATUS Service"                                                                                                                                                                                      
echo -e " [${CYAN}•2${NC}] Wireguard Menu      [${CYAN}•6${NC}] VPS Information"
echo -e " [${CYAN}•3${NC}] XRAY Menu           [${CYAN}•7${NC}] PORT Info"
echo -e " [${CYAN}•4${NC}] SYSTEM Menu         [${CYAN}•8${NC}] CLEAR RAM Cache"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
echo -e   ""
echo -e " [${CYAN}11${NC}] TRIAL Menu"
echo -e " [${RED}22${NC}] ${RED}REBOOT${NC}"
echo -e ""
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "${CYAN}Client Name    :${NC} $name"                                                                                                                                                                                                                        
echo -e "${CYAN}Script Expired :${NC} $exp"                                                                                                                                                                                                                        
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[37m"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; m-sshovpn ;;
2) clear ; menu-wg ;;
3) clear ; menu-xray ;;
4) clear ; m-system ;;
5) clear ; status ;;
6) clear ; vpsinfo ;;
7) clear ; info ;;
8) clear ; clearcache ;;
11) clear ; menu-trial ;;
22) clear ; reboot ;;
x) exit ;;
esac
