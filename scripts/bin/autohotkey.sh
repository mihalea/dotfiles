#!/bin/bash

xinput test 9 | while read line ; do
	case "$line" in
		"key release 77")
			"$HOME/bin/numlock.sh" --start &
			;;
		"key release 63") ;&
		"key release 79") ;&
		"key release 80") ;&
		"key release 81") ;&
		"key release 82") ;&
		"key release 83") ;&
		"key release 84") ;&
		"key release 85") ;&
		"key release 86") ;&
		"key release 87") ;& 
		"key release 88") ;&
		"key release 89") ;&
		"key release 90") ;&
		"key release 91") ;&
		"key release 104") ;&
		"key release 106")
			"$HOME/bin/numlock.sh" --reset &
			;;
	esac
done
