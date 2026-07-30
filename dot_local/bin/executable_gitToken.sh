#!/bin/sh

file="$HOME/.git_token.txt"

use_xclip() {
    command -v xclip > /dev/null 2>&1 || { echo "Error: xclip is not found. Exiting..." >&2 ; exit 1; }
    echo "Using xclip"
    xclip -r -selection clipboard "$file"
    [ $? -ne 0 ] && { echo "Error during copying"; exit 1; }
}

use_wlcopy() {
    if command -v wl-copy > /dev/null 2>&1; then
        echo "Using wl-copy"
        wl-copy -n < "$file"
        [ $? -ne 0 ] && { echo "Error during copying"; exit 1; }
    else
        echo "wl-copy not found, switching to xclip"
        use_xclip
    fi
}
    

[ -f "$file" ] || { echo "Couldn't find token file"; exit 1; }
case $XDG_SESSION_TYPE in
    w*)
        use_wlcopy
        ;;
    x*)
        use_xclip
        ;;
    *)
        echo "Unkown window system"
        use_xclip
        ;;
esac

echo "Token copied successfully"
