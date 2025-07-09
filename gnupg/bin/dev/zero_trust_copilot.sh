#!/usr/bin/env bash

set -eo pipefail
IFS=$'\n\t'

# https://git-scm.com/docs/git-config
# Enforcing Touch ID for sudo via pam_tid.so.
## Backup original PAM config
# sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.bak
# Add pam_tid.so to the sudo auth stack
#sudo sed -i '' '1a auth       sufficient     pam_tid.so' /etc/pam.d/sudo

# Isolating dev environments with macOS Sandboxing profiles.
# https://github.com/northpolesec/santa
# https://github.com/google/santa?tab=readme-ov-file

# 2. Dev Environment Sandboxing

# Tools:

# sandbox-exec: Restrict processes via profiles (.sb).
# Santa: Process/file access allow-listing (ML-based).
# Example Profile (~/dev.sb):

# conf
# Copy
# (version 1)
# (deny default)
# (allow file-read* file-write*
#     (subpath "/Users/$(whoami)/Projects")
# )
# (allow process-exec
#     (literal "/usr/bin/git")
# )
# (deny network-outbound)
# Usage:

# bash
# Copy
# # Run isolated Python env
# sandbox-exec -f ~/dev.sb python3 app.py

# # Santa (install via Homebrew):
# santactl rule --whitelist --path /usr/local/bin/docker
# Hardening Tips:

# Network Isolation: Block non-essential traffic with pfctl/Little Snitch.
# Filesystem: Use chroot or mount -t apfs -o nobrowse for temp workspaces.
# Security Audit

# bash
# Copy
# # Trace sandboxed app syscalls:
# dtrace -n 'syscall:::entry /pid == $target/ { @[probefunc] = count(); }' -p $(pgrep -f "python3 app.py")

# # Santa logs:
# log stream --predicate 'subsystem == "com.google.santa"'
# follow-up scope

# Custom Certificate Authorities with Keychain ACLs.
# Bastion host SSH tunneling with Touch ID enforcement.

# Constants
readonly SSH_DIR="$HOME/.ssh"
readonly GPG_DIR="$HOME/.gnupg"
# readonly SECURE_DIR="$HOME/.secure"
readonly CONFIG_DIR="$HOME/.config"
readonly GIT_DIR="$HOME.config/git"
readonly LOG_FILE="$GPG_DIR/audit.log"
exec > >(tee -a "$LOG_FILE") 2>&1

PASSPHRASE_LABEL="Passphrase"
PASSPHRASE=$(openssl rand -base64 32)
SSH_KEY_NAME="$(git config user.name)@github"
SSH_KNOWN_HOSTS_FILE="$SSH_DIR/known_hosts_github"
SHELL_CONFIG=""
KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '/^sec/{print $5}' | head -1)
KEY_ID_PUBLIC=$(gpg --list-keys --with-colons | awk -F: '/^pub:/ {print $5; exit}')

SSHCONTROL="$GPG_DIR/sshcontrol"
KEYGRIPS="$(gpg --list-keys --with-keygrip | awk '/^sub/{p=1;next} /Keygrip/{if(p){print $3;p=0}}')"

# Get current GPG key ID
#KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep sec | head -1 | cut -d'/' -f2 | cut -d' ' -f1)
KEY_ID=$(gpg --list-keys --with-colons | awk -F: '/^pub/{print $5}')

# Notification functions
print_success() { echo -e "\e[32m[Success]\e[0m $1"; }
print_warn() { echo -e "\e[34m[Warn]\e[0m $1"; }
print_info() { echo -e "\e[34m[Info]\e[0m $1"; }
print_error() {
  printf "\e[31m[Error] %s\e[0m\n" "$1" >&2
  exit 1
}

# pause() {
#   read -rsp "$(echo -e "按 $green Enter 回车键 $none 继续....或按 $red Ctrl + C $none 取消.")" -d $'\n'
#   echo
# }

[[ $(uname -s) != Darwin ]] || print_error "This operating system is not supported."

# Determine the shell being used and the location of the configuration file
check_shell() {
  case "$SHELL" in
  */bash)
    SHELL_DIR="$HOME/.config/bash"
    SHELL_CONFIG="$HOME/.bashrc"
    ;;
  */zsh)
    SHELL_DIR="$HOME/.config/zsh"
    SHELL_CONFIG="$HOME/.zshrc"
    ;;
  */fish)
    SHELL_DIR="$HOME/.config/fish"
    SHELL_CONFIG="$HOME/.config/fish/config.fish"
    ;;
  *)
    print_error "Unsupported shell: $SHELL"
    ;;
  esac
}

