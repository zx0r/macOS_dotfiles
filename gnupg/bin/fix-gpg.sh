#!/bin/bash
# fix-gpg-trust.sh

KEY_ID="01628E140A9FDB15"

# 1. Check if key exists
if ! gpg --list-keys "$KEY_ID" >/dev/null 2>&1; then
  echo "ERROR: Key $KEY_ID not found in keychain"
  exit 1
fi

# 2. Set ultimate trust non-interactively
gpg --batch --command-fd 0 --edit-key "$KEY_ID" <<EOF
trust
5
y
save
EOF

# 3. Verify trust level
echo -e "\nTrust status:"
gpg --list-keys --with-colons "$KEY_ID" | grep '^trust'

# 4. Update Git configuration
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo -e "\n\033[1;32m✓ Trust set to 'ultimate' for key $KEY_ID\033[0m"
