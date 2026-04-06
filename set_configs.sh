#!/bin/sh

#directories="alacritty dunst hypr kitty waybar"
directories="$(ls .config)"

pacman_packages="$(cat pacman_packages.txt)"
aur_packages="$(cat aur_packages.txt)"

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
sudo pacman -S --needed $pacman_packages
yay -S --needed $aur_packages
