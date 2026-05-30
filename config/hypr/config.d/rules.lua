
-- ========================
-- RÈGLES DE FENÊTRES
-- ========================

-- Ignore les demandes de maximisation — toutes les apps
hl.window_rule({
    name           = "supprime-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Corrige les problèmes de glisser-déplacer XWayland
hl.window_rule({
    name     = "fixe-drags-xwayland",
    match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Outils de bureau
hl.window_rule({
    name  = "flottant-calculatrice",
    match = { class = "^(org\\.gnome\\.Calculator)$" },
    float = true,
})

-- Escape from Tarkov
hl.window_rule({
    name  = "flottant-bsglauncher",
    match = { class = "^(bsglauncher\\.exe)$" },
    float = true,
})

-- Steam
hl.window_rule({
    name      = "steam-espace4",
    match     = { class = "^(steam)$" },
    workspace = "4",
})

