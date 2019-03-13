#!/bin/bash

pid_file="/tmp/numlock.pid"

TIMEOUT=5;
TIMER=0;
function start {
	if [ ! -z $pid ]; then
		echo "Instance already running"	
	fi

	reset

	echo "$$" > $pid_file

	trap "reset" SIGUSR1
	trap "exit" SIGINT
	while [ $TIMER -gt 0 ]; do
		sleep 1
		TIMER=$((TIMER - 1))
		echo $TIMER
	done

	rm $pid_file
	numlockx toggle
}

function reset {
	TIMER=$TIMEOUT

	if [ ! -z $pid ]; then
		kill -SIGUSR1 $pid
	fi
}

if [ -s $pid_file ]; then
	read pid < $pid_file
fi

case "$1" in
	-s|--start)
		start
		;;
	-r|--reset)
		reset
		;;
	*)
		echo "Unexpected flag"
		;;
esac
