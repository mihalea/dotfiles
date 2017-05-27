echo -e "[filter \"remove-pass\"]\nclean = \"sed -e 's/^password=.*/#password=TODO/'\"" >> $HOME/.dotfiles/.git/config
