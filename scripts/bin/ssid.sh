#!/bin/bash

wifi=$(iwgetid -r)


if [[ ! -z $wifi ]]; then
	if pgrep "openvpn" &> /dev/null || pgrep "pptp" &> /dev/null; then
		echo " $wifi"
	else
		echo " $wifi"
	fi

else
	echo "Disconnected"
fi
