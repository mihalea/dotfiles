#!/bin/zsh

function sshen {
	if [ ! -z $1 ];  then
		file="$HOME/.ssh/$1"
		if [ -s $file ]; then
			ssh-add $file
		fi
	fi	
}

alias ls='ls --color=auto'
alias l=ls
alias ll='ls -l'
alias la='ls -la'
alias sudo='sudo '
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
