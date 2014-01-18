#!/bin/bash
#------------------------------------------------------
#	File: 	netscan.sh
#	Author:	Donald Raikes <dr1861@nyu.edu>
#	Date:	01/17/2014
#
#	Scan this system's subnet to see what other devices are connected 
#	and what ports are open on each.
#------------------------------------------------------

#Ping to see if the ip address responds.
IsAlive()
{
  ping -c 1 $1 > /dev/null
  if [ $? -eq 0 ]; then 
	HOST=`host $IP`
	if [ $? -ne 0 ]; then
		HOST=""
	fi
	echo "Host: $HOST IP: $IP is up."
	PortCheck
  fi
}

#function PortCheck 
#test a port to see if it is open 
function PortCheck 
{ 
for ((counter=$STARTPORT; counter<=$STOPPORT; counter++)) do 
(echo >/dev/tcp/$IP/$counter) > /dev/null 2>&1 && echo "   TCP port $counter open" 
#(echo >/dev/udp/$IP/$counter) > /dev/null 2>&1 && echo "   UDP port $counter open" 
done 
} 

#Main Script:
#Define necessary environment variables:
STARTPORT=1
STOPPORT=1000
#Determine this system's ipv4 address:
MYIP=`/sbin/ifconfig | grep -i 'inet ' | grep -v '127.0' | cut -d ":" -f 2 | cut -d " " -f 1`
MYFS=$IFS
IFS='.'
read -r -a octets <<< "$MYIP"
IFS='$MYFS'
SUBNET=`printf "%s.%s.%s" "${octets[0]}" "${octets[1]}" "${octets[2]}"`
echo "Scanning Subnet range = $SUBNET.1-255"
for i in {1..254}
do
	IP=`printf "%s.%s" $SUBNET $i`
	IsAlive $IP & disown
done
