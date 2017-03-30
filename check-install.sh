#!/bin/bash

# Return whether the package provided is installed
function is_installed {
	# Yaourt returns two lines of code for each package
	query=$(yaourt -Qs "^$1\$" | wc -l)
	if [[ "$query" -eq 2 ]]; then
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
	decorator=$1; shift
	name=$1; shift

	if [[ $# -gt 0 ]]; then
		echo "== $name ($#)=="
		for e in $@; do
			echo "$decorator $e"
		done

		echo
	fi
}

# Find installed and uninstalled packages and print them
function main {
	installed=()
	needed=()

	for p in $(read); do
		if is_installed $p; then
			installed+=($p)
		else
			needed+=($p)
		fi
	done
	

	list "[ ]" "Needed"  "${needed[@]}" 
	list "[x]" "Installed" "${installed[@]}" 
}

# Start the application
main
