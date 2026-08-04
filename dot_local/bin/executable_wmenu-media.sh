#!/bin/sh
# wmenu-media.sh - media player control via wofi + playerctl

PLAYERS=$(playerctl -l 2>/dev/null)
[ -z "$PLAYERS" ] && {
    printf '󰽟  No players detected\n' | wofi --dmenu --prompt "Media"
    exit 0
}

COUNT=$(printf '%s\n' "$PLAYERS" | wc -l)
if [ "$COUNT" -eq 1 ]; then
    PLAYER=$PLAYERS
else
    PLAYER=$(printf '%s\n' "$PLAYERS" | wofi --dmenu --prompt "Media player")
fi
[ -z "$PLAYER" ] && exit 1

ACTION=$(printf '󰐊  Play / Pause\n󰒭  Next\n󰒮  Previous\n󰓛  Stop\n󰈆  Quit player\n' | wofi --dmenu --prompt "$PLAYER")

case "$ACTION" in
    *Play*) playerctl --player="$PLAYER" play-pause ;;
    *Next) playerctl --player="$PLAYER" next ;;
    *Previous) playerctl --player="$PLAYER" previous ;;
    *Stop) playerctl --player="$PLAYER" stop ;;
    *Quit*) playerctl --player="$PLAYER" -a quit 2>/dev/null || pkill -f "$PLAYER" ;;
esac