# Check and install dependencies using Homebrew
init() {
  # Install Homebrew and cli-tools if you haven't already
  # [[ -x `which wget` ]] || brew install wget
  command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  xcode-select -p >/dev/null 2>&1 || xcode-select --install >/dev/null 2>&1 || true

  local dependencies=("gh" "gnupg" "gpg-suite" "gpg-tui" "openssh" "openssl@3" "smimesign" "keepassxc" "pass")
  for dep in "${dependencies[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      print_info "Installing $dep with brew..."
      brew install "$dep" --force || print_error "Failed to install $dep"
    fi
  done
}

# if [[ -z "${CI}" ]]; then
#   sudo -v # Ask for the administrator password upfront
#   # Keep-alive: update existing `sudo` time stamp until script has finished
#   while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
# fi

# Ask for the administrator password upfront.
# sudo -v
# # Keep-alive: update existing `sudo` time stamp until the script has finished.
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
# # Check for Homebrew,
# # Install if we don't have it
# if test ! $(which brew); then
#   echo "Installing homebrew..."
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# fi
# # Make sure we’re using the latest Homebrew.
# brew update
# # Upgrade any already-installed formulae.
# brew upgrade --all

# Create base directories if they don't exist with correct permissions
check_base_dirs() {
  local base_dirs=("$SSH_DIR" "$GPG_DIR" "$SHELL_DIR")
  for dir in "${base_dirs[@]}"; do
    [ -d "$dir" ] && mv "$dir" "$dir.backup_$(date +%Y.%m.%d-%H:%M)" && print_info "Backed up: $dir to $dir.backup"
  done
}

# Download Zero-Trust Security Paradigm configurations
# download_configs() {
#   local repo="zx0r/Zero-Trust-Security-macOS"
#   local temp_dir
#   temp_dir=$(mktemp -d)

#   # Clone the repository and move config directories
#   gh repo clone "$repo" "$temp_dir"
#   mv "$temp_dir/.secure/.ssh" "$SSH_DIR" && chmod 700 "$SSH_DIR"
#   mv "$temp_dir/.secure/.gnupg" "$GPG_DIR" && chmod 700 "$GPG_DIR"
#   mv "$temp_dir/.config/git" "$GIT_DIR" && chmod 700 "$GIT_DIR"
#   mv "$temp_dir/.config/shell" "$SHELL_DIR" && chmod 700 "$SHELL_DIR"
#   # mv "$temp_dir/.secure" "$SECURE_DIR" && chmod 700 "$SECURE_DIR"

#   # Clean up temporary directory
#   rm -rf "$temp_dir"
# }

download_configs() {
  local repo="zx0r/Zero-Trust-Security-macOS"
  local temp_dir && temp_dir=$(mktemp -d) || return 1
  local -A dir_map=(
    [".secure/.ssh"]="$SSH_DIR"
    [".secure/.gnupg"]="$GPG_DIR"
    [".config/git"]="$GIT_DIR"
    [".config/shell"]="$SHELL_DIR"
  )

  if gh repo clone "$repo" "$temp_dir"; then

    for src in "${!dir_map[@]}"; do
      local target="${dir_map[$src]}"
      [[ -d "$temp_dir/$src" ]] || continue
      mv -f "$temp_dir/$src" "$target" && chmod 700 "$target"
    done
  else
    rm -rf "$temp_dir"
    print_error "Clone failed: %s\n" "$repo" >&2
  fi
}

# Generate a random passphrase and store it in macOS Keychain
generate_passphrase() {
  echo "$PASSPHRASE" >"$GPG_DIR/passphrase.txt"
  if security add-generic-password -a "$USER" -s "$PASSPHRASE_LABEL" -w "$PASSPHRASE" \
    -T "$(which gpg)" -T "$(which ssh)" -T "$(which gpg-agent)" \
    -T "$(which ssh-agent)" -T "$(which pass)"; then
    print_success "Passphrase generated and stored in macOS Keychain."
  else
    print_error "Failed to add passphrase to macOS Keychain."
  fi
}

# Retrieve passphrase from macOS Keychain
fetch_passphrase() {
  PASSPHRASE=$(security find-generic-password -a "$USER" -s "$PASSPHRASE_LABEL" -w) || print_error "No Passphrase found in macOS Keychain"
}

# Check .gitconfig parameters for Signing commit
check_git_config_settings() {
  git config --list --show-origin | grep -E "user.name|user.email|user.signingkey|commit.gpgsign|tag.gpgsign|log.showsignature|gpg.program|gpg.format" ||
    print_error "Configure your ~/.gitconfig > user.name|user.email|user.signingkey|commit.gpgsign|tag.gpgsign|log.showsignature|gpg.program|gpg.format"
}

