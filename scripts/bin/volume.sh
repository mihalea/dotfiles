#!/bin/bash

volume=$(amixer -D pulse get Master | grep -o "\[.*%\]" | grep -o "[0-9]*" | head -n1)

echo " $volume"
