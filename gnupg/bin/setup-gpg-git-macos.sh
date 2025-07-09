# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#     ::::::::  ::::    ::: :::    ::: :::::::::   ::::::::
#    :+:    :+: :+:+:   :+: :+:    :+: :+:    :+: :+:    :+:
#    +:+        :+:+:+  +:+ +:+    +:+ +:+    +:+ +:+
#    :#:        +#+ +:+ +#+ +#+    +:+ +#++:++#+  :#:
#    +#+  #+#+# +#+  +#+#+# +#+    +#+ +#+        +#+  #+#+#
#    #+#    #+# #+#   #+#+# #+#    #+# #+#        #+#    #+#
#     ########  ###    ####  ########  ###         ########
#              Copyright (c) 2025 zx0r. All rights reserved.

#     Script:        setup-gpg-git-macos.sh
#     Author:        zx0r
#     License:       MIT License
#     Contact Info:  https:#github.com/zx0r
#     Version: 1.0
#     Date: 2025-02-02
#     Description: This script installs and configures GnuPG (GPG) for macOS,
#                  sets up Git to use GPG for signing commits and ensures
#                  security settings are applied.It also auto-detects the user
#                  shell, configures GUI App to use GPG for commits and setup
#                  launch agent for gpg-agent

#                                                   “Stay Hungry, Stay Foolish.”
#                                                          - Steve Jobs  Apple

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Generate ssh key
# ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/github_ed25519 -o -a 100

# ssh-keygen -t ed25519 -C "GitHub" -f "$HOME/.ssh/github/github_ed25519" -o -a 100

# Generating public/private ed25519 key pair.
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:
# Your identification has been saved in /Users/x0r/.ssh/github/github_ed25519
# Your public key has been saved in /Users/x0r/.ssh/github/github_ed25519.pub
# The key fingerprint is:
# SHA256:2ZFiRYvSiNIC16bx3IZ9D7+Srp+0hOui+fIN2IpEH6s GitHub
# The key's randomart image is:
# +--[ED25519 256]--+
# |. ..     .o      |
# | o..o. o o o     |
# |  o*o+o = +      |
# |  .o+ +oo+ .     |
# | . . . .S+.      |
# |. .oo  .  o      |
# | ..oo . o. .     |
# |..oo.o +oo.      |
# |.E+=oo=+=.       |
# +----[SHA256]-----+

# chmod 700 ~/.ssh
# chmod 600 ~/.ssh/github/github_ed25519
# chmod 644 ~/.ssh/config

# Setup a GPG for using SSH

# git config --global gpg.format ssh
# git config --global user.signingkey /home/<user>/.ssh/id_rsa.pub
# git config --global commit.gpgsign true

# ssh-add --apple-use-keychain ~/.ssh/github/github_ed25519  # (macOS)
# ssh-add ~/.ssh/github/github_ed25519  # (Linux/Windows)
# export GPG_TTY=$(tty)
# gpg-connect-agent updatestartuptty /bye

# Add SSH and GPG keys to GitHub via API, follow these steps using GitHub's REST API.
# You need a GitHub personal access token (PAT) with the admin:ssh_key scope.

#  gh ssh-key list
# This API operation needs the "admin:ssh_signing_key" scope.
# To request it, run:  gh auth refresh -h github.com -s admin:ssh_signing_key
# no SSH keys present in the GitHub account

# Run cmd and Copy and Paste code
# gh auth refresh -h github.com -s admin:ssh_signing_key

## ! First copy your one-time code: 73B8-69BF
# Press Enter to open https://github.com/login/device in your browser...
# ✓ Authentication complete.

# 🔹 1. Add SSH Key via GitHub API
# gh gpg-key add [<key-file>] [flags]
# gh-gpg-key-add - Add a GPG key to your GitHub account
#
# gh gpg-key list
# no GPG keys present in the GitHub account

# gh ssh-key add [<key-file>] [flags]
# Options
# -t,  --title <string>
# Title for the new key
# --type <string> (default "authentication")
# Type of the ssh key: {authentication|signing}

# gh ssh-key add
# gh ssh-key delete
# gh ssh-key list

# Enable strict  handling
set -euo pipefail
IFS=$'\n\t'

