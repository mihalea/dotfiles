#!/bin/bash

file="/tmp/monitorstate"

if [ ! -z $1 ]; then
	state=$1
else
	if [ -s $file ]; then
		read state < $file
	else
		state="2";
	fi
fi

if [ $state == "1" ]; then
	xrandr --output LVDS-1 --auto --pos 0x0   --output VGA-1 --off
	echo '2' > $file
elif [ $state == "2" ] || [ -z $state ]; then
	xrandr --output LVDS-1 --auto --pos 1440x0 --output VGA-1 --auto --pos 0x0 --primary
	echo '1' > $file
fi

exec $HOME/bin/setwallpaper -f & 
disown
