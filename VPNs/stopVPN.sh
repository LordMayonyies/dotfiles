#!/bin/bash

vpnConnections=$( /home/smayor/.local/share/SoftEtherVPN/vpncmd localhost /client /CMD accountlist | grep -e "VPN Connection Setting Name" | cut -f2 -d'|' )


oldIFS=$IFS
IFS=$'\n'
choices=( $vpnConnections )
IFS=$oldIFS
PS3="Please enter your choice: "
select answer in "${choices[@]}"; do
  for item in "${choices[@]}"; do
    if [[ $item == $answer ]]; then
      break 2
    fi
  done
done

# disconnect client account from server
/home/smayor/.local/share/SoftEtherVPN/vpncmd localhost /client /CMD accountdisconnect $answer

servername=$( /home/smayor/.local/share/SoftEtherVPN/vpncmd localhost /client /CMD accountlist | grep -e "$answer" -A 2 | grep "VPN Server Hostname" | cut -f2 -d'|' | cut -f1 -d':' )

echo $servername

# stop vpn client service
sudo /home/smayor/.local/share/SoftEtherVPN/vpnclient stop

# get vpn server ip
serverip="$(getent hosts $servername | cut -d ' ' -f 1)"
echo Server IP is $serverip
#sleep 1

# get active hardware adapter name
hwadapter="$(ip route | sed -n '1 p' | cut -d ' ' -f 5)"
echo Adapter name is $hwadapter
#sleep 1

# get default gateway of cellphone NIC connection
dgw="$(ip route | sed -n '1 p' | cut -d ' ' -f 3)"
echo Default Gateway is $dgw
#sleep 1

# delete route to vpn server via default gateway of active adapter
sudo ip route del $serverip/32 via $dgw dev $hwadapter

# stop ipv4 forwarding
sudo sysctl -w net.ipv4.ip_forward=0