# Regular Colors
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
CYAN='\033[0;33m'   # CYAN
BLUE='\033[1;34m'   # Blue
CYAN='\033[1;34m'   # Blue
YELLOW='\033[1;33m' # Yellow
PURPLE='\033[0;35m' # Purple
CYAN='\033[1;36m'   # Cyan
# BLACK='\033[0;30m'  # Black
# WHITE='\033[0;37m'  # White
# BWHITE='\033[1;37m' # Bold White
NC='\033[0m' # Text Reset

# Function to print a step message
print_step() {
  local step_name="$1"
  echo -e "${BLUE} ➜ ${step_name}${NC}"
}

# Print colorful messages
print_message() {
  echo -e "${CYAN}💭 $1${NC}"
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

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  Main ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Main function to orchestrate the setup process
main() {

  # First Phase - Setup
  initialize_installation # Start
  install_dependencies    # Install GPG and related tools
  detect_shell            # Detect the user's shell
  create_gpg_dir          # Create $HOME/.gnupg
  generate_gpg_key        # Generate a new GPG key (if needed)
  configure_gnupghome     # Configure gpg.conf gpg-agent.conf

  # Second Phase - Configuration
  configure_vscode_gpg             # Configure VSCode/VSCodium to use GPG for commits
  configure_gui_git_signing        # Configure Git to use GPG for signing commits
  configure_gpg_agent_launch_agent # Set up gpg-agent as a launch agent
  apply_security_settings          # Apply additional security settings
  configure_ssh_signing            # (Option) SSH Key Signing
  # configure_smime_signing        # (Option) S/MIME Signing using smimesign
  configure_git_gpg # Configure Git commit signing

  # Third Phase - Verification
  ptint_hints # Displaying hints
  #export_gpg_key       # Export GPG Key
  verify_setup          # Functional check
  complete_installation # End

  # Reload Shell
  reload_shell # Reload Shell
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━ First Phase - Setup  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# die() {
#   echo "!! $1 " >&2
#   echo "!! -----------------------------" >&2
#   exit 1
# }

# xdg_basher_dir="${XDG_DATA_HOME:-$HOME/.local/share}/basher"

# ## stop if basher is already installed
# [[ -d "$HOME/.basher" ]] && die "basher is already installed on [$HOME/.basher]"
# [[ -d "$xdg_basher_dir" ]] && die "basher is already installed on [$xdg_basher_dir]"

# ## now check what shell is running
# shell_type=$(basename "$SHELL")
# echo ". detected shell type: $shell_type"
# case "$shell_type" in
# bash)
#   startup_type="simple"
#   startup_script="$HOME/.bashrc"
#   ;;
# zsh)
#   startup_type="simple"
#   startup_script="$HOME/.zshrc"
#   ;;
# sh)
#   startup_type="simple"
#   startup_script="$HOME/.profile"
#   ;;
# fish)
#   startup_type="fish"
#   startup_script="$HOME/.config/fish/config.fish"
#   ;;
# *)
#   startup_type="?"
#   startup_script=""
#   ;;
# esac

initialize_installation() {

  print_category "Initialization"
  print_step "Starting installation process..."
}

print_category() {

  local category_name="$1"
  echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━${NC} ${PURPLE}${category_name}${NC} ━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  # step_counter=1 # Reset step counter for each new category
}

is_installed() {

  local package_name=$1
  if command -v "$package_name" &>/dev/null; then
    return 0 # Package is installed
  else
    return 1 # Package is not installed
  fi
}

# Install required packages
install_dependencies() {

  print_step "Installing dependencies..."

  # Check if Homebrew is installed, and install it if not
  if ! command -v brew &>/dev/null; then
    print_step "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    print_success "Homebrew is already installed."
  fi

  # Install gnupg and pinentry-mac if not already installed
  if ! is_installed gpg || ! is_installed pinentry-mac || ! is_installed smimesign; then
    print_step "Installing gnupg and pinentry-mac and smimesign..."
    brew install gnupg pinentry-mac smimesign
  else
    print_step "Update Homebrew and upgrade existing packages"
    brew doctor && brew update && brew upgrade && brew cleanup && brew doctor
  fi
}

# Function to detect the user's shell
detect_shell() {

  shell_name=$(basename "$SHELL")

  # Determine the shell configuration file
  case "$shell_name" in
  bash)
    shell_config="$HOME/.bashrc"
    ;;
  zsh)
    shell_config="$HOME/.zshrc"
    ;;
  fish)
    shell_config="$HOME/.config/fish/config.fish"
    ;;
  *)
    print_warn "Unsupported shell: $shell_name. Please manually configure your shell."
    exit 1
    ;;
  esac

  print_step "Detected shell: ${GREEN}$shell_name${NC}"
  print_step "Using configuration file: ${GREEN}$shell_config${NC}"

  export SHELL_NAME="$shell_name"
  export SHELL_CONFIG="$shell_config"
}

