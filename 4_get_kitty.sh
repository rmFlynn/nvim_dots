
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
CONFPATH=$(realpath ./kitty)


rm  -r ~/.config/kitty
ln -s $CONFPATH ~/.config/kitty
