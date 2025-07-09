#!/usr/bin/env bash

# Ensure strict error handling and best practices
set -euo pipefail # Exit on error, undefined variables, and failed pipes
IFS=$'\n\t'       # Ensure spaces, newlines, and tabs are handled properly

# GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
# GPGSSH_SIGNING_KEY # Specifies an SSH key used for signing commitsx
# GPGSSH_KEY_PRIMARY
# GPGSSH_KEY_SECONDARY
# GPGSSH_KEY_UNTRUSTED
# GPGSSH_KEY_WITH_PASSPHRASE

# SSH key management
SSH_HOME="$HOME/.ssh"              # Path to the user's SSH home directory (default: ~/.ssh)
SSH_CONFIG_FILE="$SSH_HOME/config" # Path to the SSH client configuration file

# GPG key management
GNUPGHOME="$HOME/.gnupg"                     # Path to the user's GPG home directory (default: ~/.gnupg).
GPG_CONF="$GNUPGHOME/gpg.conf"               # Path to the gpg.conf configuration file.
GPG_AGENT_CONFIG="$GNUPGHOME/gpg-agent.conf" # Path to the gpg-agent.conf file.
GPGKEYSERVER="hkps://keys.openpgp.org"       # Defines the default keyserver (e.g., hkps://keys.openpgp.org).
REVOCATION_CERT="$GNUPGHOME/revocation.asc"
GPG_SECURITY_KEYCHAIN="$HOME/Library/Keychains" # Defines the keychain for storing passphrases (on macOS)

# Declare global variables to store the paths
gpg_bin_path=""
gpg_agent_bin_path=""

# --- Utility Functions ---
print_success() { echo -e "\e[32m[SUCCESS]\e[0m $1"; }
print_error() { echo -e "\e[31m[ERROR]\e[0m $1" >&2; }
print_warn() { echo -e "\e[34m[INFO]\e[0m $1"; }
print_info() { echo -e "\e[34m[INFO]\e[0m $1"; }

# Setup GPG and SSH keys, integrating with macOS Keychain, and configuring GitHub
# This way, steps are grouped logically, eliminating redundant checks and ensuring dependencies are handled.
# Also, some steps might be merged, like generating the keys and immediately handling their addition to agents or configuration.

# 1. Initial Setup & Verification

# # Create directories if needed (e.g., ~/.gnupg, ~/.ssh)
# mkdir -p ~/.gnupg ~/.ssh
# chmod 700 ~/.gnupg ~/.ssh

# # Check for existing keys
# [ -f ~/.ssh/id_ed25519 ] && echo "SSH key exists" || echo "No SSH key"
# gpg --list-secret-keys | grep -q 'SECRET KEY' || echo "No GPG key"

# 2. Passphrase Management

# # Generate passphrase only if needed (16+ chars, use pwgen if available)
# passphrase=$(openssl rand -base64 30 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-=')

# # Add to system keychain (macOS example)
# security add-generic-password -a "${USER}" -s "gpg-passphrase" -w "${passphrase}"
# security add-generic-password -a "${USER}" -s "ssh-passphrase" -w "${passphrase}"

# 3. Key Generation

# # Generate GPG key non-interactively (customize as needed)
# gpg --batch --passphrase "${passphrase}" --quick-generate-key "User Name <email@example.com>" ed25519 cert sign 2y

# # Generate SSH key
# ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "${passphrase}"

# 4. Agent Configuration

# # GPG Agent
# echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf  # macOS example
# gpgconf --launch gpg-agent

# # SSH Agent
# eval "$(ssh-agent -s)"
# echo "AddKeysToAgent yes" >> ~/.ssh/config

# 5. Key Activation

# # Add SSH key (uses keychain-stored passphrase)
# ssh-add --apple-use-keychain ~/.ssh/id_ed25519  # macOS keychain integration

# # Reload GPG agent
# echo RELOADAGENT | gpg-connect-agent
# 6. GitHub Integration

# # Add SSH key to GitHub (gh CLI example)
# gh ssh-key add ~/.ssh/id_ed25519.pub --title "Main Key"

# # Add GPG key to GitHub
# gpg --armor --export | gh gpg-key add