# Configure GPG
create_gpg_dir() {

  local dir="$HOME/.gnupg"

  # Check if the directory exists; if not, create it
  if [[ ! -d "$dir" ]]; then
    print_step "Creating GnuPG directory: ${GREEN}$dir${NC}"
    # Create GPG config directory
    mkdir -p "$dir" || print_error "Failed to create directory: $dir"
    # Set proper permissions
    chmod 700 $HOME/.gnupg
  fi

}

# Function to generate a new GPG key
generate_gpg_key() {

  print_step "Generating a new GPG key..."

  # Collect user information securely
  read -rp "Enter Your Name for GPG key: " NAME
  read -rp "Enter Your Email for GPG key: " EMAIL
  read -rsp "[Secure Mode] Enter passphrase for GPG key: " PASSPHRASE
  echo

  # Ensure clean GPG agent state
  gpgconf --kill gpg-agent
  gpg-agent --daemon

  # Generate key with secure parameters
  # Name-Real: $(git config user.name)
  # Name-Email: $(git config user.email)
  # Name-Comment: GITHUB-KEY

  gpg --batch --generate-key <<EOF
  Key-Type: RSA
  Key-Length: 4096
  Subkey-Type: RSA
  Subkey-Length: 4096
  Name-Real: $NAME
  Name-Email: $EMAIL
  Passphrase: $PASSPHRASE
  Expire-Date: 0
  %commit
EOF

  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)

  print_success "GPG key generated successfully with passphrase protection"
  print_step "GPG key details:"
  print_step "• Name: ${GREEN}$NAME${NC}"
  print_step "• Email: ${GREEN}$EMAIL${NC}"
  print_step "• KEY ID: ${GREEN}${GPG_KEY_ID}{NC}"
}

configure_gnupghome() {

  dir="$HOME/.gnupg"
  download_url="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/15a8954620cad5c9bd066237bf210ba475da3014"

  # Set GPG to use the TTY for passphrase prompts
  export GPG_TTY=$(tty)
  export GPG_DIR="$HOME/.gnupg"

  # Add GPG_TTY to the user's shell configuration file
  if [[ "$SHELL_NAME" == "zsh" ]]; then
    echo 'export GPG_TTY=$(tty)' >>"$SHELL_CONFIG"
    echo "export GNUPGHOME=$GPG_DIR" >>"$SHELL_CONFIG"
  elif [[ "$SHELL_NAME" == "bash" ]]; then
    echo 'export GPG_TTY=$(tty)' >>"$SHELL_CONFIG"
    echo "export GNUPGHOME=$GPG_DIR" >>"$SHELL_CONFIG"
  elif [[ "$SHELL_NAME" == "fish" ]]; then
    echo 'set -gx GPG_TTY $(tty)' >>"$SHELL_CONFIG"
    echo "set -gx GNUPGHOME $GPG_DIR" >>"$SHELL_CONFIG"
  else
    print_warn "Unsupported shell. Please manually add 'export GPG_TTY=\$(tty)' to your shell configuration file."
  fi

  # Configure GPG to use pinentry-mac
  curl -fOsSL --output-dir $dir $download_url/gpg-agent.conf
  curl -fOsSL --output-dir $dir $download_url/gpg.conf

  # To send the keys to the OpenPgp keyserver:
  gpg --keyserver keys.openpgp.org --send-key $(gpg --list-secret-keys --with-keygrip --with-colons | grep '^sec:' | awk -F: '{print $5}')

  # Get current GPG key ID
  KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep sec | head -1 | cut -d'/' -f2 | cut -d' ' -f1)

  # Set it as `default-key` in ~/.gnupg/gpg.conf
  sed -i '' "s/\(default-key \)[^ ]*/\1$KEY_ID/" $HOME/.gnupg/gpg.conf

  print_success "Download files ${BLUE}$dir/gpg-agent.conf and $dir/gpg.conf${NC} completed${NC}"

}

# Function to configure Git signing in GUI applications (e.g., Git Tower, GitHub Desktop)
configure_gui_git_signing() {

  print_step "Configuring Git signing for GUI applications..."

  # Get the GPG key ID
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)

  # Configure Git Tower
  if [[ -d "/Applications/Git Tower.app" ]]; then
    echo "✓ Configuring Git Tower signing..."
    cat >~/.gitconfig.tower <<EOF
