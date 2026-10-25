main_mod = "SUPER"
run_command = "fuzzel --dmenu -p 'Run a command:'"
random_wallpaper = "caelestia wallpaper -r"

hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(random_wallpaper))
hl.bind(main_mod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + SHIFT + W", hl.dsp.window.toggle_swallow())
hl.bind(main_mod .. " + SHIFT + Space", hl.dsp.exec_cmd(run_command))

hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.config({
    misc = {
        disable_hyprland_logo = false,
        disable_splash_rendering = false,
        force_default_wallpaper = -1,

        middle_click_paste = true,

        enable_swallow = true,
        swallow_regex = "Alacritty|kitty",
        swallow_exception_regex = "[wx]ev",
    }
})

hl.window_rule({ match = { class = "Alacritty|kitty" }, opacity = "0.8 override 0.6 override 1.0 override" })

hl.window_rule({
    match = { class = ".*wofi.*" },
    rounding = 16,
    opacity = "0.95 override 0.95 override 1.0 override",
})
