_auth_token_flow() {
  local token_url=" https://github.com/settings/tokens/new?scopes=admin:gpg_key,admin:ssh_key,admin:ssh_signing_key,gist,
    repo,delete_repo,
    workflow,
    write:discussion,
    admin:public_key,
    write:public_key,
    read:public_key,
    write:gpg_key,
    read:gpg_key&description=macOS"
  print_info "ℹ Create PAT with required scopes:"
  echo -e "${token_url}\n"

  read -rp "Paste token: " gh_token
  echo "$gh_token" | gh auth login --with-token >/dev/null
}
