#!/bin/bash
# ms1450
# Lists a bunch of IMPORTANT information
#
# Lists all the users on the machine
echo "ok"
echo "---------------------------------------------------------------------------"
l_min=$(grep "^UID_MIN" /etc/login.defs)
l_max=$(grep "^UID_MAX" /etc/login.defs)
awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max ) print $0}' /etc/passwd | awk -F':' '{print $1}' > users
grep '^sudo:.*$' /etc/group | cut -d: -f4 > admns
echo "All Users on this machine: "
cat users
echo "Admins: "
cat admns
rm users
rm admns
echo "---------------------------------------------------------------------------"
# Find easy malicious files
find /etc /var /root /home /bin /usr/bin -xdev > everything
dpkg --list >> everything
known_services=(samba apache2 telnet mysql-server xinetd vsftp exim4 nginx rpcbind openssh-server  bind9 dovecot vnc4server tightvncserver gcc cc)
echo "KNOWN SERVICES: "
echo ""
for i in ${known_services[@]}; do
        [ "$(cat everything | grep -w $i &> /dev/null  ; echo $?)" == 0 ] && (echo $i  "Installed")
done
maybe_malicious=(logkeys keylogger keysniffer uber vlogger vuze deluge torrent tixati frostwire ophcrack medusa RainbowCrack wfuzz brutus LOphtCrack fgdump hydra john aircrack abel ksimet inssider kismac netstumbler weplab airjack nmap superscan hping scapy nemesis socat splunk nagios pof ngrep wireshark tcpdump ettercap dsniff etherape paros fiddler ratproxy slsstrip aide netfilter skipfish wapiti w3af helix sleuth maltego encase gdb tor OpenVPN snort netcop metasploit sqlmap sqlninja netsparker beef nessus openvas nipper retina qualysguard nexpose burp webscarab websecurify nikto w3af)
echo ""
echo "MAYBE MALICIOUS: "
echo ""
for i in ${maybe_malicious[@]}; do
        [ "$(cat everything | grep -w $i &> /dev/null  ; echo $?)" == 0 ] && (echo $i  "Installed" )
done

echo "---------------------------------------------------------------------------"
echo "WORLD WRITABLE FILES: "
echo $(find /etc /var /root /home -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print) >> ans
echo "NO USER FILES: " >> ans
echo $(find /home /etc /var /dev -xdev \( -nouser -o -nogroup \) -print) >> ans
cat ans
rm ans
echo "---------------------------------------------------------------------------"

echo "LOOKING FOR UID 0"
echo "only root?" >> temp
root=$(echo $(awk -F: '($3 == "0") {print}' /etc/passwd))
[ "$(root)" != "root:x:0:0:root:/root:/bin/bash" ] && (echo "POSSIBLE UID OF 0!" >> temp | echo $(root) >> temp )
echo "Legacy entries in shadow,group:" >> temp
grep '^+:' /etc/shadow >> temp
grep '^+:' /etc/group >> temp
cat temp
rm temp
echo "---------------------------------------------------------------------------"

echo "--- CRON ---" >> Store_Data
for crontab in $(ls /etc/cron.d/* /var/spool/cron/* /etc/crontab)
do
    echo $crontab >> Store_Data
    cat $crontab >> Store_Data
done
echo "--- BASHRC ---" >> Store_Data
echo "bashrc: " >> Store_Data
cat /etc/bash.bashrc >> Store_Data
echo "--- RC LOCAL ---" >> Store_Data
echo "rc.local: " >> Store_Data
cat /etc/rc.local >> Store_Data
sed '/^#/ d' Store_Data >> temp
rm Store_Data
mv temp Store_Data
echo "---------------------------------------------------------------------------"

echo "MEDIA FILES: "

cat everything |grep -e ".*\.mp3$" -e ".*\.mp4$" -e ".*\.mov$" -e ".*\.tar.gz$" -e ".*\.avi$" 
echo "---------------------------------------------------------------------------"
echo "w: "
w
echo "---------------------------------------------------------------------------"
echo "PS: "
ps
echo "---------------------------------------------------------------------------"
echo "SSH Connections: "
netstat -tnpa | grep 'ESTABLISHED.*sshd'
echo "---------------------------------------------------------------------------"
echo "LISTENING PORTS: "
netstat -tulpn | grep LISTEN
echo "---------------------------------------------------------------------------"
rm everything
echo "and.. thats my day. How is your day going?"