# 7. Verification & Testing

# # Verify agent status
# ssh-add -l
# gpg --list-secret-keys

# # Test SSH connection
# ssh -T git@github.com

# # Test GPG signing
# echo "test" | gpg --clearsign

# # Verify Git config
# git config --global user.signingkey $(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d'/' -f2 | cut -d' ' -f1)
# git config --global commit.gpgsign true

# 8. Security Hardening

# # Set proper permissions
# chmod 600 ~/.ssh/*
# chmod 600 ~/.gnupg/*

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

# Function to check and install missing dependencies using brew
check_and_install_dependencies() {
  local dependencies=("gh" "gnupg" "gpg-suite" "pinentry-mac" "gpg-tui" "keychain" "keepassxc" "openssl@3" "smimesign" "pass")
  for dep in "${dependencies[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      print_info "Installing $dep with brew..."
      brew install "$dep" || {
        print_error "Failed to install $dep"
        return 1
      }
    else
      echo "$dep is already installed."
    fi
  done
}

# Function to ensure required directories exist with correct permissions
check_required_dirs() {
  local required_dirs=("$SSH_HOME" "$GNUPGHOME")
  for dir in "${required_dirs[@]}"; do
    if [ ! -d "$dir" ]; then
      mkdir -p "$dir" && chmod 0700 "$dir"
      echo "Created directory: $dir with secure permissions."
    fi
  done
}

# Function to generate a unique name (used for both SSH and GPG keys)
generate_unique_name() {
  echo "id_ed25519_$(openssl rand -hex 4)"
}

# Function to generate a unique 32-byte passphrase encoded in Base64
generate_unique_passphrase() {
  openssl rand -base64 32
}

# Function to check if required executables are in the system PATH
check_required_executables() {
  local required_bins=("gpg" "gpg-agent" "gpgconf" "pass")
  local bin_path

  for bin in "${required_bins[@]}"; do
    bin_path=$(which "$bin")
    if [[ -z "$bin_path" ]]; then
      echo "Error: $bin not found in PATH."
      return 1
    fi
  done
  return 0
}

# Function to securely add the passphrase to macOS Keychain with access control
add_passphrase_to_keychain() {

  local passphrase
  local passphrase_file_name

  passphrase=$(generate_unique_passphrase)
  passphrase_file_path="$GNUPGHOME/$passphrase_file_name" # Store the passphrase in a file within GNUPGHOME

  # Write passphrase to the file and secure it
  echo "$passphrase" >"$passphrase_file_path"
  chmod 600 "$passphrase_file_path"
  echo "Passphrase stored securely in file: $passphrase_file_path"

  # Check if executables are available
  if check_executables; then
    # Add passphrase to the Keychain with restricted ACLs using a more descriptive name
    security add-generic-password -a "GPGSSH_KEY_PASSPHRASE" -s "Passphrase" -w "$passphrase" \
      -T "$(which pass)" \
      -T "$(which gpg)" \
      -T "$(which gpg-tui)" \
      -T "$(which gpgconf)" \
      -T "$(which gpg-agent)" \
      -T "$(which ssh)" \
      -T "$(which ssh-add)" \
      -T "$(which ssh-agent)" \
      -T "$(which ssh-keygen)" &&
      echo "Passphrase added to macOS Keychain with restricted ACLs."
  else
    echo "Passphrase addition failed due to missing executables."
  fi
}

# Function to fetch the passphrase from macOS Keychain
fetch_passphrase_from_keychain() {
  local passphrase
  passphrase=$(security find-generic-password -a "GPGSSH_KEY_PASSPHRASE" -s "Passphrase" -w)

  if [[ -z "$passphrase" ]]; then
    echo "Error: No passphrase found in Keychain."
    return 1
  fi

  echo "$passphrase"
}

# check_git_settings() {

#   # Set Git user name and email
#   git config --global user.name "$git_user_name"
#   git config --global user.email "$git_user_email"

#   git config --global commit.gpgSign true           # Enable commit signing by default
#   git config --global user.signingkey "$gpg_key_id" # Specify the GPG key for signing commits
#   git config --global tag.gpgSign true              # Enable GPG key signing for tags

