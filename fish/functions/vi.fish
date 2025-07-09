# Fish Shell Functions and Abbreviations for Neovim Configuration Management

# Author: zx0r
# Description: A set of Fish shell functions and abbreviations to manage and switch between multiple Neovim configurations.
# Version: 1.0

# Overview:
# These functions and abbreviations simplify the process of managing multiple Neovim configurations.
# They allow you to:
# 1. Use `v` as an alias for `nvim`.
# 2. Use `vi` to launch Neovim with a specific configuration profile.
# 3. Use `ns` (via `nvim_switch_config`) to interactively switch between Neovim configurations.

# Prerequisites:
# - Fish shell installed.
# - Neovim installed.
# - Multiple Neovim configurations stored in `$XDG_CONFIG_HOME/nvim-profiles`.

# Functions and Abbreviations:

# 1. `v` - Alias for Neovim
# Description: A simple alias for launching Neovim.
# Usage: `v <file>`
function v --wraps=nvim --description 'alias v=nvim'
    nvim $argv
end

# 2. `vi` - Launch Neovim with a Specific Profile
# Description: Launches Neovim with a predefined configuration profile (`nvim-x0r`).
# Usage: `vi <file>`
function vi --wraps=nvim --description 'alias vi=env NVIM_APPNAME=$config nvim $argv'
    set -l profile nvim
    set -l appname nvim-profiles/$profile
    set -gx NVIM_APPNAME $appname
    nvim $argv
end

# 3. `nvim_switch_config` - Interactive Neovim Configuration Switcher
# Description: Allows you to interactively select and switch between Neovim configurations using `fzf`.
# Usage: `ns <file>`
function nvims --wraps=nvim --description 'alias ns=#env NVIM_APPNAME=$config nvim $argv'
    # Discover specific Neovim configurations
    set -l profiles (fd --max-depth 1 --glob '*nvim*' $XDG_CONFIG_HOME/nvim-profiles | xargs -n 1 basename)
    set -l config (printf "%s\n" $profiles | fzf --prompt=" Neovim Config > " --height=50% --layout=reverse --border --exit-0)
    set -l profile nvim-profiles/$config

    # Check if no configuration is selected
    if test -z "$config"
        echo "No profile selected."
        return 0
    end

    # Check for the default configuration
    if test "$config" = default
        set -l config ""
    end

    # Set the NVIM_APPNAME environment variable and launch Neovim
    set -gx NVIM_APPNAME $profile
    nvim $argv
end

# Abbreviation for `nvim_switch_config`
# Description: Shortcut for `nvim_switch_config`.
# Usage: `ns <file>`
abbr -a ns nvim_switch_config

# Notes:
# - Ensure `fd` and `fzf` are installed for the `nvim_switch_config` function to work.
# - Neovim configurations should be stored in `$XDG_CONFIG_HOME/nvim-profiles` (e.g., `~/.config/nvim-profiles/`).
# - The `NVIM_APPNAME` environment variable is used to specify the configuration profile.

# Example Neovim Profiles:
# - `nvim-profiles/nvim-x0r`: Custom configuration for zx0r.
# - `nvim-profiles/default`: Default Neovim configuration.

# Example Usage:
# 1. Open a file with the default Neovim configuration:
#    v myfile.txt
# 2. Open a file with the `nvim-x0r` configuration:
#    vi myfile.txt
# 3. Interactively switch Neovim configurations and open a file:
#    ns myfile.txt


# function v --wraps=nvim --description 'alias v=nvim'
#     nvim $argv
# end

# function vi --wraps=nvim --description 'alias vi=#env NVIM_APPNAME=$config nvim $argv'
#     set -l profile nvim-x0r
#     set -l appname nvim-profiles/$profile
#     set -gx NVIM_APPNAME $appname
#     nvim $argv
# end

# ###################################################### [[ Neovim Config Switch function ]] ################################

# function nvim_switch_config --wraps=nvim --description 'alias ns=#env NVIM_APPNAME=$config nvim $argv'
#     # Discover specific Neovim configurations
#     set -l profiles (fd --max-depth 1 --glob '*nvim*' $XDG_CONFIG_HOME/nvim-profiles | xargs -n 1 basename)
#     set -l config (printf "%s\n" $profiles | fzf --prompt=" Neovim Config > " --height=50% --layout=reverse --border --exit-0)
#     set -l profile nvim-profiles/$config


#     # Check if no configuration is selected
#     if test -z "$config"
#         echo "No profile selected."
#         return 0
#     end

#     # Check for the default configuration
#     if test "$config" = default
#         set -l config ""
#     end

#     # Set the NVIM_APPNAME environment variable and launch Neovim
#     set -gx NVIM_APPNAME $profile
#     nvim $argv
# end

# abbr -a ns nvim_switch_config


###################################################### [[ Neovim Config Switch function ]] ################################

# function nvims
#     set items LazyVim NVim ModernNeovim AstroNvim EcoVim
#     set config (printf "%s\n" $items | fzf --prompt=" Neovim Config = " --height=50% --layout=reverse --border --exit-0)
#     if [ -z $config ]
#         echo "Nothing selected"
#         return 0
#     else if [ $config = default ]
#         set config ""
#     end
#     env NVIM_APPNAME=$config nvim $argv
# end

#bind \ca 'nvims\n'```

###################################################### [[ ALIASES ]] ######################################################
