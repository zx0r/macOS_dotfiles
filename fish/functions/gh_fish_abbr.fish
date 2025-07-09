# ============================
# 🐟 GitHub CLI Abbreviations
# ============================

# 🔍 Repository Management
abbr -a ghcr "gg repo create" # Create new repo
abbr -a ghcl "gh repo clone" # Clone repo
abbr -a ghfork "gh repo fork --clone" # Fork & clone repo
abbr -a ghview "gh repo view --web" # Open repo in browser
abbr -a ghlist "gh repo list" # List user repositories

# 📤 Pull Requests (PRs)
abbr -a ghpr "gh pr create --title" # Create a PR
abbr -a ghprl "gh pr list" # List PRs
abbr -a ghprc "gh pr checkout" # Checkout a PR
abbr -a ghprm "gh pr merge --merge" # Merge a PR

# 📝 Issues & Discussions
abbr -a ghip "gh issue list" # List issues
abbr -a ghis "gh issue create --title" # Create an issue
abbr -a ghic "gh issue close" # Close an issue
abbr -a ghd "gh discussion list" # List discussions

# 👥 Collaborators & Teams
abbr -a ghci "gh repo add-collaborator" # Add collaborator
abbr -a ght "gh api /orgs/<org>/teams" # List org teams

# 🔄 CI/CD & Workflows
abbr -a ghwf "gh workflow list" # List GitHub Actions workflows
abbr -a ghwr "gh workflow run" # Run a workflow

# 🔧 API Commands (For Advanced Users)
abbr -a ghr "gh api repos/{owner}/{repo}" # Get repo details
abbr -a ghbr "gh api repos/{owner}/{repo}/branches" # List branches
abbr -a ghfi "gh api repos/{owner}/{repo}/issues" # List issues via API
abbr -a ghprapi "gh api repos/{owner}/{repo}/pulls" # List PRs via API
abbr -a ghwfapi "gh api repos/{owner}/{repo}/actions/workflows" # List workflows via API

# 📝 Get Raw File Content
abbr -a ghrd 'gh api repos/{owner}/{repo}/contents/{file} --jq ".download_url" | xargs curl -fsSL'

# Save Raw file
abbr -a ghrd 'gh api repos/zx0r/Git-Bare-Repo-Management/contents/README.md --jq '.download_url' | xargs curl -o README.md'

# ============================
# ✅ Apply Immediately
# ============================
echo "✅ GitHub CLI abbreviations loaded!"