#   print_success "Git configured successfully with GPG commit signing enabled."
# }

# Function to generate SSH key
generate_ssh_key() {

  print_info "Generating a new SSH key with Passphrase..."

  local passphrase
  export ssh_key_name

  passphrase=$(fetch_passphrase_from_keychain) # Fetch passphrase from Keychain
  ssh_key_name=$(generate_unique_name)         # Generate unique key name and passphrase

  ssh-keygen -t ed25519 -N "$passphrase" -C "GitHub ed25519 encrypted key" -f "$SSH_HOME/$ssh_key_name" -o -a 100
  # ssh-keygen -t rsa -b 4096 -N "$passphrase" -f "$SSH_HOME/$ssh_key_name

  print_success "Generating a new SSH key completed"
}

# Generate secure GnuPG keys with modern best practices
generate_gpg_key() {
  local passphrase
  local comment="GITHUB-KEY"
  local key_id_public

  # Fetch passphrase securely from macOS Keychain
  passphrase=$(fetch_passphrase_from_keychain)

  # Restart GPG agent for a clean session
  gpgconf --kill gpg-agent
  gpg-agent --daemon

  # Generate GPG key configuration file
  cat >gpg_key_config <<EOF
  %echo [1/5] Initializing secure key configuration
Key-Type: EDDSA
Key-Curve: ed25519
Key-Usage: sign
Subkey-Type: ECDH
Subkey-Curve: cv25519
Subkey-Usage: encrypt
Name-Real: $(git config user.name)
Name-Email: $(git config user.email)
Name-Comment: $comment
Passphrase: $passphrase
Expire-Date: 2y
Preferences: SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
%echo [2/5] Configuring keyserver for secure key exchange
keyserver: hkps://keys.openpgp.org
%ask-passphrase
%no-protection
%commit
%echo [3/5] Generating revocation certificate
%secring revoke.asc
%echo [4/5] Finalizing key setup
%pubring pubkey.asc
%commit
%echo [5/5] Key generation complete with TOFU enabled
EOF

  print_info "Generating GPG key..."
  gpg --batch --generate-key --pinentry-mode loopback --trust-model tofu gpg_key_config
  rm -f gpg_key_config

  # Extract the newly generated key ID
  key_id_public=$(gpg --list-keys --with-colons --keyid-format LONG | awk -F: '/^pub:/ {print $5; exit}')
  if [[ -z "$key_id_public" ]]; then
    print_error "Failed to retrieve GPG key ID"
    return 1
  fi

  # Apply TOFU trust model
  gpg --batch --yes --edit-key "$key_id_public" trust quit <<<"5"
  gpg --tofu-policy auto "$key_id_public"

  # Verify key trust status
  gpg --list-keys --with-colons | awk -F: -v key="$key_id_public" '$5 == key {print "Key:", key, "Trust Level:", $2}'

  # Check the trust level of a key
  gpg --list-keys | grep 'ultimate'

  print_success "GPG key $key_id_public successfully created and trusted with TOFU"
}

# Function to generate GPG revocation certificate
generate_gpg_revocation_certificate() {
  echo "Generating GPG revocation certificate..."
  # Save the revocation certificate
  gpg --output "$GNUPGHOME/revoke-$key_id.asc" --gen-revoke "$key_id" --batch --yes
}

# Add GPG private key to the Keychain and restrict access to ssh-agent
add_gpg_to_keychain() {
  local passphrase
  local key_id
  local private_key="$GNUPGHOME/private-gpg.key"

  passphrase=$(fetch_passphrase_from_keychain) # Fetch passphrase from macOS Keychain
  # key_id=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)
  key_id=$(gpg --list-secret-keys --keyid-format LONG | awk '/sec/{print $2}' | cut -d'/' -f2 | tail -1)

  # Export the private key
  gpg --armor --export-secret-keys "$key_id" >"$private_key"

  # Ensure executables exist
  if check_executables; then
    # Import GPG Key into GPG Keyring using the stored passphrase (Non-Interactive)
    echo "$passphrase" | gpg --batch --yes --passphrase-fd 0 --import "$private_key"

    # Test Signing/Decryption
    echo "Test" | gpg --clearsign && print_success "GPG Private key added to Keychain"
  else
    print_error "GPG Private key addition failed due to missing executables."
  fi
}

