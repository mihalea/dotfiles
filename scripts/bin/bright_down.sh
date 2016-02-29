#!/bin/bash
brightness=$(cat /sys/class/backlight/radeon_bl0/brightness)

new_value=$(bc <<< "$brightness - 25")
if [ $new_value -gt "0" ]; then
  echo "echo $new_value > /sys/class/backlight/radeon_bl0/brightness" | sudo bash
fi
