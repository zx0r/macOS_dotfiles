# Optimized XDG Base Directory configuration by improving readability, consistency, and security.
# This version follows best practices while ensuring proper variable scoping and avoiding unnecessary redundancy.

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# XDG Base Directory Specification (Optimized)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Ensure HOME is set for consistency
set -q HOME || set -gx HOME (echo ~)

# Define XDG directories with proper fallback
set -q XDG_CACHE_HOME || set -gx XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME || set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME || set -gx XDG_STATE_HOME "$HOME/.local/state"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# XDG Runtime Directory (Ensuring Secure Creation)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if not set -q XDG_RUNTIME_DIR
    set -gx XDG_RUNTIME_DIR (mktemp -d "/tmp/$USER-runtime.XXXXXX") # Secure temp dir
    chmod 700 "$XDG_RUNTIME_DIR" # Restrict permissions for security
end

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Executable Directories
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -q XDG_BIN_HOME || set -gx XDG_BIN_HOME "$HOME/.local/bin"
set -q XDG_SCRIPTS_HOME || set -gx XDG_SCRIPTS_HOME "$XDG_BIN_HOME/scripts"

# Homebrew prefix should be dynamically determined if available
if test -x (command -q brew)
    set -gx HOMEBREW_PREFIX (brew --prefix)
    set -q XDG_BIN_DIR || set -gx XDG_BIN_DIR "$HOMEBREW_PREFIX/bin"
end

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# XDG User Directories (Standardized Paths)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -gx XDG_DOWNLOAD_DIR "$HOME/Downloads"
set -gx XDG_TEMPLATES_DIR "$HOME/Templates"
set -gx XDG_DOCUMENTS_DIR "$HOME/Documents"
set -gx XDG_PUBLICSHARE_DIR "$HOME/Public"
set -gx XDG_PICTURES_DIR "$HOME/Pictures"
set -gx XDG_DESKTOP_DIR "$HOME/Desktop"
set -gx XDG_VIDEOS_DIR "$HOME/Videos"
set -gx XDG_MUSIC_DIR "$HOME/Music"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Custom XDG Directories (Organized for Productivity)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -gx XDG_BACKUP_HOME "$HOME/backup"
set -gx XDG_PROJECTS_HOME "$HOME/rojects"
set -gx XDG_DOTFILES_HOME "$HOME/dotfiles"
