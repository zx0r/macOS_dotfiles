# ~/.config/fish/functions/github_bare_repo.fish
# Functions for managing GitHub with a Git bare repo, commits with/without signing.

# git_bare_init <repo-path> → Initialize a Git bare repository.
# git_bare_clone <repo-url> <work-tree-path> → Clone a bare repo and set up a work tree.
# git_signed_commit "message" → Commit changes with GPG signing.
# git_unsigned_commit "message" → Commit changes without signing.
# git_push <branch> → Push changes to the remote branch.
# git_pull → Pull latest changes from the current branch.
# git_history <N> → Show the last N commits (default: 10).
# git_set_remote <repo-path> <remote-url> → Set the remote URL for a bare repository.
# This script automates GitHub bare repository management efficiently using Fish shell. 🚀

# Step 1: "🛠️ Initializing bare Git repository for dotfiles..."
# git init --bare "$HOME/.git_bare_repo"

# # Step 2: Set up alias for easier interaction
# abbr -a dot="git --git-dir=$HOME/.git_bare_repo --work-tree=$HOME/macOS-Trash-Management"

# # Step 3: Configure Git to hide untracked files (so home directory looks clean)
# dot config --local status.showUntrackedFiles no

# # Step 4: Set the default branch to 'main'
# dot branch -M main

# # Step 5: Add the remote repository (Modify with your repo URL)
# dot remote add origin git@github.com:zx0r/macOS-Trash-Management.git

# # Step 6: Add files for commit
# dot add <file >

# # Step 6: Check the status of the repository
# dot status

# # Step 7: Commit files with a message
# dot commit -m "$argv"

# # Step 8: Push changes
# dot push -u origin main

# dot reset --hard

function bare
    env GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git $argv
end

# ----------------------------------------
# (Optional) Initialize a Git bare repository
# ----------------------------------------

function git_bare_init_bew_dir
    if test (count $argv) -ne 1
        echo "Usage: git_bare_init <repo-path>"
        return 1
    end
    git init --bare $argv[1]
    echo "Initialized bare repository at $argv[1]"
end

# ----------------------------------------
# Step 1. Create a New Repository
# ----------------------------------------

# https://cli.github.com/manual/gh_repo_create
function gh_create_repo
    # Ensure GitHub authentication is valid
    gh auth status >/dev/null 2>&1
    if test $status -ne 0
        echo "❌ GitHub authentication failed. Please run 'gh auth login'."
        return 1
    end

    # Prompt for repository name
    set -U repo_name (read -P "📌 Enter the name of the new repository: ")
    if test -z "$repo_name"
        echo "❌ Repository name cannot be empty. Aborting."
        return 1
    end

    # Check if the repository already exists
    gh repo view "$repo_name" >/dev/null 2>&1
    if test $status -eq 0
        echo "❌ Repository '$repo_name' already exists on GitHub."
        return 1
    end

    # Prompt for repository description
    set -l repo_description (read -P "📌 Enter a description for the repository: ")

    # Prompt for repository visibility
    set -l is_public (read -P "📌 Should the repository be public? (y/n): ")
    set visibility --private
    if test "$is_public" = y
        set visibility --public
    end

    # Prompt for cloning the repository
    # set -l clone_repo (read -P "🔂 Clone the repository locally? (y/n): ")
    # set clone_flag ""
    # if test "$clone_repo" = y
    #     set clone_flag --clone
    # end

    # Display confirmation
    echo "⚡ Creating repository with the following details:"
    echo "📌 Name: $repo_name"
    echo "📝 Description: $repo_description"
    echo "🔓 Visibility: $visibility"
    # echo "🔄 Clone locally: $clone_repo"
    set -l confirm (read -P "✅ Proceed? (y/n): ")

    if test "$confirm" != y
        echo "🚫 Repository creation canceled."
        return 1
    end

    # Create the repository with proper quoting
    gh repo create "$repo_name" --description "$repo_description" $visibility
    if test $status -eq 0
        echo "✅ Repository '$repo_name' created successfully! 🌈"
    else
        echo "❌ Failed to create repository. Check your GitHub CLI setup or permissions."
        return 1
    end
end

# ----------------------------------------
# Step 2: Define the Git bare repository directory
# ----------------------------------------

set -l git_bare_dir "$HOME/.git_bare_repo"

