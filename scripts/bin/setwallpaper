#!/bin/bash

#Choose a random image from the path
path="$HOME/Pictures/Wallpapers"

#Writing to /tmp instead of /var/run to simplify deployment
pid_file="/tmp/setwallpaper.pid"

if [ -s $pid_file ]; then
	read pid < $pid_file
	if [ ! -z $pid ]; then
		kill -s 0 "$pid" && kill -s 9 "$pid"
	fi
fi

echo "$$" > $pid_file

while true; do
	find $path/ -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n1 | xargs feh --bg-scale
	sleep 15m
done
