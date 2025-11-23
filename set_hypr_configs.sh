#!/bin/sh

directories="hypr waybar dunst"

for dir in $directories
do
    if [ -d "$HOME/.config/$dir" ]
    then
        mv -i -T "$HOME/.config/$dir" "$HOME/.config/$dir.bak"
    fi
    cp -r ".config/$dir" "$HOME/.config/$dir"
done
