#!/bin/bash
max_brightness=$(cat /sys/class/backlight/radeon_bl0/max_brightness)
brightness=$(cat /sys/class/backlight/radeon_bl0/brightness)

new_value=$(bc <<< "$brightness+25")
if [ $new_value -gt $max_brightness ]; then
	new_value=$max_brightness
fi

echo "echo $new_value > /sys/class/backlight/radeon_bl0/brightness" | sudo bash
