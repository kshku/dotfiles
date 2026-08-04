#!/bin/sh
# media.sh - show currently playing media for waybar

STATUS=$(playerctl status 2>/dev/null)
[ -z "$STATUS" ] && exit 0

TITLE=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)

TITLE=$(printf '%s' "$TITLE" | cut -c1-30)
ARTIST=$(printf '%s' "$ARTIST" | cut -c1-20)

if [ "$STATUS" = "Paused" ]; then
    ICON="󰏥"
else
    ICON="󰽟"
fi

if [ -n "$ARTIST" ]; then
    printf '%s %s - %s\n' "$ICON" "$ARTIST" "$TITLE"
else
    printf '%s %s\n' "$ICON" "$TITLE"
fi
