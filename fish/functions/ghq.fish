# Set GHQ root if not already defined
if not set -q GHQ_ROOT
    set -Ux GHQ_ROOT $HOME/projects
end

# Function to list all repositories managed by ghq
function ghq_ls --description "List all repositories managed by ghq"
    ghq list -p
end

# Function to fuzzy search and navigate into a repository
function ghq_cd --description "Fuzzy search and navigate into a ghq repository"
    set repo (ghq list -p | fzf)
    if test -n "$repo"
        cd "$repo"
    else
        echo "No repository selected."
    end
end

# Function to open a repository in Neovim
function ghq_nvim --description "Fuzzy search and open a ghq repository in Neovim"
    set repo (ghq list -p | fzf)
    if test -n "$repo"
        nvim "$repo"
    else
        echo "No repository selected."
    end
end

# Function to open a repository in VS Code
function ghq_code --description "Fuzzy search and open a ghq repository in VS Code"
    set repo (ghq list -p | fzf)
    if test -n "$repo"
        code "$repo"
    else
        echo "No repository selected."
    end
end

# Function to clone a repository using ghq
function ghq_clone --description "Clone a repository using ghq"
    echo "Enter repository URL (GitHub shorthand like 'cli/cli' works too):"
    read -l repo
    if test -n "$repo"
        ghq get "$repo"
        echo "Repository cloned successfully!"
    else
        echo "No repository URL provided."
    end
end

# Function to remove a repository interactively
function ghq_rm --description "Select and remove a repository from ghq"
    set repo (ghq list -p | fzf)
    if test -n "$repo"
        echo "Are you sure you want to remove $repo? (y/N)"
        read -l confirm
        if test "$confirm" = y -o "$confirm" = Y
            rm -rf "$repo"
            echo "Repository removed: $repo"
        else
            echo "Operation canceled."
        end
    else
        echo "No repository selected."
    end
end