# Generate a new GPG key using the passphrase
generate_and_configure_gpg() {
  # USER_NAME="$(git config user.name)"
  # USER_EMAIL="$(git config user.email)"
  # COMMENT="GITHUB-KEY"
  # KEY_EXPIRY="2y"
  # Name-Real: $USER_NAME
  # Name-Email: $USER_EMAIL
  # Passphrase: $USER_PASS
  # Expire-Date: $KEY_EXPIRY

  gpg --batch --pinentry-mode loopback --generate-key <<EOF
  %echo Generating a GPG key
  Key-Type: eddsa
  Key-Curve: ed25519
  Key-Usage: sign
  Subkey-Type: ecdh
  Subkey-Curve: cv25519
  Subkey-Usage: encrypt
  Name-Real: $(git config user.name)
  Name-Email: $(git config user.email)
  Passphrase: $PASSPHRASE
  Name-Comment: GITHUB-KEY
  Expire-Date: 2y
  %commit
EOF
  # Add GPG key to macOS Keychain
  #security add-generic-password -a "$USER" -s "GPG-Key" -w "$(gpg --armor --export-secret-keys "$KEY_ID")"
  secure_keychain_store "GPG-Key" "$(gpg --armor --export-secret-keys "$KEY_ID")"
  print_success "GPG key generated and stored in macOS Keychain."

  #Send gpg key to_keyserver
  gpg --keyserver hkps://keys.openpgp.org --send-keys "$KEY_ID"
  gpg --keyserver hkps://keys.openpgp.org --check-sigs "$KEY_ID"
  print_success "GPG key sent to keyserver and signatures checked."

  # Set it as `default-key` in ~/.gnupg/gpg.conf
  sed -i '' "s/\(default-key \)[^ ]*/\1$KEY_ID/" "$HOME/.gnupg/gpg.conf"

  # Configure Git with new GPG settings
  git config --global user.signingkey "$KEY_ID"

  # Export the GPG Key Materials
  gpg --armor --export "$KEY_ID" >"$GPG_DIR/$KEY_ID.pub"
  gpg --armor --export-secret-keys "$KEY_ID" >"$GPG_DIR/$KEY_ID.sec"

  # Generate revocation certificate
  gpg --output "$GPG_DIR/$KEY_ID-revoke.asc" --gen-revoke "$KEY_ID"
  #security add-generic-password -a "$KEY_ID-revoke" -s "Revocation Certificate" -w "$(cat "$GPG_DIR"/"${KEY_ID}"-revoke.asc)"
  secure_keychain_store "$KEY_ID-revoke" "$(cat "$GPG_DIR"/"$KEY_ID"-revoke.asc)"
  print_success "Revocation certificate generated and stored in macOS Keychain."
}

# Generate a new SSH key using the Ed25519 algorithm and the passphrase
generate_and_configure_ssh() {
  [[ -f "$SSH_DIR/$SSH_KEY_NAME" ]] || SSH_KEY_NAME="$(git config user.name)-$(openssl rand -hex 1)@github"
  ssh-keygen -t ed25519 -a 100 -o -f "$SSH_DIR/$SSH_KEY_NAME" -N "$PASSPHRASE"
  # ssh-keygen -t ed25519 -a 100 -o -f ~/.ssh/id_ed25519-$(git config user.name)@github -C $(git config user.email)
  [[ ! -f "$SSH_DIR/$SSH_KEY_NAME" ]] || print_error "SSH key not found at $SSH_DIR"

  # Add GitHub keys to the known_hosts_github file
  touch "$SSH_KNOWN_HOSTS_FILE" && chmod 644 "$SSH_KNOWN_HOSTS_FILE"
  # Scan GitHub servers and append to known_hosts_github
  # ssh-keyscan github.com >> ~/.ssh/known_hosts_github
  # ssh-keyscan gist.github.com >> ~/.ssh/known_hosts_github
  # ssh-keyscan -p 443 ssh.github.com >> ~/.ssh/known_hosts_github
  # ssh-keyscan "github.com" "gist.github.com" "[ssh.github.com]:443" >>"$SSH_KNOWN_HOSTS_FILE"
  print_success "GitHub SSH keys added to $SSH_KNOWN_HOSTS_FILE"

  # security add-generic-password -a "$USER" -s "$SSH_KEY_NAME" -w "$(cat "$SSH_DIR/$SSH_KEY_NAME")"
  secure_keychain_store "$SSH_KEY_NAME" "$(cat "$SSH_DIR/$SSH_KEY_NAME")"
  if ssh-add -l | grep -q "$(ssh-keygen -lf "$SSH_DIR/$SSH_KEY_NAME" | awk '{print $2}')"; then
    print_success "SSH key: $SSH_DIR/$SSH_KEY_NAME stored in macOS Keychain."
  else
    print_error "Failed to add SSH key to macOS Keychain."
  fi

  # Add keygrips to sshcontrol
  if [[ -n "$KEYGRIPS" ]]; then
    echo "$KEYGRIPS" >>"$SSHCONTROL"
    chmod 600 "$SSHCONTROL"
    print_success "SSH control configured with keygrips"
  fi
}

