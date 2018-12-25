#!/bin/bash
yum-config-manager --add ftp://192.168.2.254/rhel7
sed  -i 5a"gpgcheck=0" /etc/yum.repos.d/192.168.2.254_rhel7.repo
RH2="/etc/yum.repos.d/192.168.2.254_rhel7.repo"
yum-config-manager --add ftp://192.168.4.254/rhel7
RH4="/etc/yum.repos.d/192.168.4.254_rhel7.repo"
sed  -i 5a"gpgcheck=0" /etc/yum.repos.d/192.168.4.254_rhel7.repo
for i in {1..254}
do
	ping -c 2 -i 0.2 -W 1 192.168.2.$i &> /dev/null & 
	PING2="192.168.2.$i"
	PING4="192.168.4.$i"
	if [ $? -eq 0 ] &> /dev/null ;then
		scp  $RH2 $PING2:/$RH2 & 
		scp -r /root/lnmp_soft.tar1.gz  $PING2:/root &
		scp /root/setup_lnmp.sh $PING2:/root &
	fi	
        ping -c 2 -i 0.2 -W 1 192.168.4.$i &> /dev/null &
        if [ $? -eq 0 ] &> /dev/null ;then
                scp  $RH4 $PING4:/$RH4 &
		scp -r /root/lnmp_soft.tar1.gz  $PING4:/root  &
		scp /root/setup_lnmp.sh $PING4:/root &
        fi      
done

