-- keys.lua
-- Raccourcis clavier — hy3 + split-monitor-workspaces

local smw = require("split-monitor-workspaces")  -- déjà configuré dans hyprland.lua

local mainMod = "SUPER"

local terminal = "alacritty"

-- hy3 est chargé APRÈS la config (via hyprpm reload -n dans l'autostart).
-- On crée donc un dispatcher évalué à l'exécution (lazily), pas au chargement.
local function hy3(method, ...)
    local args = {...}
    return function()
        local h = hl.plugin.hy3
        if not h then return end
        hl.dispatch(h[method](table.unpack(args)))
    end
end


-- ========================
-- FONCTIONS UTILITAIRES
-- ========================

--- Navigue vers l'espace de travail occupé suivant ou précédent sur le
--- moniteur courant. Saute les espaces vides. Pas de bouclage.
--- Remplace le script ~/bin/hypr-cycle-workspace (incompatible avec hyprctl 0.55+).
local function cycle_occupied_workspace(direction)
    return function()
        local cur_ws = hl.get_active_workspace()
        if not cur_ws or not cur_ws.monitor then return end
        local mon = cur_ws.monitor

        -- Collecter les espaces occupés sur ce moniteur, triés par ID
        local occupied = {}
        for _, ws in ipairs(hl.get_workspaces()) do
            if ws.monitor and ws.monitor.name == mon.name and ws.windows > 0 and not ws.special then
                table.insert(occupied, ws.id)
            end
        end
        table.sort(occupied)
        if #occupied == 0 then return end

        -- Trouver l'index de l'espace actif dans la liste
        local cur_idx = nil
        for i, id in ipairs(occupied) do
            if id == cur_ws.id then cur_idx = i; break end
        end

        local target_id
        if cur_idx then
            -- L'espace actif est occupé — aller au suivant/précédent
            local next_idx = direction == "next" and cur_idx + 1 or cur_idx - 1
            if next_idx < 1 or next_idx > #occupied then return end
            target_id = occupied[next_idx]
        else
            -- L'espace actif est vide — aller au plus proche dans la direction
            if direction == "next" then
                for _, id in ipairs(occupied) do
                    if id > cur_ws.id then target_id = id; break end
                end
            else
                for i = #occupied, 1, -1 do
                    if occupied[i] < cur_ws.id then target_id = occupied[i]; break end
                end
            end
            if not target_id then return end
        end

        hl.dispatch(hl.dsp.focus({ workspace = tostring(target_id) }))
    end
end

--- Commutateur de fenêtres via rofi.
--- Remplace le script ~/bin/hypr-window-switcher (incompatible avec hyprctl 0.55+).
--- Note : rofi est bloquant, on doit le lancer via exec_cmd (processus externe)
--- pour ne pas geler le compositeur. Le focus se fait ensuite via hyprctl
--- avec la syntaxe Lua 0.55+.
local function window_switcher()
    local windows = hl.get_windows()
    if not windows or #windows == 0 then return end

    -- Construire la liste pour rofi
    local lines = {}
    for _, w in ipairs(windows) do
        local ws_name = w.workspace and w.workspace.name or "?"
        -- Échapper les guillemets simples dans le titre
        local title = w.title:gsub("'", "'\\''")
        local class = w.class:gsub("'", "'\\''")
        table.insert(lines, string.format("%s [%s] %s: %s", w.address, ws_name, class, title))
    end
    local input = table.concat(lines, "\n"):gsub('"', '\\"')

    -- Lancer rofi dans un sous-processus pour ne pas bloquer le compositeur
    local script = string.format(
        'selected=$(echo "%s" | /usr/bin/rofi -dmenu -i -p "Fenêtre"); '
        .. '[ -n "$selected" ] && addr=$(echo "$selected" | awk \'{print $1}\') && '
        .. 'hyprctl dispatch "hl.dsp.focus({window=\\"address:$addr\\"})"',
        input
    )
    hl.dispatch(hl.dsp.exec_cmd(script))
end


-- ========================
-- SYSTÈME
-- ========================

hl.bind(mainMod .. " + SHIFT + delete",        hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + CTRL + SHIFT + delete",  hl.dsp.exec_cmd("wlogout"))


-- ========================
-- TERMINAL ET LANCEURS
-- ========================

hl.bind(mainMod .. " + return",    hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("bemenu-run"))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("bemenu-run"))


-- ========================
-- FENÊTRES
-- ========================

hl.bind(mainMod .. " + SHIFT + C",     hy3("kill_active"))
hl.bind(mainMod .. " + SHIFT + q",     hl.dsp.exit())
hl.bind(mainMod .. " + f",             hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))


