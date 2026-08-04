-- Ignore maximize requests from all apps.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({ match = { class = "Alacritty" }, opacity = "0.9 override 0.7 override 1.0 override" })
hl.window_rule({ match = { class = "kitty" }, opacity = "0.7 override 0.5 override 1.0 override" })

hl.window_rule({
    match = { class = ".*wofi.*" },
    rounding = 16,
    opacity = "0.95 override 0.95 override 1.0 override",
})

hl.window_rule({
    match = { class = "^Dunst$" },
    rounding = 16,
    opacity = "0.92 override 0.92 override 1.0 override",
})

hl.layer_rule({
    match = { namespace = "wob" },
    no_anim = true,
})
