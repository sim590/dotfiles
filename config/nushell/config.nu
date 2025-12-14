# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.EDITOR             = "vim"
$env.config.show_banner = false
$env.config.edit_mode   = 'vi'

# Thème
$env.LS_COLORS = (vivid generate molokai)

source $"($nu.cache-dir)/carapace.nu"

oh-my-posh init nu --config /usr/share/oh-my-posh/themes/craver.omp.json

