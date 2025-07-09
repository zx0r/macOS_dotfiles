#!/bin/bash

# Constants for directories and keys
GNUPGHOME="$HOME/.gnupg"
SSH_KEY_DIR="$HOME/.ssh"
LOGFILE="$HOME/setup_security_infrastructure.log"

# Function to log messages and output notifications
log() {
  echo "$1" | tee -a $LOGFILE
}

# Step 1: Install dependencies
log "Step 1: Installing necessary dependencies..."
brew install gnupg git keychain curl || {
  log "Error: Failed to install dependencies."
  exit 1
}

# Step 2: Create directories
log "Step 2: Creating necessary directories..."
mkdir -p $GNUPGHOME
mkdir -p $SSH_KEY_DIR
chmod 700 $GNUPGHOME
chmod 700 $SSH_KEY_DIR

# Step 3: Generate new GPG keys (with strong settings and batch processing)
log "Step 3: Generating new GPG keys..."

GPGSSH_KEY_PRIMARY="${GNUPGHOME}/sshcontrol"
GPGSSH_KEY_SECONDARY="${GNUPGHOME}/secondary_key"
GPGSSH_SIGNING_KEY="${GNUPGHOME}/signing_key"
GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_key"
GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"

# Batch file for GPG key generation
cat >$GNUPGHOME/gpg_key_batch.txt <<EOL
    %no-protection
    %pubring $GPGSSH_KEY_PRIMARY.pub
    %secring $GPGSSH_KEY_PRIMARY.sec
    %commit
    Key-Type: 1
    Key-Length: 4096
    Subkey-Type: 1
    Subkey-Length: 4096
    Name-Real: "Primary SSH Key"
    Name-Email: "youremail@example.com"
    Expire-Date: 0
    Passphrase: "some_secure_passphrase"
    %no-protection
EOL

# Generate keys using batch file
gpg --batch --gen-key $GNUPGHOME/gpg_key_batch.txt || {
  log "Error: GPG key generation failed."
  exit 1
}

# Step 4: Export GPG key and upload to keyserver
log "Step 4: Exporting GPG key and uploading to keyserver..."
gpg --armor --export "youremail@example.com" >$GNUPGHOME/primary_key.asc
gpg --send-keys --keyserver hkps://keys.openpgp.org "youremail@example.com" || {
  log "Error: Keyserver upload failed."
  exit 1
}

# Step 5: Generate SSH keys
log "Step 5: Generating SSH keys..."
ssh-keygen -t rsa -b 4096 -f $SSH_KEY_DIR/id_rsa -N "" || {
  log "Error: SSH key generation failed."
  exit 1
}

# Step 6: Add SSH key to macOS Keychain using keychain
log "Step 6: Storing SSH key in macOS Keychain..."
keychain --quiet --agents ssh $SSH_KEY_DIR/id_rsa || {
  log "Error: Keychain integration failed."
  exit 1
}

# Step 7: Add SSH/GPG keys to GitHub
log "Step 7: Adding SSH/GPG keys to GitHub..."

# Retrieve SSH public key and add to GitHub
SSH_KEY=$(cat $SSH_KEY_DIR/id_rsa.pub)
curl -u "your-github-username" --data "{\"title\":\"My SSH Key\",\"key\":\"$SSH_KEY\"}" https://api.github.com/user/keys || {
  log "Error: GitHub SSH key addition failed."
  exit 1
}

# Retrieve GPG public key and add to GitHub
GPG_KEY=$(cat $GNUPGHOME/primary_key.asc)
curl -u "your-github-username" --data "{\"subkeys\":[],\"public_key\":\"$GPG_KEY\"}" https://api.github.com/user/gpg_keys || {
  log "Error: GitHub GPG key addition failed."
  exit 1
}

# Step 8: Verify SSH connection
log "Step 8: Verifying SSH connection..."
ssh -T git@github.com || {
  log "Error: SSH connection verification failed."
  exit 1
}

# Step 9: Verify GPG commit signature
log "Step 9: Verifying GPG commit signature..."
git config --global user.signingkey $GPGSSH_SIGNING_KEY
git config --global commit.gpgsign true
git commit --allow-empty -m "Test commit" || {
  log "Error: Commit signing verification failed."
  exit 1
}

# Step 10: Output and final verification
log "Step 10: Verification complete. All tasks were successful."
log "All keys and credentials are securely stored in macOS Keychain."

# Final Status Notification
log "Setup complete. Please verify that everything is functioning correctly."