add_ssh_to_keychain() {
  local ssh_key_path="$SSH_HOME/$ssh_key_name"

  # Ensure the SSH key exists before adding
  if [[ ! -f "$ssh_key_path" ]]; then
    echo "Error: SSH key not found at $ssh_key_path"
    return 1
  fi

  # Add SSH key to macOS Keychain
  ssh-add --apple-use-keychain "$ssh_key_path"

  # Verify key was added
  if ssh-add -l | grep -q "$(ssh-keygen -lf "$ssh_key_path" | awk '{print $2}')"; then
    print_success "SSH key successfully added to macOS Keychain."
  else
    print_error "Failed to add SSH key to macOS Keychain."
    return 1
  fi
}

# Check GitHub CLI authentication
check_gh_auth() {
  if ! gh auth status >/dev/null 2>&1; then
    echo "GitHub CLI is not authenticated."
    echo "Starting GitHub authentication process..."

    # Add SSH and GPG keys to GitHub via API, follow these steps using GitHub's REST API.
    # You need a GitHub personal access token (PAT) with the admin:ssh_key scope.
    # gh auth refresh -h github.com -s admin:ssh_signing_key

    echo "Select authentication method:"
    echo "1) Browser (Recommended)"
    echo "2) Token"
    read -rp "Enter choice (1 or 2): " auth_choice

    case $auth_choice in
    1)
      gh auth login -w
      ;;
    2)
      echo "Please create a Personal Access Token with 'admin:gpg_key' scope at:"
      echo "https://github.com/settings/tokens/new"
      gh auth login -p ssh
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
    esac

    if ! gh auth status >/dev/null 2>&1; then
      echo "Authentication failed. Please try again."
      exit 1
    fi
  fi
}

# Function to add GPG key to GitHub using GitHub CLI
add_gpg_key_to_github() {
  echo "Adding GPG key to GitHub..."

  # Get the GPG key ID (assuming there's only one key, modify if needed for multiple keys)
  gpg_key_id=$(gpg --list-keys --with-colons | awk -F: '/^pub/{print $5}')

  # gpg_public_key=(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)
  # echo (gpg --armor --export $gpg_public_key) | gh gpg-key add -

  # Export the public GPG key to a temporary file
  gpg_public_key=$(mktemp)
  gpg --armor --export "$gpg_key_id" >"$gpg_public_key"

  # Add the GPG key to GitHub
  if check_gh_auth; then
    gh gpg-key add "$gpg_public_key" --title "GPG-$gpg_key_id"
  fi

  # Clean up the temporary file
  rm "$gpg_public_key"

  echo "The GPG key has been automatically added to your GitHub account."
}

# Function to add SSH key to GitHub using GitHub CLI
add_ssh_key_to_github() {
  echo "Adding SSH key to GitHub..."

  local ssh_public_key="${ssh_key_name}.pub"

  # Check if GitHub CLI is authenticated
  if ! check_gh_auth; then
    echo "GitHub authentication failed."
    return 1
  fi

  # Add the SSH key to GitHub
  gh ssh-key add "$ssh_public_key" --title "macOS-SSH"

  echo "SSH key has been successfully added to your GitHub account."
}

# Verify the keys have been added to Keychain
check_keychain_data() {

  echo "Verifying Passphrase in Keychain..."
  security dump-keychain | grep "Passphrase"

  echo "Verifying GPG key in Keychain..."
  security find-generic-password -a "GPG" -s "PrivateKey" -w

  echo "Verifying SSH key in Keychain..."
  security find-generic-password -a "SSH" -s "PrivateKey" -w
}

# Function to check SSH connection
check_ssh_connection() {
  echo "Testing SSH connection..."
  ssh -T git@github.com || echo "SSH connection failed"
}

# Function to check GPG connection
check_gpg_connection() {
  echo "Testing GPG connection..."
  gpg --list-keys "$GPG_KEY_NAME" || echo "GPG connection failed"
  gpg --list-keys --with-tofu # Validate and list the key

  # # Verify key integrity
  # gpg --check-sigs
  # gpg --fingerprint
}

