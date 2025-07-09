#!/usr/bin/env bash

# Script to install Yazi plugins using `ya pack -a` and gitee repo.
# If a plugin fails to install, the script continues and reports errors at the end.
#
# https://gitee.com/DreamMaoMao/yazi-plugins

# Enable strict  handling
set -euo pipefail

# Regular Colors
BLACK='\033[0;30m'  # Black
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
CYAN='\033[0;33m'   # CYAN
BLUE='\033[0;34m'   # Blue
CYAN='\033[1;34m'   # Blue
YELLOW='\033[0;33m' # Yellow
PURPLE='\033[0;35m' # Purple
CYAN='\033[0;36m'   # Cyan
# WHITE='\033[0;37m'  # White
# BWHITE='\033[1;37m' # Bold White
NC='\033[0m' # Text Reset

THEMES=(
  "tkapias/moonfly"
  "dangooddd/kanagawa"
  "kmlupreti/ayu-dark"
  "PinThePenguine/sunset"
  "yazi-rs/flavors:catppuccin-latte"
  "yazi-rs/flavors:catppuccin-mocha"
  "yazi-rs/flavors:catppuccin-frappe"
  "yazi-rs/flavors:catppuccin-macchiato"
  # "yazi-rs/flavors:dracula"
)

PLUGINS=(
  "yazi-rs/plugins:hide-preview"
  "yazi-rs/plugins:full-border"
  # "yazi-rs/plugins:mime-ext"
  "yazi-rs/plugins:max-preview"
  "yazi-rs/plugins:chmod"
  "yazi-rs/plugins:diff"
  "yazi-rs/plugins:jump-to-char"
  "yazi-rs/plugins:smart-filter"
  "yazi-rs/plugins:mactag"
  "yazi-rs/plugins:git"
  "Reledia/glow"
  "Reledia/miller"
  "Rolv-Apneseth/starship"
  "Rolv-Apneseth/bypass"
  "imsi32/yatline"
  "imsi32/yatline-githead"
  # "redbeardymcgee/yazi-plugins:fg"
  "kirasok/torrent-preview"
  "dedukun/relative-motions"
  "ndtoan96/ouch"
  "Sonico98/exifaudio"
  "BBOOXX/file-actions"
  "KKV9/compress"
  "KKV9/command"
  "GrzegorzKozub/mdcat"
  "Lil-Dank/lazygit"
  "GianniBYoung/rsync"
  "h-hg/yamb"
  "SL-RU/mount"
  # "AnirudhG07/custom-shell"
  "AnirudhG07/rich-preview"
  "AnirudhG07/nbpreview"
  "AnirudhG07/plugins-yazi:copy-file-contents"
)

GITEE=(
  "https://gitee.com/DreamMaoMao/autosort.yazi.git"
  "https://github.com/DreamMaoMao/autofilter.yazi.git"
  "https://gitee.com/DreamMaoMao/epub.yazi.git"
  # "https://gitee.com/DreamMaoMao/fg.yazi.git"
  "https://github.com/DreamMaoMao/fg.yazi.git"
  "https://github.com/DreamMaoMao/mime-ext.yazi.git"
  # "https://gitee.com/DreamMaoMao/mime-ext.yazi.git"
  "https://github.com/DreamMaoMao/keyjump.yazi.git"
  "https://gitee.com/DreamMaoMao/clipboard.yazi"
  "https://gitee.com/DreamMaoMao/current-size.yazi.git"
  "https://gitee.com/DreamMaoMao/lastopen.yazi.git"
  "https://gitee.com/DreamMaoMao/easyjump.yazi.git"
  "https://gitee.com/DreamMaoMao/searchjump.yazi.git"
  "https://gitee.com/DreamMaoMao/mime-preview.yazi.git"
  "https://github.com/AnirudhG07/custom-shell.yazi.git" # Uncomment if failed install with `ya pack -a AnirudhG07/custom-shell`
)

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to print a step message
print_step() {
  local step_name="$1"
  echo -e "${BLACK} ➜ ${step_name}${NC}"
}

# Print Success message
print_success() {
  echo -e "\n${GREEN}✅ $1${NC}\n"
}

# Print Warnining message
print_warn() {
  echo -e "${YELLOW}[Warn] $1${NC}"
}

