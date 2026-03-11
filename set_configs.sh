#!/bin/sh

#directories="alacritty dunst hypr kitty waybar"
directories="$(ls .config)"

packages="hyprland hypridle hyprcursor hyprlock hyprpaper hyprpolkitagent
xdg-desktop-portal-hyprland dunst waybar cliphist adw-gtk-theme
xdg-desktop-portal-gtk wtype brightnessctl pamixer
hyprpicker"

aur_packages="hyprqt6engine adwaita-qt5 adwaita-qt6 wofi-emoji hyprshot"

echo "Copying config files..."

for dir in $directories
do
    if [ -d "$HOME/.config/$dir" ]
    then
        if [ -d "$HOME/.config/$dir.bak" ]
        then
            echo "Removing old backup..."
            rm -rf "$HOME/.config/$dir.bak"
        fi
        mv -i -T "$HOME/.config/$dir" "$HOME/.config/$dir.bak"
    fi
    cp -r ".config/$dir" "$HOME/.config/$dir"
done

echo "Trying to install required packages using pacman..."
sudo pacman -S --needed $packages
yay -S --needed $aur_packages