-- ========================
-- GROUPES hy3
-- ========================

-- NOTE : force_ephemeral n'existe pas pour change_group (seulement make_group)
hl.bind(mainMod .. " + CTRL + w", hy3("change_group", "tab"))
hl.bind(mainMod .. " + v",        hy3("make_group", "v"))
hl.bind(mainMod .. " + b",        hy3("make_group", "h"))
hl.bind(mainMod .. " + u",        hy3("change_group", "opposite"))

hl.bind(mainMod .. " + CTRL + a", hy3("change_focus", "raise"))
hl.bind(mainMod .. " + CTRL + x", hy3("change_focus", "lower"))


-- ========================
-- FOCUS
-- ========================

-- Focus moniteur
hl.bind(mainMod .. " + CTRL + l", hl.dsp.focus({ monitor = "DP-2" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.focus({ monitor = "DP-1" }))

-- Espace de travail précédent
hl.bind(mainMod .. " + escape", hl.dsp.focus({ workspace = "previous" }))

-- Déplacement de focus hy3 (hjkl)
hl.bind(mainMod .. " + h", hy3("move_focus", "l"))
hl.bind(mainMod .. " + l", hy3("move_focus", "r"))
hl.bind(mainMod .. " + k", hy3("move_focus", "u"))
hl.bind(mainMod .. " + j", hy3("move_focus", "d"))


-- ========================
-- DÉPLACEMENT DE FENÊTRES hy3
-- ========================

hl.bind(mainMod .. " + SHIFT + h", hy3("move_window", "l"))
hl.bind(mainMod .. " + SHIFT + l", hy3("move_window", "r"))
hl.bind(mainMod .. " + SHIFT + k", hy3("move_window", "u"))
hl.bind(mainMod .. " + SHIFT + j", hy3("move_window", "d"))


-- ========================
-- ESPACES DE TRAVAIL (split-monitor-workspaces)
-- ========================

for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    if n == "10" then n = "0" end
    hl.bind(mainMod .. " + " .. n,         smw.workspace(n))
    hl.bind(mainMod .. " + SHIFT + " .. n, smw.move_to_workspace_silent(n))
end

-- Cycle entre espaces de travail sur le moniteur courant
hl.bind(mainMod .. " + right", cycle_occupied_workspace("next"))
hl.bind(mainMod .. " + left",  cycle_occupied_workspace("prev"))

-- Déplacer la fenêtre active vers l'espace de travail actif du prochain moniteur
-- (équivalent de split-changemonitor, next — pas de dispatcher natif pour ça en Lua)
hl.bind(mainMod .. " + o", function()
    local monitors = hl.get_monitors()
    if #monitors < 2 then return end
    local cur = hl.get_active_monitor()
    if not cur then return end
    for i, m in ipairs(monitors) do
        if m.id == cur.id then
            local next_m = monitors[(i % #monitors) + 1]
            if next_m and next_m.active_workspace then
                local ws = next_m.active_workspace.name
                local h = hl.plugin.hy3
                if h then
                    hl.dispatch(h.move_to_workspace(ws, { follow = true }))
                else
                    hl.dispatch(hl.dsp.window.move({ workspace = ws }))
                end
            end
            return
        end
    end
end)


-- ========================
-- REDIMENSIONNEMENT
-- ========================

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 80,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -80, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -80, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 80,  relative = true }), { repeating = true })


-- ========================
-- ESPACE SPÉCIAL (bac à sable)
-- ========================

hl.bind(mainMod .. " + minus",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:magic" }))


-- ========================
-- SOURIS
-- ========================

-- Défilement entre espaces de travail
hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up",   smw.cycle_workspaces("prev"))

-- Déplacer / redimensionner avec mainMod + clic gauche / droit
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- ========================
-- MULTIMÉDIA (touches spéciales)
-- ========================

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


-- ========================
-- AUDIO MPD / WPCTL
-- ========================

hl.bind(mainMod .. " + SHIFT + p",      hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + MOD5 + period",  hl.dsp.exec_cmd("mpc next"))
hl.bind(mainMod .. " + MOD5 + comma",   hl.dsp.exec_cmd("mpc prev"))
hl.bind(mainMod .. " + F4",             hl.dsp.exec_cmd(os.getenv("HOME") .. "/bin/mpd-toggle-local"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind(mainMod .. " + SHIFT + m",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))


-- ========================
-- PROFILS EASYEFFECTS
-- ========================

hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("easyeffects -l audiotechnica-roland"))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("easyeffects -l robot"))
-- F9 est intentionnellement lié deux fois (profil rose + bascule audio filaire)
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("easyeffects -l rose"))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd(
    "pactl set-default-source alsa_input.usb-Roland_Rubix22-00.analog-stereo && " ..
    "pactl set-default-sink alsa_output.pci-0000_0c_00.4.analog-stereo"
))