# Print Error message and exit
print_error() {
  echo -e "${RED}❗️$1${NC}"
  exit 1
}

# Check if required packages are installed
check_deps() {
  for pkg in ya yazi git; do
    if ! command -v "$pkg" >/dev/null 2>&1; then
      print_error "Error: '$pkg' is not installed. Please install it first." >&2
      exit 1
    fi
  done
}

move_package_toml() {
  local original_file="package.toml"
  local backup_file="package.toml.bak"

  # Check if the original file exists
  if [[ -f "$original_file" ]]; then
    print_step "Backing up $original_file to $backup_file..."
    mv "$original_file" "$backup_file" || {
      print_error "Failed to move $original_file to $backup_file."
      return 1
    }
    print_success "Backup complete: $original_file -> $backup_file."
  else
    return 0
  fi
}

# Function to install Yazi themes (low-variant)
install_ya_themes() {
  local failed_themes=()

  # Iterate over themes and install them
  for theme in "${THEMES[@]}"; do
    local theme_name=$(basename "$theme" .git)

    echo "Installing theme: ${theme_name}..."

    if ya pack -a "$theme"; then
      echo "Successfully installed ${theme_name}."
    else
      echo "Failed to install ${theme_name}."
      failed_themes+=("$theme")
    fi
  done

  # Report failed themes at the end
  if [ ${#failed_themes[@]} -gt 0 ]; then
    echo -e "\nThe following themes failed to install:"
    for failed_theme in "${failed_themes[@]}"; do
      echo "  - ${failed_theme}"
    done
    exit 1
  else
    echo -e "\nAll themes installed successfully!"
  fi
}

# Function to install a plugin
install_ya_plugins() {
  local failed_plugins=()
  local dir_flavors="$HOME/.config/yazi/flavors"
  local dir_flavors_bak="$HOME/.config/yazi/flavors_Backup"

  # Check if the directory exists; if not, create it
  if [[ -d "$dir_flavors" ]]; then
    print_step "Backup ${dir_flavors} to ${dir_flavors_bak}"
    mv "${dir_flavors}" "${dir_flavors_bak}" || print_error "Failed to backup flavors directory: $dir"
  fi

  if [[ ! -d "$dir_flavors" ]]; then
    print_step "Create flavors directory ${dir_flavors}"
    mkdir -pv "${dir_flavors}" || print_error "Failed to create flavors directory: $dir"
  fi

  # Iterate over plugins and install them
  for repo in "${PLUGINS[@]}"; do
    print_step "Installing plugin: $repo..."

    # Use `ya pack -a` to install the plugin
    if ya pack -a "$repo"; then
      print_success "Successfully installed $repo."
    else
      print_warn "Error: Failed to install $repo." >&2
      failed_plugins+=("$repo")
    fi
  done

  # Report failed plugins at the end
  if [ ${#failed_plugins[@]} -gt 0 ]; then
    print_warn "\nThe following plugins failed to install:"
    for failed_plugin in "${failed_plugins[@]}"; do
      echo -e "  - $failed_plugin"
    done
    exit 1
  else
    print_success "\nAll plugins installed successfully!"
    exit 0
  fi
}

# Install plugins
install_other_plugins() {

  local dir="$HOME/.config/yazi/plugins"

  # Check if the directory exists; if not, create it
  if [[ ! -d "$dir" ]]; then
    print_step "Creating plugins directory: $dir..."
    mkdir -p "$dir" || print_error "Failed to create plugins directory: $dir"
  fi

  for repo in "${GITEE[@]}"; do
    plugin_name=$(basename "$repo" .git)
    plugin_dir="$dir/$plugin_name"

    print_step "Installing $plugin_name..."
    if git clone "$repo" "$plugin_dir"; then
      [ -f "$plugin_dir/main.lua" ] &&
        mv "$plugin_dir/main.lua" "$plugin_dir/init.lua"
      print_success "$plugin_name successfully installed"
    else
      print_error "Error: Failed to install $plugin_name." >&2
    fi
  done
}

# Main function to install all plugins
install_yazi_plugins() {

  print_step "Start install plugins for Yazi File Manager"
  check_deps
  move_package_toml
  install_other_plugins
  # install_ya_themes
  install_ya_plugins

  print_success "Yazi File manager plugins successfully installed 🎉"
}

# Run the script
install_yazi_plugins
