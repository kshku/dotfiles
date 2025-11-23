#!/bin/sh

directories="hypr waybar dunst"
packages="hyprland hypridle hyprcursor hyprlock hyprpaper hyprpolkitagent xdg-desktop-portal-hyprland dunst waybar"

echo "Copying config files..."

for dir in $directories
do
    if [ -d "$HOME/.config/$dir" ]
    then
        mv -i -T "$HOME/.config/$dir" "$HOME/.config/$dir.bak"
    fi
    cp -r ".config/$dir" "$HOME/.config/$dir"
done

echo "Trying to install required packages using pacman..."
sudo pacman -S --needed $packages
