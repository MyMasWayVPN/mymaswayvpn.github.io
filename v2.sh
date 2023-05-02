dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
echo -e "PLEASE WAIT"
sleep 3
clear
echo -e "Checking VPS"
sleep 3
clear
BURIQ () {
curl -sS https://raw.githubusercontent.com/MyMasWayVPN/MyMasWayVPN.github.io/main/wkwkwkwk > /root/tmp
data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
for user in "${data[@]}"
do
exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
d1=(`date -d "$exp" +%s`)
d2=(`date -d "$biji" +%s`)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
echo $user > /etc/.$user.ini
else
rm -f /etc/.$user.ini > /dev/null 2>&1
fi
done
rm -f /root/tmp
}
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/MyMasWayVPN/MyMasWayVPN.github.io/main/wkwkwkwk | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)
Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
if [ "$CekOne" = "$CekTwo" ]; then
res="Expired"
fi
else
res="Permission Accepted..."
fi
}
PERMISSION () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/MyMasWayVPN/MyMasWayVPN.github.io/main/wkwkwkwk | awk '{print $4}' | grep $MYIP)
if [ "$MYIP" = "$IZIN" ]; then
Bloman
else
res="Permission Denied!"
fi
BURIQ
}
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
apt intall lolcat -y
mkdir -p /etc/xray
echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 2
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 1
totet=`uname -r`
REQUIRED_PKG="linux-headers-$totet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
sleep 2
echo -e "[ ${yell}WARNING${NC} ] Try to install ...."
echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
apt-get --yes install $REQUIRED_PKG
sleep 1
echo ""
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] If error you need.. to do this"
sleep 1
echo ""
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] 1. apt update -y"
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] 2. apt upgrade -y"
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] 3. apt dist-upgrade -y"
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] 4. reboot"
sleep 1
echo ""
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] After rebooting"
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] Then run this script again"
echo -e "[ ${tyblue}NOTES${NC} ] Notes, Script Mod By MasWayVPN"
echo -e "[ ${tyblue}NOTES${NC} ] if you understand then tap enter now.."
read
else
echo -e "[ ${green}INFO${NC} ] Oke installed"
fi
ttet=`uname -r`
ReqPKG="linux-headers-$ttet"
if ! dpkg -s $ReqPKG  >/dev/null 2>&1; then
rm /root/v2.sh >/dev/null 2>&1
exit
else
clear
fi
secs_to_human() {
echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
coreselect=''
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
END
chmod 644 /root/.profile
echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Allright good ... installation file is ready"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check permission : "
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted!"
else
red "Permission Denied!"
rm v2.sh > /dev/null 2>&1
sleep 10
exit 0
fi
sleep 3
mkdir -p /etc/ssnvpn
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/mwvpn/theme
mkdir -p /var/lib/ssnvpn-pro >/dev/null 2>&1
echo "IP=" >> /var/lib/ssnvpn-pro/ipvps.conf
if [ -f "/etc/xray/domain" ]; then
echo ""
echo -e "[ ${green}INFO${NC} ] Script Already Installed"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to install again ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm v2.sh
sleep 10
exit 0
else
clear
fi
fi
echo ""
wget -q https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear
apt install lolcat -y
mkdir /var/lib/mwvpn-pro;
echo "IP=" >> /var/lib/mwvpn-pro/ipvps.conf
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m          ⇱ Select Your Domain ⇲                      \E[0m"
echo -e   "\E[44;1;39m            ⇱ SC VPS PREMIUM ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
echo -e   "[${GREEN} 01 ${NC}]. •mwvpn.tech"
echo -e   "[${GREEN} 02 ${NC}]. •indossh.ninja"
echo -e   "[${GREEN} 03 ${NC}]. •indossh.me"
echo -e   "[${GREEN} 04 ${NC}]. •masway-vpn.my.id"
echo -e   "[${GREEN} 05 ${NC}]. •myindossh.tech"
echo -e   "[${GREEN} 06 ${NC}]. •nextvpn.xyz"
echo -e   "[${GREEN} 07 ${NC}]. •aiosc.me"
echo -e "==================================================" | lolcat
read -p   "Select From Options [ 1 - 6 ] : " domen
echo -e  ""
case $domen in
1)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m             ⇱ mwvpn.tech ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=mwvpn.tech
SUB_DOMAIN=vip-${sub}.mwvpn.tech
NS_DOMAIN=ns-${subns}.mwvpn.tech
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf mwvpn.sh
sleep 3
cd
;;
2)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m            ⇱ indossh.ninja ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=indossh.ninja
SUB_DOMAIN=vip-${sub}.indossh.ninja
NS_DOMAIN=ns-${subns}.indossh.ninja
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf indosshninja.sh
sleep 3
cd
;;
3)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m             ⇱ indossh.me ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=indossh.me
SUB_DOMAIN=vip-${sub}.indossh.me
NS_DOMAIN=ns-${subns}.indossh.me
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf indosshme.sh
sleep 3
cd
;;
4)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m           ⇱ masway-vpn.my.id ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=masway-vpn.my.id
SUB_DOMAIN=vip-${sub}.masway-vpn.my.id
NS_DOMAIN=ns-${subns}.masway-vpn.my.id
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf maswayvpn.sh
sleep 3
cd
;;
5)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m            ⇱ myindossh.tech ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=myindossh.tech
SUB_DOMAIN=vip-${sub}.myindossh.tech
NS_DOMAIN=ns-${subns}.myindossh.tech
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf myindossh.sh
sleep 3
cd
;;
6)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m             ⇱ nextvpn.xyz ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=nextvpn.xyz
SUB_DOMAIN=vip-${sub}.nextvpn.xyz
NS_DOMAIN=ns-${subns}.nextvpn.xyz
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf nextvpn.sh
sleep 3
cd
;;
7)
clear
echo -e "==================================================" | lolcat
echo -e   "\E[44;1;39m        ⇱ Your Select SubDomain ⇲                      \E[0m"
echo -e   "\E[44;1;39m             ⇱ aiosc.me ⇲                    \E[0m"
echo -e "=================================================="  | lolcat
sleep 4
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /root/nsdomain
rm nsdomain

sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
subns=$(</dev/urandom tr -dc a-x0-9 | head -c5)
DOMAIN=aiosc.me
SUB_DOMAIN=vip-${sub}.aiosc.me
NS_DOMAIN=ns-${subns}.aiosc.me
CF_ID=akunabal.abal7770@gmail.com
CF_KEY=4502348bc050806208bb10e3a1af5b9d1d018

set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Updating DNS NS for ${NS_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${SUB_DOMAIN}'","ttl":120,"proxied":false}')
echo "$NS_DOMAIN" >> /root/nsdomain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/lib/mwvpn-pro/ipvps.conf
cp /root/domain /etc/xray
echo "-------------------------------------" | lolcat
echo "     YOUR SUB DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
echo "-------------------------------------" | lolcat
echo "DOMAIN = $SUB_DOMAIN " | lolcat
echo "NS DOMAIN = $NS_DOMAIN " | lolcat
echo "-------------------------------------" | lolcat
rm -rf aioscme.sh
sleep 3
cd
;;
esac
cat <<EOF>> /etc/mwvpn/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/mwvpn/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/mwvpn/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/mwvpn/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/mwvpn/theme/magenta
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/mwvpn/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/mwvpn/theme/color.conf
blue
EOF
figlet -f slant SSH-OVPN | lolcat
sleep 2
echo "-------------------------------------" | lolcat
echo "     Install SSH & OpenVPN " | lolcat
echo "-------------------------------------" | lolcat
sleep 2
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/ssh/ohp.sh && chmod +x ohp.sh && ./ohp.sh
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/ovpn/vpn.sh && chmod +x vpn.sh && ./vpn.sh
clear
figlet -f slant XRAY | lolcat
sleep 2
echo "-------------------------------------" | lolcat
echo "     Install Xray " | lolcat
echo "-------------------------------------" | lolcat
sleep 3
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
clear
figlet -f slant Websocket | lolcat
sleep 2
echo "-------------------------------------" | lolcat
echo "     Install Websocket " | lolcat
echo "-------------------------------------" | lolcat
sleep 3
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/websocket/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/websocket/nontls.sh && chmod +x nontls.sh && ./nontls.sh
clear
figlet -f slant SlowDNS | lolcat
sleep 2
echo "-------------------------------------" | lolcat
echo "     Install SlowDNS " | lolcat
echo "-------------------------------------" | lolcat
sleep 3
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/slowdnss/install-sldns && chmod +x install-sldns && ./install-sldns
clear
figlet -f slant Menu | lolcat
sleep 2
echo "-------------------------------------" | lolcat
echo "     X-TRA MENU " | lolcat
echo "-------------------------------------" | lolcat
sleep 2
clear
wget https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/update/update.sh && chmod +x update.sh && ./update.sh
clear
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
clear
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/MyMasWayVPN/tunnel/main/version  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps
echo " "
clear
figlet -f slant MasWay-VPN | lolcat
sleep 2
echo "=====================-[ AutoScript MW-VPN ]-===================="
echo ""
echo "------------------------------------------------------------"
echo ""
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80 [OFF]" | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo "   - SSH NON-SSL Websocket   : 8880" | tee -a log-install.txt
echo "   - SLOWDNS                 : 5300" | tee -a log-install.txt
echo "   - OpenVPN                 : 1194, 2200, 990" | tee -a log-install.txt
echo "   - Stunnel4                : 445, 777" | tee -a log-install.txt
echo "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7900" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Sodosok WS/GRPC         : 443" | tee -a log-install.txt
echo "   - SSH OHP                 : 8181" | tee -a log-install.txt
echo "   - DB OHP            : 8282" | tee -a log-install.txt
echo "   - OVPN OHP             : 8383" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On           : $aureb:00 $gg GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Contact : t.me/maswayvpn (Text Only)"  | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------"
echo ""
echo "===============-[ Script MW-VPN  ]-==============="
echo -e ""
echo ""
echo "" | tee -a log-install.txt
rm /root/cf.sh >/dev/null 2>&1
rm /root/auto-pointing.sh >/dev/null 2>&1
rm /root/setup.sh >/dev/null 2>&1
rm /root/insshws.sh
rm /root/indosshme.sh
rm /root/myindossh.sh
rm /root/indosshninja.sh
rm /root/mwvpn.sh
rm /root/nextvpn.sh
rm /root/insshws.sh
rm /root/update.sh
rm /root/nontls.sh
rm /root/ohp.sh
rm /root/v2.sh
rm /root/install-sldns
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "
"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
