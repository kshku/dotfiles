#!/bin/sh
# wmenu-bt.sh - Bluetooth manager via wofi + bluetoothctl/rfkill

DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT
DISP="$DIR/disp"
ADDRF="$DIR/addr"

if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
    SEL=$(printf '󰳁  Unblock Bluetooth\n' | wofi --dmenu --prompt "Bluetooth")
else
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl devices Connected | awk '{print $2}' > "$DIR/conn"

        bluetoothctl devices | awk -v d="$DISP" -v a="$ADDRF" -v c="$DIR/conn" '
        BEGIN {
            while ((getline line < c) > 0) conn[line] = 1
            close(c)
        }
        {
            addr = $2
            name = substr($0, index($0, $3))
            if (addr in conn) icon = "󰂯"
            else icon = "󰂲"
            print icon "  " name > d
            print addr > a
        }
        '

        SEL=$(printf '󰂯  Scan for devices\n󰂲  Disable Bluetooth\n󰳁  Block Bluetooth\n' | cat - "$DISP" | wofi --dmenu --prompt "Bluetooth")
    else
        SEL=$(printf '󰳁  Enable Bluetooth\n󰳁  Block Bluetooth\n' | wofi --dmenu --prompt "Bluetooth")
    fi
fi

case "$SEL" in
    *Scan*) bluetoothctl scan on & sleep 5; kill %1 2>/dev/null ;;
    *Disable*) bluetoothctl power off ;;
    *Enable*) bluetoothctl power on ;;
    *Unblock*) rfkill unblock bluetooth ;;
    *Block*) rfkill block bluetooth ;;
    "")
        exit 0
        ;;
    *)
        ROW=$(grep -n -F -x "$SEL" "$DISP" | head -n1 | cut -d: -f1)
        [ -z "$ROW" ] && exit 0
        ADDR=$(sed -n "${ROW}p" "$ADDRF")
        if bluetoothctl info "$ADDR" | grep -q "Connected: yes"; then
            bluetoothctl disconnect "$ADDR"
        else
            bluetoothctl connect "$ADDR" || { bluetoothctl pair "$ADDR" && bluetoothctl connect "$ADDR"; }
        fi
        ;;
esac
