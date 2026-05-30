
-- ========================
-- CONFIG PLUGIN hy3
-- ========================

hl.config({
    plugin = {
        hy3 = {
            -- no_gaps_when_only n'existe plus dans hl0.55
            node_collapse_policy = 2,
            group_inset          = 10,
            tab_first_window     = false,
            tabs = {
                height       = 22,
                padding      = 6,
                from_top     = false,
                radius       = 6,
                border_width = 2,
                render_text  = true,
                text_center  = true,
                text_font    = "Sans",
                text_height  = 8,
                text_padding = 3,
                colors = {
                    active               = "rgba(33ccff40)",
                    active_border        = "rgba(33ccffee)",
                    active_text          = "rgba(ffffffff)",
                    focused              = "rgba(60606040)",
                    focused_border       = "rgba(808080ee)",
                    focused_text         = "rgba(ffffffff)",
                    inactive             = "rgba(30303020)",
                    inactive_border      = "rgba(606060aa)",
                    inactive_text        = "rgba(ffffffff)",
                    urgent               = "rgba(ff223340)",
                    urgent_border        = "rgba(ff2233ee)",
                    urgent_text          = "rgba(ffffffff)",
                    locked               = "rgba(90903340)",
                    locked_border        = "rgba(909033ee)",
                    locked_text          = "rgba(ffffffff)",
                },
                blur    = true,
                opacity = 1.0,
            },
            autotile = {
                enable           = false,
                ephemeral_groups = true,
                trigger_width    = 0,
                trigger_height   = 0,
                workspaces       = "all",
            },
        },
    },
})

