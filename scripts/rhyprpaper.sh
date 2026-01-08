#!/bin/sh

WALLPAPER_DIR="$HOME/Wallpapers"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

cp -f "$WALLPAPER" "$WALLPAPER_DIR/.current_rhyprpaper"

# Apply the selected wallpaper
hyprctl hyprpaper wallpaper ", $WALLPAPER, cover"