# Set file permissions
set_file_permissions() {
  declare -A file_patterns=(
    ["$GPG_DIR/*.gpg"]="644"
    ["$GPG_DIR/*.conf"]="644"
    ["$GPG_DIR/private-keys-v1.d/*"]="600"
    ["$SSH_DIR/config"]="644"
    ["$SSH_DIR/$SSH_KEY_NAME"]="600"     # ssh secret key
    ["$SSH_DIR/$SSH_KEY_NAME.pub"]="644" # ssh public key
    ["$SSH_KNOWN_HOSTS_FILE"]="644"
  )

  # chown vivek:vivek ~/.ssh/config
  # chmod 0600 ~/.ssh/config

  for pattern in "${!file_patterns[@]}"; do
    chmod "${file_patterns[$pattern]}" "$pattern"
    if chmod "${file_patterns[$pattern]}" "$pattern"; then
      print_info "Set permissions ${file_patterns[$pattern]} for files matching pattern: $pattern"
    else
      print_error "Failed to set permissions for files matching pattern: $pattern"
    fi
  done
}

# Check if GitHub authentication is already configured
check_github_auth() {
  #Verify GitHub account status
  # gh auth status || gh auth login --hostname github.com

  gh auth status >/dev/null 2>&1 && return 0

  print_warn "\nGitHub CLI is not authenticated."
  print_info "Select authentication method:"
  echo "1) Browser (Recommended)"
  echo "2) Token"
  read -rp "Enter choice (1 or 2): " auth_choice

  case $auth_choice in
  1)
    gh auth login --web -s admin:gpg_key,admin:ssh_key,admin:ssh_signing_key -h github.com -w
    ;;
  2)
    print_info "Create a Personal Access Token with required scopes:"
    echo "🔗 https://github.com/settings/tokens/new?scopes=admin:gpg_key,admin:ssh_key,admin:ssh_signing_key,gist&description=macOS-Zero-Trust-Auth"
    read -rp "Paste token: " gh_token
    echo "$gh_token" | gh auth login --with-token >/dev/null
    ;;
  *)
    print_error "Invalid choice. Skipping authentication."
    ;;
  esac

  if gh auth status >/dev/null 2>&1; then
    print_success "✓ GitHub authentication successful"
  else
    print_error "✗ Authentication failed. Continuing without authentication"
  fi
}

# Add SSH/GPG keys to GitHub using gh CLI
uploading_keys_to_github() {
  if check_github_auth; then
    gh ssh-key add "$SSH_DIR/$SSH_KEY_NAME.pub" --title "SSH-Auth-$(hostname)" || print_error "SSH key upload failed" # Deploy SSH key
    gh gpg-key add "$GPG_DIR/$KEY_ID.pub" --title "GPG-Auth-$(hostname)" || print_error "GPG key upload failed"       # Deploy GPG key
    print_success "✓ Gpg and SSH keys uploading to GitHub successfully"
  fi
}

check_crypto_config() {
  print_info "=== Cryptographic Verification ==="
  ssh -T -o StrictHostKeyChecking=yes git@github.com 2>&1 | grep -q success || print_error "✗ SSH verification failed"
  gpg --list-secret-keys --with-keygrip
  gh gpg-key list | grep -q "$KEY_ID" || print_error "✗ GPG key not found on GitHub"
}

security_audit() {
  print_info "=== Security Audit Summary ==="

  security dump-keychain | grep -q "secure_env" && print_success "✓ Secure environment detected"

  ssh-add -l
  spctl --status
  ls -ld "$SSH_DIR" "$GPG_DIR"

  # Verify key trust status and trust model
  gpg --check-trustdb
  gpg --list-keys --with-colons | awk -F: -v key="$KEY_ID_PUBLIC" '$5 == key {print "Key:", key, "Trust Level:", $2}'
  gpg --list-keys | grep -q 'ultimate' && print_success "✓ Ultimate trust level detected"

  # Verify SSH security & GPG compliance
  ssh -Q key | grep -q ed25519 && print_success "✓ SSH supports Ed25519"
  gpg --version | grep -Eq "EdDSA|X25519" && print_success "✓ GPG supports modern cryptography"

  # Check hardware security & trust model
  system_profiler SPSecureElementDataType
  gpgconf --list-options gpg | grep trust-model
}

# Main script execution
main() {
  print_info "Starting Zero-Trust infrastructure setup..."
  check_dependencies
  check_base_dirs
  configure_gpg_ssh_settings
  check_git_config_settings
  generate_passphrase
  generate_and_configure_gpg
  generate_and_configure_ssh
  set_file_permissions
  uploading_keys_to_github
  check_crypto_config
  security_audit
  print_success "Zero-Trust infrastructure setup complete."
}

main "$@"
