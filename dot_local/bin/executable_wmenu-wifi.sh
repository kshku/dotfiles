#!/bin/sh
# wmenu-wifi.sh - Wi-Fi manager via wofi + nmcli/rfkill

DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT
DISP="$DIR/disp"
SSIDF="$DIR/ssid"
SECF="$DIR/sec"

if rfkill list wlan | grep -q "Soft blocked: yes"; then
    SEL=$(printf '󰤭  Unblock Wi-Fi\n' | wofi --dmenu --prompt "Wi-Fi")
else
    if nmcli radio wifi | grep -q enabled; then
        nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | awk -F: -v d="$DISP" -v s="$SSIDF" -v f="$SECF" '
        {
            n = split($0, a, ":")
            signal = a[n-1] + 0
            security = a[n]
            ssid = ""
            for (i = 1; i <= n-2; i++) {
                gsub(/\\:/, ":", a[i])
                if (i > 1) ssid = ssid ":"
                ssid = ssid a[i]
            }
            if (ssid == "") next

            if (signal >= 80) icon = "󰤨"
            else if (signal >= 60) icon = "󰤥"
            else if (signal >= 40) icon = "󰤟"
            else if (signal >= 20) icon = "󰤯"
            else icon = "󰤮"
            if (security != "") icon = icon " 󰐉"

            print icon "  " ssid > d
            print ssid > s
            print security > f
        }
        '

        SEL=$({ cat "$DISP"; printf '󰤨  Rescan\n󰤮  Disconnect\n󰤭  Disable Wi-Fi\n󰳁  Block Wi-Fi\n'; } | wofi --dmenu --prompt "Wi-Fi")
    else
        SEL=$(printf '󰤭  Enable Wi-Fi\n󰳁  Block Wi-Fi\n' | wofi --dmenu --prompt "Wi-Fi")
    fi
fi

case "$SEL" in
    *Rescan) nmcli dev wifi rescan ;;
    *Disable*) nmcli radio wifi off ;;
    *Disconnect) nmcli dev disconnect ;;
    *Enable*) nmcli radio wifi on ;;
    *Unblock*) rfkill unblock wifi ;;
    *Block*) rfkill block wifi ;;
    "")
        exit 0
        ;;
    *)
        ROW=$(grep -n -F -x "$SEL" "$DISP" | head -n1 | cut -d: -f1)
        [ -z "$ROW" ] && exit 0
        SSID=$(sed -n "${ROW}p" "$SSIDF")
        SEC=$(sed -n "${ROW}p" "$SECF")

        if nmcli -t -f NAME connection show --active | grep -Fxq "$SSID"; then
            exit 0
        elif [ -n "$SEC" ]; then
            HASPROFILE=0
            if nmcli -t -f NAME connection show | grep -Fxq "$SSID"; then
                HASPROFILE=1
                FLAGS=$(nmcli -t -f 802-11-wireless-security.psk-flags connection show "$SSID" 2>/dev/null)
                if [ "$FLAGS" = "802-11-wireless-security.psk-flags:0" ]; then
                    if nmcli connection up "$SSID" 2>/dev/null; then
                        notify-send -u low "Wi-Fi" "Connected to $SSID"
                    else
                        notify-send -u critical "Wi-Fi" "Could not connect to $SSID"
                    fi
                    exit 0
                fi
            fi

            tries=0
            PASS=$(wofi --dmenu --password --prompt "Enter password for $SSID")
            while [ -n "$PASS" ] && [ "$tries" -lt 3 ]; do
                ok=0
                if [ "$HASPROFILE" = "1" ]; then
                    nmcli connection modify "$SSID" 802-11-wireless-security.psk "$PASS" 802-11-wireless-security.psk-flags 0
                    nmcli connection up "$SSID" && ok=1
                else
                    nmcli dev wifi connect "$SSID" password "$PASS" && ok=1
                fi
                if [ "$ok" = "1" ]; then
                    break
                fi
                tries=$((tries + 1))
                [ "$tries" -lt 3 ] && PASS=$(wofi --dmenu --password --prompt "Wrong password, try again")
            done
            if [ "$tries" -ge 3 ]; then
                [ "$HASPROFILE" = "1" ] && nmcli connection modify "$SSID" 802-11-wireless-security.psk-flags 1 2>/dev/null
                notify-send -u critical "Wi-Fi" "Could not connect to $SSID"
            else
                notify-send -u low "Wi-Fi" "Connected to $SSID"
            fi
        else
            nmcli dev wifi connect "$SSID"
        fi
        ;;
esac
