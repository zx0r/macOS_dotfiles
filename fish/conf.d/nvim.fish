# Neovim configuration
if test -x (command -q nvim) && test -z "$EDITOR"
    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR
    set -gx GIT_EDITOR $EDITOR
    set -gx SUDO_EDITOR $EDITOR

    # Set default profile for $XDG_CONFIG_HOME/nvim-profiles/nvim
    set -l profile nvim
    set -l appname nvim-profiles/$profile
    set -gx NVIM_APPNAME $appname
end
