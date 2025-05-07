#!/bin/bash

# start vpn service
sudo /home/smayor/.local/share/SoftEtherVPN/vpnclient start
sleep 1

vpnConnections=$( $HOME/.local/share/SoftEtherVPN/vpncmd localhost /client /CMD accountlist | grep -e "VPN Connection Setting Name" | cut -f2 -d'|' )


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

$HOME/.local/share/SoftEtherVPN/vpncmd localhost /client /CMD accountconnect $answer
sleep 1

servername="$( $HOME/.local/share/SoftEtherVPN/vpncmd localhost /client /CMD accountlist | grep "$answer" -A 2 | grep "VPN Server Hostname" | cut -f2 -d'|' | cut -f1 -d':' )"

echo Server name is $servername

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

# create new route to vpn server via default gateway of active adapter
sudo ip route add $serverip/32 via $dgw dev $hwadapter

# get address assigned to virtual vpn adapter
sudo dhcpcd --rebind vpn_vpn

# set up ip forwarding
sudo sysctl -w net.ipv4.ip_forward=1
