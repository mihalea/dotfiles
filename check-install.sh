#!/bin/bash

# Return whether the package provided is installed
function is_installed {
	# Yaourt returns two lines of code for each package
	query=$(yaourt -Qs --nameonly "^$1\$" | wc -l)
	if [[ $query -eq 2 ]]; then
		# 0 IS TRUE
		return 0
	else
		# 1 IS FALSE
		return 1
	fi
}

# Reads the packages to be checked from a predefined file
# or from a file provided as a console argument if available
function read {
	
	fname="packages.txt"
	if [[ $# -gt 0 ]]; then
		fname="$1"
	fi

	echo $(cat $fname)
}

# List the array using the provided decorator
function list {
	decorator=$1
	shift
	for e in $@; do
		echo "$decorator $e"
	done
}

# Find installed and uninstalled packages and print them
function main {
	installed=()
	not_installed=()

	for p in $(read); do
		if is_installed $p; then
			installed+=($p)
		else
			not_installed+=($p)
		fi
	done
	

	list "[ ]" "${not_installed[@]}" 
	list "[x]" "${installed[@]}" 
}

# Start the application
main
