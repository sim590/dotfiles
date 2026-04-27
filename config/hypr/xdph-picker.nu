#!/usr/bin/env nu
# Sélecteur d'écran pour xdg-desktop-portal-hyprland.
# Remplace hyprland-share-picker (Qt/GTK) par slurp.
#
# Format de sortie attendu par xdph (ScreencopyShared.cpp) :
#   [SELECTION]<drapeaux>/<type>:<valeur>
#
# Drapeaux :
#   r = autoriser le jeton de persistance
#
# Types :
#   screen:<nom_ecran>
#   region:<nom_ecran>@<x>,<y>,<w>,<h>
#   window:<handle>

let output = try {
    ^slurp -o -f "%o" err> /dev/null | complete
} catch {
    exit 1
}

if $output.exit_code != 0 {
    exit 1
}

let ecran = $output.stdout | str trim
print $"[SELECTION]r/screen:($ecran)"
