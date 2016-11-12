[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec $1
