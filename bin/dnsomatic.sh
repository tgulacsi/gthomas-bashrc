#!/bin/sh

echo USER=$USERNAME

MYHOSTS=${MYHOSTS:-"$@"}

MYIP_HOST='myip.dnsomatic.com'
DNSSRV=${DNSSRV:-'ns1.dyndns.org'}
UPDATE_HOST=${UPDATE_HOST:-'updates.dnsomatic.com'}
#UPDATE_HOST='updates.dyndns.org'
WGET='wget'

get_actual_ip() {
	$WGET -q -O- http://${MYIP_HOST}/
}

get_dns_ip() {
	dig @$DNSSRV $1 +short
}

act_ip=$(get_actual_ip)
echo "Actual ip: ${act_ip}"
[ -z "$act_ip" ] && exit 1
for host in $MYHOSTS; do
	dns_ip=$(get_dns_ip "$host")
	echo "  IP of ${host}: ${dns_ip}"
	if [ "x$dns_ip" != "x$act_ip" ]; then
		echo "    UPDATEing ${host} to ${act_ip}:"
		echo "$WGET -nv -O- \"https://\${USERNAME}:\${PASSWORD}@${UPDATE_HOST}/nic/update?hostname=${host}&myip=${act_ip}&wildcard=NOCHG&mx=NOCHG&backupmx=NOCHG\""
		$WGET -nv -O result-${host}.log --no-check-certificate "https://${USERNAME}:${PASSWORD}@${UPDATE_HOST}/nic/update?hostname=${host}&myip=${act_ip}&wildcard=NOCHG&mx=NOCHG&backupmx=NOCHG"
	fi
done
