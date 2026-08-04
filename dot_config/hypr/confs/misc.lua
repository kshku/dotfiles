hl.config({
    misc = {
        disable_hyprland_logo = false,
        disable_splash_rendering = false,
        disable_scale_notification = false,

        col = {
            splash = 0x55ffffff,
        },

        font_family = "Sans",
        splash_font_family = "",
        force_default_wallpaper = -1,
        vrr = 0,

        mouse_move_enables_dpms = false,
        key_press_enables_dpms = true,

        name_vk_after_proc = true,
        always_follow_on_dnd = true,
        layers_hog_keyboard_focus = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        disable_autoreload = false,

        enable_swallow = true,
        swallow_regex = "Alacritty|kitty",
        swallow_exception_regex = "[wx]ev",

        focus_on_activate = false,

        mouse_move_focuses_monitor = true,
        allow_session_lock_restore = false,
        session_lock_xray = false,
        session_lock_blur = false,
        background_color = 0x111111,
        close_special_on_empty = true,
        on_focus_under_fullscreen = 2,
        exit_window_retains_fullscreen = false,
        initial_workspace_tracking = 1,
        initial_workspace_token_timeout = 10,
        middle_click_paste = true,
        render_unfocused_fps = 15,
        disable_xdg_env_checks = false,
        disable_hyprland_guiutils_check = false,
        lockdead_screen_delay = 1000,
        enable_anr_dialog = true,
        anr_missed_pings = 5,
        size_limits_tiled = false,
        screencopy_force_8b = true,
        disable_watchdog_warning = false,
    },
})
