vpn() {
	sh ./vpncheck
}

case $BLOCK_BUTTON in
    1) urxvt -e sudo openvpn ~/airvpn/airvpn.ovpn & disown ;;
    2) urxvt -e sh ~/dotfiles/blocklets/vpntor ;;
    3) urxvt -e sudo pkill openvpn ;;
esac

vpn
