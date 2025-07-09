#!/bin/bash
# Author: Marcus Dean Adams (gerowen@pm.me)
# Optimized GPG encryption and decryption script
# https://gitlab.com/-/snippets/3717529

set -euo pipefail # Enable strict mode: stops execution on errors

echo -e "\nChoose an operation:\n1) Encrypt\n2) Decrypt\n"
read -rp "Enter choice (1 or 2): " op

case "$op" in
1) # Encrypt
  echo -e "\nEnter the text you wish to encrypt. Press CTRL+D when finished.\n"
  message=$(cat) # Capture multi-line input

  read -rp $'\nList available GPG keys? (y/n): ' listkeys
  listkeys=${listkeys,,} # Convert to lowercase
  [[ "$listkeys" =~ ^(y|yes)$ ]] && gpg --list-keys

  read -rp $'\nEnter recipient key ID or email: ' recipient

  echo "$message" | gpg -a --encrypt --recipient "$recipient"
  ;;

2) # Decrypt
  echo -e "\nEnter the encrypted text. Press CTRL+D when finished.\n"
  message=$(cat) # Capture encrypted input

  echo "$message" | gpg --decrypt
  ;;

*) # Invalid input
  echo -e "\n❌ Invalid input detected, exiting...\n" >&2
  exit 1
  ;;
esac

exit 0
