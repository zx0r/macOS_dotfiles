# Fish Shell Functions for Neovim Configuration Management and Issue Reproduction

# Author: folke
# Description: A set of Fish shell functions to manage Neovim configurations, reproduce issues, and install new profiles.
# Version: 1.0

# Overview:
# These functions simplify the process of:
# 1. Reproducing Neovim issues by fetching and running Lua scripts from GitHub issues.
# 2. Switching between multiple Neovim configurations.
# 3. Installing and cleaning Neovim profiles.

# Prerequisites:
# - Fish shell installed.
# - Neovim installed.
# - GitHub CLI (`gh`) installed for issue fetching.
# - `fzf` installed for interactive profile selection.
# - Git installed for profile installation.

# Functions:

# 1. `repro` - Reproduce Neovim Issues
# Description: Fetches and runs Lua scripts from GitHub issues for debugging.
# Usage: `repro <issue-number>`
function repro -a issue
    if test -z "$issue"
        echo "Usage: repro <issue>"
        return 1
    end
    set file ./debug/$issue.lua

    # Fetch the issue if it doesn't exist
    if not test -f $file
        echo "Fetching issue #$issue"
        gh issue view $issue | sed -n '/```[Ll]ua/,/```/p' | sed '1d;$d' >$file
    end

    # Use local lazy and plugins
    set -x LAZY_PATH ~/projects/lazy.nvim
    set -x LAZY_DEV "x0r,LazyVim"

    # Run the repro
    nvim -u $file $file
end

# 2. `nvims` - Switch Neovim Profiles
# Description: Allows switching between Neovim configurations interactively or by specifying a profile.
# Usage: `nvims [profile] [file]`
function nvims --wraps nvim
    set -l profile $argv[1]

    # Check if the provided profile exists
    if test -n "$profile" -a -d ~/.config/nvim-profiles/"$profile"
        set args $argv[2..-1]
    else
        # Use fzf to allow the user to select a profile
        set profile (command ls ~/.config/nvim-profiles/ | fzf --prompt=" Neovim Profile: " --height=~50% --layout=reverse --exit-0)
        if test -z "$profile"
            return 1
        end
    end

    set -l appname nvim-profiles/$profile
    if not test -d ~/.config/"$appname"
        echo "Profile $profile does not exist."
        echo "Use nvims_install to install a new profile."
        return 1
    end

    set -x NVIM_APPNAME $appname
    nvim $argv
end

# 3. `nvims_tmp` - Use a Temporary Neovim Profile
# Description: Creates a temporary Neovim profile linked to the current directory.
# Usage: `nvims_tmp`
function nvims_tmp --description 'switch to the Neovim config in this directory'
    [ -L ~/.config/nvim-profiles/tmp ]
    and rm ~/.config/nvim-profiles/tmp
    ln -s (realpath .) ~/.config/nvim-profiles/tmp
    and nvims tmp
end

# 4. `nvims_install` - Install a New Neovim Profile
# Description: Installs a new Neovim profile from a Git repository.
# Usage: `nvims_install <url> <profile>`
function nvims_install -a url -a profile
    if test -z "$profile" -o -z "$url"
        echo "Usage: nvim_profile_install <url> <profile>"
        return 1
    end

    set -l dest ~/.config/nvim-profiles/$profile
    if test -d $dest
        echo "Profile $profile already exists"
        return 1
    end

    git clone $url.git $dest
    nvims $profile
end

# 5. `nvims_clean` - Clean Neovim Profile Data
# Description: Cleans data (cache, state, etc.) for a specific Neovim profile.
# Usage: `nvims_clean <profile>`
function nvims_clean -a profile
    if test -z "$profile"
        echo "Usage: nvim_clean <profile>"
        return 1
    end

    test -d ~/.local/share/nvim-profiles/$profile
    and rm -rf ~/.local/share/nvim-profiles/$profile

    test -d ~/.local/state/nvim-profiles/$profile
    and rm -rf ~/.local/state/nvim-profiles/$profile

    test -d ~/.cache/nvim-profiles/$profile
    and rm -rf ~/.cache/nvim-profiles/$profile
