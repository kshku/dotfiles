#!/bin/sh
# wmenu-notif.sh - notification history viewer via wofi + dunstctl

DIR=$(mktemp -d)
trap 'rm -rf "$DIR"' EXIT
DISP="$DIR/disp"
IDF="$DIR/id"

dunstctl history | jq -r '.data[0][] | [(.id.data|tostring), (.appname.data // "unknown"), (.summary.data // "")] | @tsv' 2>/dev/null | awk -F'\t' -v d="$DISP" -v i="$IDF" '
{
    id = $1
    app = $2
    sum = $3
    gsub(/<[^>]*>/, "", sum)
    gsub(/&lt;/, "<", sum)
    gsub(/&gt;/, ">", sum)
    gsub(/&amp;/, "\\&", sum)
    gsub(/&quot;/, "\\\"", sum)
    if (length(sum) > 80) sum = substr(sum, 1, 80) "..."
    print "󰂢  " sum "  [" app "]" > d
    print id > i
}
'

if dunstctl is-paused | grep -q "true"; then
    DND="󰂛  Disable DND"
else
    DND="󰂛  Enable DND"
fi

if [ -f "$DISP" ]; then
    SEL=$(printf '󰇧  Clear all\n󰂢  Dismiss all\n%s\n' "$DND" | cat - "$DISP" | wofi --dmenu --prompt "Notifications")
else
    SEL=$(printf '󰇧  Clear all\n󰂢  Dismiss all\n%s\n' "$DND" | wofi --dmenu --prompt "Notifications")
fi

case "$SEL" in
    *Clear*)
        dunstctl history-clear
        dunstctl close-all
        ;;
    *Dismiss*)
        dunstctl close-all
        ;;
    *Disable*)
        dunstctl set-paused false
        ;;
    *Enable*)
        dunstctl set-paused true
        ;;
    "")
        exit 0
        ;;
    *)
        ROW=$(grep -n -F -x "$SEL" "$DISP" | head -n1 | cut -d: -f1)
        [ -z "$ROW" ] && exit 0
        ID=$(sed -n "${ROW}p" "$IDF")
        dunstctl history-pop "$ID"
        ;;
esac
