#!/bin/bash

if [ "$1" == "" ]
then
	echo 'Enter an IP address'
	echo 'Usage: ./ping_sweeper <IP_ADDRESS>'

else
	for ip in $(seq 1 254); 
	do
		ping -c 1 $1.$ip | grep '64 bytes' | cut -d ' ' -f 4 | tr -d ':' &
	done
fi

# Perform an nmap scan on the results
# for ip in $(cat ip_list.txt);
	# do
		# nmap -A -T4 -Pn $ip &
	# done