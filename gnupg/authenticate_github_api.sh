#!/usr/bin/env bash

🔹 1. Add SSH Key via GitHub API
You need a GitHub personal access token (PAT) with the admin:ssh_key scope.

📝 Request:
```bash
curl -X POST -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     https://api.github.com/user/keys \
     -d '{
       "title": "My GitHub SSH Key",
       "key": "'"$(cat ~/.ssh/github/github_ed25519.pub)"'"
    }'
```
# 🔹 Explanation:
# Authorization: token YOUR_GITHUB_TOKEN → Authenticate with your GitHub token.
# https://api.github.com/user/keys → API endpoint for adding SSH keys.
# "title": "My GitHub SSH Key" → A descriptive name.
# "key": "'"$(cat ~/.ssh/github/github_ed25519.pub)"'" → Reads and sends your SSH public key.

🔹 2. Add GPG Key via GitHub API
To upload your GPG key, use a token with admin:gpg_key scope.

📝 Request:
```bash
curl -X POST -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     https://api.github.com/user/gpg_keys \
     -d '{
       "armored_public_key": "'"$(gpg --armor --export YOUR_GPG_KEY_ID)"'"
     }'
```     
# 🔹 Explanation:
# gpg --armor --export YOUR_GPG_KEY_ID → Extracts your GPG public key.
# https://api.github.com/user/gpg_keys → API endpoint for adding GPG keys.

🔹 3. Verify Your Keys
Check Added SSH Keys
```bash
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     https://api.github.com/user/keys
```bash
Check Added GPG Keys
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     https://api.github.com/user/gpg_keys
```

🔹 4. Delete SSH/GPG Key
Remove SSH Key by ID
```bash
curl -X DELETE -H "Authorization: token YOUR_GITHUB_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     https://api.github.com/user/keys/KEY_ID
Remove GPG Key by ID
curl -X DELETE -H "Authorization: token YOUR_GITHUB_TOKEN"
```

# Use `gh`

# 🔹 1. Generating SSH Key for GitHub

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

# Add SSH and GPG keys to GitHub via API, follow these steps using GitHub's REST API.
# You need a GitHub personal access token (PAT) with the admin:ssh_key scope.

# Method 1: Using a Personal Access Token (PAT)

# GitHub requires a Personal Access Token (PAT) with the necessary scopes instead of a password.

# Step 1: Generate a Personal Access Token (PAT)
# Go to GitHub: GitHub Token Settings
# Click "Generate new token"
# Choose an Expiration Date (Recommended: 90 days)
# Select Required Scopes:
# For SSH Key Management: admin:ssh_key
# For GPG Key Management: admin:gpg_key
# For Repo Admin: repo, workflow
# For Full Admin Control: admin:org, admin:public_key
# Generate and copy the token (Keep it secure!)

# Run cmd and Copy and Paste code
# gh auth refresh -h github.com -s admin:ssh_signing_key

## ! First copy your one-time code: 73B8-69BF
# Press Enter to open https://github.com/login/device in your browser...
# ✓ Authentication complete.

# 🔹 2. Add SSH Key via GitHub API

# gh ssh-key list
# no SSH keys present in the GitHub account

# https://github.com/settings/keys
# gh ssh-key add --title 'macOS-SSH' $HOME/.ssh/github/github_ed25519.pub
# ✓ Public key added to your account

# Add SSH key to the macOS Keychain
# ssh-add -K $HOME/.ssh/github/github_ed25519.pub  # Add SSH key to macOS Keychain

# - Add an SSH key to the currently authenticated user's account:
# `gh ssh-key add {string value: path/to/key.pub}`

# - Add an SSH key to the currently authenticated user's account with a specific title:
# `gh ssh-key add --title {string value: title} {string value: path/to/key.pub}`

# gh ssh-key
# Manage SSH keys registered with your GitHub account.

# USAGE
#   gh ssh-key <command> [flags]

# AVAILABLE COMMANDS
#   add:         Add an SSH key to your GitHub account
#   delete:      Delete an SSH key from your GitHub account
#   list:        Lists SSH keys in your GitHub account

# INHERITED FLAGS
#   --help   Show help for command

# LEARN MORE
#   Use `gh <command> <subcommand> --help` for more information about a command.
#   Read the manual at https://cli.github.com/manual
#   Learn about exit codes using `gh help exit-codes`

# 🔹 1. Generating GPG Key for GitHub

# openssl rand -base64 32 > /tmp/gpg-passphrase.txt
# security add-generic-password -a "GPG" -s "Passphrase" -w "$(cat /tmp/gpg-passphrase.txt)"
# rm /tmp/gpg-passphrase.txt

# Alternative: Store in a Secure Environment Variable
# export GPG_TTY=$(tty)
# echo "my_secure_passphrase" | gpg --batch --passphrase-fd 0 --decrypt myfile.gpg


# Generate secure GnuPG keys with modern best practices
cat > "$gpg_batch_config" << EOF
%echo [1/4] Initializing advanced key configuration
Key-Type: EDDSA              # Modern Ed25519 algorithm
Key-Curve: ed25519           # Strong elliptic curve
Key-Usage: sign              # Primary key only for certification
Subkey-Type: ECDH            # Encryption subkey
Subkey-Curve: cv25519        # X25519 for perfect forward secrecy
Subkey-Usage: encrypt
Subkey-Type: EDDSA           # Signing subkey
Subkey-Curve: ed25519
Subkey-Usage: sign
Name-Real: ${my_name}
Name-Email: ${my_email}
Expire-Date: 2y              # Key expiration (recommended for security)
Passphrase: $(security find-generic-password -a "GPG" -s "Passphrase" -w)  # Random 32-byte passphrase
Preferences: SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed  # Algorithm priorities
Features: keyserver-no-import-self-sigs  # Security hardening
Key-Server: hkps://keys.openpgp.org  # Secure keyserver
%ask-passphrase             # Force passphrase entry
%no-protection              # Remove master key protection
%commit
%echo [2/4] Generating revocation certificate
%secring revoke.asc
%generate-revocation
%echo [3/4] Exporting public key
%armor                      # ASCII armor for easy sharing
%export
%echo [4/4] Finalizing setup
%ttybak secring.txt         # Backup secret key material
%pubring pubkey.asc
%commit
%echo Key generation complete
EOF


# Set proper permissions
# chmod 700 ~/.gnupg
# chmod 600 ~/.gnupg/*

# # Import keys
# gpg --import pubkey.asc
# gpg --import secring.txt

# # Verify key integrity
# gpg --check-sigs
# gpg --fingerprint

# # Configure gpg-agent
# echo "pinentry-program /usr/bin/pinentry-tty" >> ~/.gnupg/gpg-agent.conf
# gpgconf --kill gpg-agent

# 🔹 2. Add GPG Key via GitHub API

# gh gpg-key list
# no GPG keys present in the GitHub account


# gh gpg-key
# Manage GPG keys registered with your GitHub account.

# USAGE
#   gh gpg-key <command> [flags]

# AVAILABLE COMMANDS
#   add:         Add a GPG key to your GitHub account
#   delete:      Delete a GPG key from your GitHub account
#   list:        Lists GPG keys in your GitHub account

# INHERITED FLAGS
#   --help   Show help for command

# LEARN MORE
#   Use `gh <command> <subcommand> --help` for more information about a command.
#   Read the manual at https://cli.github.com/manual
#   Learn about exit codes using `gh help exit-codes`

# gh gpg-key add [<key-file>] [flags]
# gh-gpg-key-add - Add a GPG key to your GitHub account
#
# gh gpg-key list
# no GPG keys present in the GitHub account
#





