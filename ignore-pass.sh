echo -e "[filter \"remove-pass\"]\nclean = \"sed -e 's/^password=.*/#password=TODO/'\"" >> .git/config
