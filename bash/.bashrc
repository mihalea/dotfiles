#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\u \W\$ '

alias l=ls
alias ll='ls -lA'
alias la='ls -la'
alias sudo='sudo '
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