# Step 2: Check if the repository already exists
if not test -d "$git_bare_dir"
    echo "🛠️ Initializing bare Git repository for dotfiles..."
    git init --bare "$git_bare_dir"
    echo "✅ Bare repository created at $git_bare_dir"
else
    echo "✔️ Bare repository already exists at $git_bare_dir"
end

# ----------------------------------------
# Step 3. Disable showing untracked files in the status
# ----------------------------------------

function git_bare_untracked
    dot config --local status.showUntrackedFiles no
end

# ----------------------------------------
# Step 4. Set up a bare repository as the default remote
# ----------------------------------------

function git_set_remote
    if test (count $argv) -ne 2
        echo "Usage: git_set_remote <repo-path> <remote-url>"
        return 1
    end
    dot branch -M main
    dot remote add origin $argv[2]
    echo "Set remote origin to $argv[2]"
end

# ----------------------------------------
# Step 5. Add specified files to the dotfiles repo
# ----------------------------------------

function dot_add
    if test (count $argv) -eq 0
        echo "❌ No files specified. Usage: dot_add <file1> <file2> ..."
        return 1
    end

    for file in $argv
        if test -e $file
            dot add $file
            echo "✅ Added: $file"
        else
            echo "⚠️ Skipped: $file (does not exist)"
        end
    end
end

# ----------------------------------------
# (Optional) Add all changes (modified and new files)
# ----------------------------------------

function dot_add_all
    dot add -A
    echo "✅ All changes staged."
end

# ----------------------------------------
# Step 6. Check the status of the repository
# ----------------------------------------

function dotstatus
    dot status
end


# ----------------------------------------
# Step 7. Commit changes with a message
# ----------------------------------------

function dot_commit
    if test (count $argv) -eq 0
        echo "❌ Commit message required."
        return 1
    end
    dot commit -m "$argv"
    echo "✅ Changes committed: $argv"
end

# ----------------------------------------
# (Optional) # Add and commit changes with GPG signing
# ----------------------------------------

function git_gpg_commit
    if test (count $argv) -lt 1
        echo "Usage: git_signed_commit <message>"
        return 1
    end
    dot commit -S -s -m "$argv"
    echo "Committed changes with GPG signing"
end

# ----------------------------------------
# Step 8. Push changes to the remote repository
# ----------------------------------------

function dot_push
    dot push -u origin main
    echo "🚀 Changes pushed to remote."
end

# ----------------------------------------
# (Optional) Pull latest changes from remote
# ----------------------------------------

function dot_pull
    dot pull origin main
    echo "📥 Repository updated from remote."
end

# ----------------------------------------
# (Optional) Show the last commit details
# ----------------------------------------

# Show the last N commits
function git_history
    if test (count $argv) -lt 1
        set num 10
    else
        set num $argv[1]
    end
    git log --oneline -n $num
end

# ----------------------------------------
# (Optional) Show the last commit details
# ----------------------------------------

function dot_last_commit
    dot log -1 --oneline --graph --decorate
end

# List branches
function dot_branches
    dot branch -a
end

# ----------------------------------------
# (Optional) Remove a file from tracking but keep it locally
# ----------------------------------------

function dot_remove
    if test (count $argv) -eq 0
        echo "❌ Specify a file to remove from tracking."
        return 1
    end
    dot rm --cached $argv
    echo "🗑️ File removed from tracking: $argv"
end

# ----------------------------------------
# (Optional) Reset last commit (soft: keep changes, hard: remove changes)
# ----------------------------------------

function dot_reset
    if test (count $argv) -eq 0
        echo "❌ Specify 'soft' or 'hard'."
        return 1
    end
    dot reset --$argv HEAD
    echo "🔄 Repository reset ($argv)."
end
# ----------------------------------------
# (Optional) Clone a bare repository and set up work tree
# ----------------------------------------

function git_bare_clone
    if test (count $argv) -ne 2
        echo "Usage: git_bare_clone <repo-url> <work-tree-path>"
        return 1
    end
    set -l repo_url $argv[1]
    set -l work_tree $argv[2]
    git clone --bare $repo_url ~/.git_bare_repo.git
    git --git-dir=$HOME/.bare_repo.git --work-tree=$work_tree checkout
    echo "Bare repository cloned and work tree set to $work_tree"
end
