
package.path = package.path .. ";/home/simon/.config/hypr/config.d/?.lua"

-- ========================
-- MONITEURS
-- ========================

hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@164.96",
    position = "0x0",
    scale    = 1,
    vrr      = 2,
})


-- ==========================
-- VARIABLES D'ENVIRONNEMENT
-- ==========================

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "25")


-- ========================
-- DÉMARRAGE AUTOMATIQUE
-- ========================

hl.on("hyprland.start", function()
    -- hl.exec_cmd("hyprpm enable hy3")
    -- hl.exec_cmd("hyprpm reload -n")
    -- FIXME: retourner à hyprpm enable, reload une fois que les patchs sur hy3 seront fusionnées et qu'on sera sur une
    -- version stable.
    hl.exec_cmd("hyprctl plugin load /var/cache/hyprpm/simon/hy3/hy3.so")
    hl.exec_cmd("wayle panel start")
    hl.exec_cmd("hyprshell run")
    hl.exec_cmd("easyeffects --gapplication-service")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)


-- ========================
-- APPARENCE GÉNÉRALE
-- ========================

hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 5,
        border_size      = 2,
        col = {
            active_border   = "rgba(d8b56dff)",
            inactive_border = "rgba(000000ff)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "hy3",
    },
})


-- ========================
-- DÉCORATION
-- ========================

hl.config({
    decoration = {
        rounding         = 10,
        rounding_power   = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        dim_special      = 0.7,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
})


-- ========================
-- ANIMATIONS
-- ========================

hl.config({ animations = { enabled = true } })

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0}  } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default"      })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint",  style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",        style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear"  })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick"         })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint"  })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear"  })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear",  style = "fade" })


-- ========================
-- LAYOUTS
-- ========================

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})


-- ========================
-- DIVERS
-- ========================

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


-- ========================
-- ENTRÉES
-- ========================

hl.config({
    input = {
        kb_layout    = "ca-multix-sim590",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "ctrl:nocaps,numpad:mac",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


-- ============================
-- RÈGLES D'ESPACES DE TRAVAIL
-- ============================

-- Bloc-notes (espace spécial)
hl.workspace_rule({
    workspace = "special:magic",
    gaps_out  = 80,
    gaps_in   = 10,
})

-- ============
--  AUTRES
-- ============

require("hy3")
require("smw")
require("keys")
require("rules")