[commit]
  gpgsign = true
  signingkey = $GPG_KEY_ID
EOF
    sleep 1
    git config --global include.path ~/.gitconfig.tower
  fi

  # Configure GitHub Desktop
  if [[ -d "/Applications/GitHub Desktop.app" ]]; then
    print_success "Configuring GitHub Desktop signing..."
    cat >~/.gitconfig.github <<EOF
[commit]
  gpgsign = true
  signingkey = $GPG_KEY_ID
EOF
    sleep 1
    git config --global include.path ~/.gitconfig.github
  fi

  print_success "Git signing configured for GUI applications"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Second Phase - Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━

configure_vscode_gpg() {

  local extensions=(
    "wdhongtw.gpg-indicator"
    "jheilingbrunner.vscode-gnupg-tool"
  )

  local settings='{"git.enableCommitSigning": true}'

  if command -v code &>/dev/null; then
    print_step "Configuring VSCode for GPG commit signing..."
    for ext in "${extensions[@]}"; do
      code --force --install-extension "$ext"
    done
    # code --wait --reuse-window --settings-json "$settings"
    print_step "VSCode GPG signing configuration complete"

  elif command -v codium &>/dev/null; then
    print_step "Configuring VSCodium for GPG commit signing..."
    for ext in "${extensions[@]}"; do
      codium --force --install-extension "$ext"
    done
    # codium --wait --reuse-window --settings-json "$settings"
    print_success "VSCodium GPG signing configuration complete"

  else
    print_warn "✗ No compatible editor found (VSCode/VSCodium)"
    return 1
  fi
}

configure_gpg_agent_launch_agent() {
  echo "Setting up gpg-agent as a launch agent..."

  # Define paths with more descriptive names
  readonly LOCAL_BIN_DIR="$HOME/.local/bin"
  readonly GPG_START_SCRIPT="$LOCAL_BIN_DIR/start-gpg-agent.sh"
  readonly LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
  readonly GPG_AGENT_PLIST="$LAUNCH_AGENTS_DIR/org.gnupg.gpg-agent.plist"

  # Source URLs
  readonly PLIST_URL="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/6673f8ee76898aa8f8f59cfdbfb14728481b1276/org.gnupg.gpg-agent.plist"
  readonly SCRIPT_URL="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/6673f8ee76898aa8f8f59cfdbfb14728481b1276/startup-gpg-agent.sh"

  # Create required directories
  for dir in "$LOCAL_BIN_DIR" "$LAUNCH_AGENTS_DIR"; do
    if [[ ! -d "$dir" ]]; then
      mkdir -p "$dir" || {
        echo "Failed to create directory: $dir"
        return 1
      }
      echo "Created directory: $dir"
    fi
  done

  # Download files with error checking
  if ! curl -fsSL "$PLIST_URL" -o "$GPG_AGENT_PLIST"; then
    print_warn "Failed to download plist file"
    return 1
  fi

  if ! curl -fsSL "$SCRIPT_URL" -o "$GPG_START_SCRIPT"; then
    print_warn "Failed to download start script"
    return 1
  fi

  # Set correct permissions
  chmod +x "$GPG_START_SCRIPT"

  # Load the launch agent
  launchctl load -w "$GPG_AGENT_PLIST"

  print_success "GPG agent launch agent setup complete"
  print_step "Installed files:"
  print_step "• Launch Agent: ${GREEN}$GPG_AGENT_PLIST${NC}"
  print_step "• Start Script: ${GREEN}$GPG_START_SCRIPT${NC}"
}

# Function to apply additional security settings
apply_security_settings() {
  echo "Applying additional security settings..."

  # Start GPG agent if not running
  if ! gpg-connect-agent /bye >/dev/null 2>&1; then
    echo "Starting GPG agent..."
    gpg-agent --daemon
  fi

  # Set recommended security configurations
  gpg-connect-agent "scd serialno" /bye >/dev/null 2>&1
  gpg-connect-agent "learn --force" /bye >/dev/null 2>&1

  print_success "Security settings applied successfully."
}

