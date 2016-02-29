#!/bin/sh
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


if [[ $(ls /sys/class/net) =~ .*"wlp8s0".* ]] 
then
	iface='wlp8s0';
else
	if [[ $(ls /sys/class/net) =~ .*"enp9s0".* ]] 
	then
		iface='enp4s0';
	fi
fi



INTERFACE="${1:-$iface}"
#LABEL="${2:-E}"
#LABEL=""

state="$(cat /sys/class/net/$INTERFACE/operstate)"

if [ "$state" != "up" ]; then
	echo "$LABEL: down"
	echo "$LABEL: down"
	echo "#FF0000"
	exit 0
fi

speed="$(cat /sys/class/net/$INTERFACE/speed 2> /dev/null)"

ipaddr="$(ip addr show $INTERFACE | perl -n -e'/inet (.+)\// && print $1')"
ipaddr="${ipaddr:-0.0.0.0}"

# full text
echo -n "$LABEL$ipaddr"
[ -n "$speed" ] && echo " $speed" || echo

# short text
echo "$LABEL$ipaddr"
