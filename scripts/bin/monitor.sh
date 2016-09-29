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
	xrandr --output LVDS --auto --pos 0x0   --output HDMI-0 --off
	echo '2' > $file
elif [ $state == "2" ] || [ -z $state ]; then
	xrandr --output LVDS --auto --pos 1920x150 --output HDMI-0 --auto --pos 0x0 --primary
	echo '1' > $file
fi

exec $HOME/bin/setwallpaper -f & 
disown