configure_ssh_signing() {
  # Define constants
  readonly SSH_DIR="$HOME/.ssh"
  readonly SSH_KEY="$SSH_DIR/id_ed25519"
  GPG_DIR="$HOME/.gnupg"
  SSHCONTROL="$GPG_DIR/sshcontrol"
  KEYGRIPS="$(gpg --list-keys --with-keygrip | awk '/^sub/{p=1;next} /Keygrip/{if(p){print $3;p=0}}')"

  # for Fish Shell
  FISH_PATH="$HOME/.config/fish/functions"
  SSH_AGENT_FISH_URL="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/d59f1f8ca738241c6cb34da8055f417cee73dd86/ssh_agent.fish"
  GPG_SSH_FISH_URL="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/d59f1f8ca738241c6cb34da8055f417cee73dd86/gpg_ssh_agent.fish"
  SSHCONTROL_URL="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/deaa0d4c123baad306c0b3e8e78289e985587cd6/sshcontrol"
  SSH_CONFIG="https://gist.githubusercontent.com/zx0r/843298b67cd91a0835dcf36aada529d5/raw/5f946ee0bc44f0fe122f19e4461ef07a8e24e3cc/config"

  # Create SSH directory with proper permissions
  if [[ ! -d "$SSH_DIR" ]]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
  fi

  # Generate SSH key if needed
  if [[ ! -f "$SSH_KEY" ]]; then
    ssh-keygen -t ed25519 -C "git-signing-key" -f "$SSH_KEY" -N ""
    chmod 600 "$SSH_KEY"
    chmod 644 "${SSH_KEY}.pub"
  fi

  # Generate SSH key if needed
  if [[ ! -f "$SSH_DIR/config" ]]; then
    curl -fsSL "$SSH_CONFIG" -o "$SSH_DIR/config" || print_warn "Failed to download $SSH_DIR/config"
    chmod 600 "$SSH_DIR/config"
  else
    mv "$SSH_DIR/config" "$SSH_DIR/config.bak"
  fi

  # Add SSH key with keychain integration
  ssh-add --apple-use-keychain $SSH_DIR/id_ed25519

  # Configure Git signing
  git config --global gpg.format ssh
  git config --global user.signingkey "$(cat ${SSH_KEY}.pub)"
  git config --global commit.gpgsign true

  # Setup GPG directory and sshcontrol
  mkdir -p "$GPG_DIR"
  chmod 700 "$GPG_DIR"

  # Extract and add keygrips
  curl -fsSL "$SSHCONTROL_URL" -o "$GPG_DIR/sshcontrol" || print_warn "Failed to download $GPG_DIR/sshcontrol"

  # Add keygrips to sshcontrol
  if [[ -n "$KEYGRIPS" ]]; then
    echo "$KEYGRIPS" >>"$SSHCONTROL"
    chmod 600 "$SSHCONTROL"
    print_success "SSH control configured with keygrips"
  fi

  # Download ssh_agent.fish
  if [[ "$SHELL_NAME" == "fish" ]]; then
    curl -fsSL "$SSH_AGENT_FISH_URL" -o "$FISH_PATH/ssh_agent.fish" || print_warn "Failed to download $FISH_PATH/ssh_agent.fish"
    curl -fsSL "$GPG_SSH_FISH_URL" -o "$FISH_PATH/gpg_ssh_agent.fish" || print_warn "Failed to download $FISH_PATH/gpg_ssh_agent.fish"
    print_step "Download competed: ${GREEN}$FISH_PATH/ssh_agent.fish and $FISH_PATH/gpg_ssh_agent.fish${NC}"
  fi

  print_success "SSH signing setup complete!"
  print_step "Public key: ${BLUE}$(cat ${SSH_KEY}.pub)${NC}"
}

# S/MIME Signing using smimesign
configure_smime_signing() {

  # Configure Git to use smimesign
  git config --global gpg.x509.program smimesign
  git config --global gpg.format x509
  git config --global commit.gpgsign true

  print_success "S/MIME Signing using smimesign configured"
}

configure_git_gpg() {

  # Get the GPG key ID
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)
  # GPG_KEY_ID=$(gpg --list-secret-keys --with-keygrip --with-colons | grep '^sec:' | awk -F: '{print $5}')

  # Check and clean existing GPG settings
  if git config --list --show-origin | grep -q "commit.gpgsign"; then
    git config --global --unset commit.gpgsign
  fi

  # Configure Git with new GPG settings
  git config --global gpg.program $(which gpg)
  git config --global user.signingkey "$GPG_KEY_ID"
  sleep 1
  git config --global log.showSignature "true"
  git config --global commit.gpgsign "true"
  git config --global tag.gpgSign "true"

  # Display success and next steps
  print_success "Git configured to use GPG key: $GPG_KEY_ID"

  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "   ${GREEN}            Your GPG public key for GitHub:                       ${NC}"
  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

  # Add to github repository (var 1)
  # gpg --armor --export $(gpg --list-secret-keys --with-keygrip --with-colons | grep '^sec:' | awk -F: '{print $5}')

  # Add to github repository(var 2)
  gpg --armor --export "$GPG_KEY_ID"
}

