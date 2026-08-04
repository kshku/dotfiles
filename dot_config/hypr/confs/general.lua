hl.config({
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 20,
        float_gaps = 0,
        gaps_workspaces = 0,

        col = {
            inactive_border = "0xaa595959",
            active_border = { colors = { "0xee33ccff", "0xee00ff99" }, angle = 45 },
            nogroup_border = 0xffffaaff,
            nogroup_border_active = 0xffff00ff,
        },

        layout = "dwindle",
        no_focus_fallback = false,
        resize_on_border = false,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,
        allow_tearing = false,
        resize_corner = 0,
        modal_parent_blocking = true,
        locale = "",

        snap = {
            enabled = true,
            window_gap = 20,
            monitor_gap = 20,
            border_overlap = false,
            respect_gaps = false,
        },
    },
})
