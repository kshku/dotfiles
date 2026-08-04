hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 2.0,

        active_opacity = 1.0,
        inactive_opacity = 0.7,
        fullscreen_opacity = 1.0,

        dim_modal = true,
        dim_inactive = true,
        dim_strength = 0.05,
        dim_special = 0.2,
        dim_around = 0.4,

        screen_shader = "",
        border_part_of_window = true,

        -- `blur.size` and `blur.passes` have to be at least 1.
        -- Increasing `blur.passes` is necessary to prevent blur looking wrong on higher
        -- `blur.size` values, but remember that higher `blur.passes` will require more
        -- strain on the GPU.
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            noise = 0.0117,
            contrast = 0.8916,
            brightness = 1.0,
            vibrancy = 0.1696,
            vibrancy_darkness = 0.0,
            special = false,
            popups = false,
            popups_ignorealpha = 0.2,
            input_methods = false,
            input_methods_ignorealpha = 0.2,
        },
        
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            sharp = false,
            color = 0xee1a1a1a,
            -- color_inactive = unset,
            offset = {0, 0},
            scale = 1.0,
        },

        glow = {
            enabled = false,
            range = 10,
            render_power = 3,
            color = 0xee33ccff,
            -- color_inactive = unset,
        },

        motion_blur = {
            enabled = false,
            samples = 7,
        },
    },
})