ptint_hints() {

  # Print clear instructions with colors
  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "   ${GREEN}               Next Steps for GPG Setup                           ${NC}"
  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

  echo -e "${YELLOW}Step 1. 👆 Copy your GPG key 👆${NC}"
  echo -e "${YELLOW}• Include both BEGIN and END lines${NC}"
  echo -e "${YELLOW}• Ensure no extra spaces are copied${NC}"

  echo -e "${YELLOW}Step 2. Add key to GitHub:${NC}"
  print_step "${GREEN}https://github.com/settings/gpg/new${NC}"

  echo -e "${YELLOW}Step 3. Verify your signed commits:${NC}"
  print_step "${GREEN}'git log --show-signature'${NC}"

  echo -e "${YELLOW}Step 4. Use commit signature verification:${NC}"
  print_step "${GREEN}'git commit -S -m "YOUR_COMMIT_MESSAGE"'${NC}"

  echo -e "${YELLOW}Step 5. Learn more about commit signing:${NC}"
  print_step "${GREEN}https://docs.github.com/authentication/managing-commit-signature-verification${NC}"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Third Phase - Verification ━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Export the GPG Key Materials
export_gpg_key() {

  # Get the GPG key ID
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)

  # Set secure export paths
  EXPORT_DIR="$HOME/.gnupg/backup"
  mkdir -p "$EXPORT_DIR"

  # Export both public and private keys with armor
  gpg --armor --export "$GPG_KEY_ID" >"$EXPORT_DIR/gpg_public_${GPG_KEY_ID}.asc"
  gpg --armor --export-secret-key "$GPG_KEY_ID" >"$EXPORT_DIR/gpg_private_${GPG_KEY_ID}.asc"

  print_success "GPG keys exported successfully:"
  print_step "• Public key: ${GREEN}$EXPORT_DIR/gpg_public_${GPG_KEY_ID}.asc${NC}"
  print_step "• Private key: ${GREEN}$EXPORT_DIR/gpg_private_${GPG_KEY_ID}.asc${NC}"

  git config --list --show-origin | grep user.signingkey

  # gpg --list-secret-keys --keyid-format=long

}

verify_setup() {

  # Print clear instructions with colors
  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "   ${GREEN}             🔍 Running system verification...                    ${NC}"
  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

  print_step "\n📌 GPG Configuration\n"
  gpg --list-secret-keys --keyid-format=long
  gpg-connect-agent --quiet /bye
  print_success "GPG Agent Status: ✔️"

  echo "\n🔑 SSH Configuration\n"
  ssh-add -l
  print_step "• SSH_AUTH_SOCK: ${GREEN}$SSH_AUTH_SOCK${NC}"
  print_success "• SSH Agent Status: ✔️"

  print_step "\n✍️ Git Signing Setp\n"
  git config --global --list | grep -E 'gpg|signing'
  git verify-commit HEAD 2>/dev/null || print_step "No signed commits yet"

  print_step "\n🔐 Environment Variables"
  print_step "• GPG_TTY: ${GREEN}$GPG_TTY${NC}"
  print_step "• GNUPGHOME: ${GREEN}$GNUPGHOME${NC}"

  print_step "\n✨ Running signing test...\n"
  echo "Final Check" | gpg --clearsign && print_success "GPG signing: ✔️"

  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "   ${GREEN}   🎉 Verification complete.Happy Secure Committing 🎉            ${NC}"
  echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

}

reload_shell() {

  if [[ -f "$SHELL_CONFIG" ]]; then
    # print_step "Reloading shell configuration..."
    source "$SHELL_CONFIG"
  else
    print_warn "Error: Shell configuration file not found at $SHELL_CONFIG" >&2
    exit 1
  fi
}

complete_installation() {

  print_category "Completion"
  print_success "GnuPG and Git configuration completed successfully 🎉"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ End ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Execute main function only if script is run directly
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main