-- ========================
-- BASCULE AUDIO (périphériques)
-- ========================

-- Casque sans-fil (Arctis Nova 3P)
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd(
    "pactl set-default-source alsa_input.usb-SteelSeries_Arctis_Nova_3P_Wireless-00.mono-fallback && " ..
    "pactl set-default-sink alsa_output.usb-SteelSeries_Arctis_Nova_3P_Wireless-00.analog-stereo"
))
-- Micro Roland uniquement
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd(
    "pactl set-default-source alsa_input.usb-Roland_Rubix22-00.analog-stereo"
))


-- ========================
-- APPLICATIONS
-- ========================

hl.bind(mainMod .. " + a",                hl.dsp.exec_cmd("alacritty -e ranger"))
hl.bind(mainMod .. " + e",                hl.dsp.exec_cmd("alacritty -e bash -c 'sleep 0.05; vim'"))
hl.bind(mainMod .. " + CTRL + d",         hl.dsp.exec_cmd("alacritty -e pulsemixer"))
hl.bind(mainMod .. " + d",                hl.dsp.exec_cmd("alacritty -e ncmpcpp"))
hl.bind(mainMod .. " + z",                hl.dsp.exec_cmd("qutebrowser"))
hl.bind(mainMod .. " + i",                hl.dsp.exec_cmd("alacritty -e neomutt"))
hl.bind(mainMod .. " + SHIFT + t",        hl.dsp.exec_cmd("hypr-layout --terminal " .. terminal .. " 'h({btop}, 25%:{nvtop})'"))
hl.bind(mainMod .. " + SHIFT + z",        hl.dsp.exec_cmd("chromium"))
hl.bind(mainMod .. " + CTRL + SHIFT + p", hl.dsp.exec_cmd("passmenu"))
hl.bind(mainMod .. " + SHIFT + d",        hl.dsp.exec_cmd(
    "hypr-layout " .. "--terminal " .. terminal
                   .. " 't(h(v(30%:{pulsemixer}, {ncmpcpp -s playlist}), v({ncmpcpp -s media_library}, {ncmpcpp -s search_engine})), easyeffects, qpwgraph)'")
)


-- ========================
-- DIVERS
-- ========================

-- Gray Zone Warfare — jeter des items
hl.bind(mainMod .. " + q", hl.dsp.exec_cmd("ydotool key 111:1 111:0"))

-- Verrouiller et suspendre
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("hyprlock & systemctl suspend"))

-- Gammastep
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd("pkill gammastep || gammastep -O 2800"))

-- Focus mode toggle (tuilé ↔ flottant)
hl.bind(mainMod .. " + space", hy3("toggle_focus_layer"))

-- Commutateur de fenêtres
hl.bind(mainMod .. " + F1", window_switcher)

-- Captures d'écran
hl.bind("Print",                hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("CTRL + Print",         hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("SHIFT + Print",        hl.dsp.exec_cmd("grim"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("bash -c 'sleep 5 ; grim'"))

-- Libérer la capture d'entrée (Deskflow)
-- NOTE : releaseinputcapture absent des stubs — exec_raw est la meilleure approximation
hl.bind(mainMod .. " + SHIFT + escape", hl.dsp.exec_raw("releaseinputcapture"))
