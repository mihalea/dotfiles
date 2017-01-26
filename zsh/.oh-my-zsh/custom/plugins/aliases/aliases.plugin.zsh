#!/bin/zsh

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

alias ls='ls --color=auto'
alias l=ls
alias ll='ls -l'
alias la='ls -la'
alias sudo='sudo '
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"
alias cpp='rsync -ah --progress'
alias xclip="xclip -selection c"
