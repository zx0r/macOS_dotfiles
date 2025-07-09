# Bat configuration
if test -x (command -q bat)
    set -gx BAT_PAGER "less -rf"
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx BAT_CONFIG_DIR "$XDG_CONFIG_HOME/bat"
    set -gx BAT_CONFIG_PATH "$XDG_CONFIG_HOME/bat/bat.conf"
end
