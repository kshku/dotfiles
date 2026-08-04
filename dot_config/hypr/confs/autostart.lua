hl.on("hyprland.start", function()
    hl.exec_cmd("~/.local/bin/desktop-portal.sh")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst")
    -- Cliphist
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- Theme
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
end)
