#!/bin/sh

WALLPAPER_DIR="$HOME/Wallpapers/"

WALLPAPER=$(ls "$WALLPAPER_DIR" | shuf -n 1)

echo $(realpath "$WALLPAPER_DIR/$WALLPAPER")