check_github_keys() {
  gh ssh-key list
  gh gpg-key list

  # Verify if at least one key and ssh-keygen works as expected
  echo "testpayload" |
    ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_PRIMARY}" >gpgssh_prereq.sig &&
    ssh-keygen -Y find-principals -f "${GPGSSH_ALLOWED_SIGNERS}" -s gpgssh_prereq.sig &&
    echo "testpayload" |
    ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with number 1" -s gpgssh_prereq.sig
}

check_git_config() {
  # print_step "Verifying Git configuration..."
  git config --list --show-origin | grep -E "user.name|user.email|commit.gpgSign|user.signingkey|tag.gpgSign" ||
    print_error "Configure your ~/.gitconfig > user.name|user.email|commit.gpgSign|user.signingkey|tag.gpgSign"
}

# Test signing
check_signing_commit() {

  TEST_DIR=$(mktemp -d)
  cd "$TEST_DIR" || exit
  git init
  echo "# Test Repository" >README.md
  git add README.md

  # Get the GPG key ID
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)
  # GPG_KEY_ID=$(gpg --list-secret-keys --with-keygrip --with-colons | grep '^sec:' | awk -F: '{print $5}')

  # Check and clean existing GPG settings
  if git config --list --show-origin | grep -q "commit.gpgsign"; then
    git config --global --unset commit.gpgsign
  fi

  # Configure Git with new GPG settings
  git config --global gpg.program "$(which gpg)"
  git config --global user.signingkey "$GPG_KEY_ID"
  sleep 1
  git config --global log.showSignature "true"
  git config --global commit.gpgsign "true"
  git config --global tag.gpgSign "true"
  git config --global user.signingkey
  # https://stackoverflow.com/questions/43000848/substitute-for-bash-in-fish
  git config --global gpg.format openpgp
  git config --list --show-origin | grep -E "user.name|user.email|commit.gpgSign|user.signingkey|tag.gpgSign"

  if git commit -S -m "Test signed commit"; then
    git log --show-signature --oneline
    echo "GPG signing test successful!"
  else
    echo "GPG signing test failed. Please check your configuration."
  fi

  cd - >/dev/null || exit
  rm -rf "$TEST_DIR"

}

# Export the GPG Key Materials
export_gpg_key() {

  # Get the GPG key ID
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | tail -1 | awk '{print $2}' | cut -d'/' -f2)

  # Set secure export paths
  EXPORT_DIR="$HOME/.gnupg/backup"
  mkdir -p "$EXPORT_DIR"

  # Export the public and private keys
  # gpg --armor --export "$key_id" >"$GNUPGHOME/$key_id-public.asc"
  # gpg --armor --export-secret-keys "$key_id" >"$GNUPGHOME/$key_id-private.asc"

  print_success "GPG keys exported successfully:"
  print_step "• Public key: ${GREEN}$EXPORT_DIR/gpg_public_${GPG_KEY_ID}.asc${NC}"
  print_step "• Private key: ${GREEN}$EXPORT_DIR/gpg_private_${GPG_KEY_ID}.asc${NC}"

  git config --list --show-origin | grep user.signingkey

  # gpg --list-secret-keys --keyid-format=long

}

# Main function to orchestrate key generation, storage, and GitHub integration
main() {
  echo "Starting key generation and management..."

  generate_passphrase        # Generate passphrase with OpenSSL
  add_passphrase_to_keychain # Add passphrase to Keychain
  generate_ssh_key           # Generate SSH key and add to Keychain
  generate_gpg_key           # Generate GPG key and add to Keychain
  add_ssh_key_to_keychain
  add_gpg_key_to_keychain
  add_ssh_key_to_github
  add_gpg_key_to_github
  #export_ssh_public_key  # Eenerate_gpg_revocation_certificate
  #export_gpg_public_key # Excpore GPG Key
  check_keychain_data # Verify the keys have been added to Keychain
  check_github_keys
  check_keys_exis # Check if keys exist

  # Test connections
  check_ssh_connection
  check_gpg_connection

  echo "Key generation, GitHub integration, and connection tests complete."
}

# Run the main function
main
