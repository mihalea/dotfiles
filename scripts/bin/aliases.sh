function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

function mkcd () { mkdir "$1"; cd "$1"; }

function human () { 
	if [ -z "$1" ]; then
		read value
	else
		value="$1"
	fi

	numfmt --to=iec-i --suffix=B --padding=7 "$value" 
}
