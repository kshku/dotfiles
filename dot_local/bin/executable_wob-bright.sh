#!/bin/bash
# Show current backlight brightness as a wob overlay bar.
BRIGHT=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')
{ printf '%s\n' "$BRIGHT"; sleep 1.2; } | wob
