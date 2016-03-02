#!/bin/bash
max_brightness=$(cat /sys/class/backlight/radeon_bl0/max_brightness)
brightness=$(cat /sys/class/backlight/radeon_bl0/brightness)
#echo "$max_brightness $brightness"
echo " $(bc <<< "$brightness * 100 / $max_brightness")"