end

# Autocomplete profiles for the `nvims` function
complete -f -c nvims -a '(command ls ~/.config/nvim-profiles/)'

# Notes:
# - Ensure `gh`, `fzf`, and `git` are installed for full functionality.
# - Neovim configurations should be stored in `~/.config/nvim-profiles/`.
# - The `NVIM_APPNAME` environment variable is used to specify the configuration profile.

# Example Usage:
# 1. Reproduce an issue from GitHub:
#    repro 123
# 2. Switch to a specific Neovim profile:
#    nvims my-profile
# 3. Interactively select a Neovim profile:
#    nvims
# 4. Create a temporary Neovim profile for the current directory:
#    nvims_tmp
# 5. Install a new Neovim profile from a Git repository:
#    nvims_install https://github.com/user/repo my-new-profile
# 6. Clean data for a Neovim profile:
#    nvims_clean my-profile

# function repro -a issue
#     if test -z "$issue"
#         echo "Usage: repro <issue>"
#         return 1
#     end
#     set file ./debug/$issue.lua

#     # Fetch the issue if it doesn't exist
#     if not test -f $file
#         echo "Fetching issue #$issue"
#         gh issue view $issue | sed -n '/```[Ll]ua/,/```/p' | sed '1d;$d' >$file
#     end

#     # Use local lazy and plugins
#     set -x LAZY_PATH ~/projects/lazy.nvim
#     set -x LAZY_DEV "x0r,LazyVim"

#     # Run the repro
#     nvim -u $file $file
# end

# # Function to select or use a given Neovim profile
# function nvims --wraps nvim
#     set -l profile $argv[1]

#     # Check if the provided profile exists
#     if test -n "$profile" -a -d ~/.config/nvim-profiles/"$profile"
#         set args $argv[2..-1]
#     else
#         # Use fzf to allow the user to select a profile
#         set profile (command ls ~/.config/nvim-profiles/ | fzf --prompt=" Neovim Profile: " --height=~50% --layout=reverse --exit-0)
#         if test -z "$profile"
#             return 1
#         end
#     end

#     set -l appname nvim-profiles/$profile
#     if not test -d ~/.config/"$appname"
#         echo "Profile $profile does not exist."
#         echo "Use nvims_install to install a new profile."
#         return 1
#     end

#     set -x NVIM_APPNAME $appname
#     nvim $argv
# end

# function nvims_tmp --description 'switch to the Neovim config in this directory'
#     [ -L ~/.config/nvim-profiles/tmp ]
#     and rm ~/.config/nvim-profiles/tmp
#     ln -s (realpath .) ~/.config/nvim-profiles/tmp
#     and nvims tmp
# end

# # Autocomplete profiles for the nvims function
# complete -f -c nvims -a '(command ls ~/.config/nvim-profiles/)'

# # Function to install a new Neovim profile from a given Git URL
# function nvims_install -a url -a profile
#     if test -z "$profile" -o -z "$url"
#         echo "Usage: nvim_profile_install <url> <profile>"
#         return 1
#     end

#     set -l dest ~/.config/nvim-profiles/$profile
#     if test -d $dest
#         echo "Profile $profile already exists"
#         return 1
#     end

#     git clone $url.git $dest
#     nvims $profile
# end

# function nvims_clean -a profile
#     if test -z "$profile"
#         echo "Usage: nvim_clean <profile>"
#         return 1
#     end

#     test -d ~/.local/share/nvim-profiles/$profile
#     and rm -rf ~/.local/share/nvim-profiles/$profile

#     test -d ~/.local/state/nvim-profiles/$profile
#     and rm -rf ~/.local/state/nvim-profiles/$profile

#     test -d ~/.cache/nvim-profiles/$profile
#     and rm -rf ~/.cache/nvim-profiles/$profile
# end

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
