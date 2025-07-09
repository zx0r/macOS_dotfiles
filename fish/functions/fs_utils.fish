# 🛠️ File System Utilities for Fish Shell
# Dependencies: rg (ripgrep), rga (ripgrep-all), fd, fzf

# 🛠️ Fish Functions for Finding & Managing Files

# 1️⃣ 🔍 Fuzzy Find Files using `fzf`
function fzf_find
    set file (fzf --preview 'bat --style=numbers --color=always --line-range=:100 {}')
    if test -n "$file"
        echo "📄 Selected: $file"
    else
        echo "❌ No file selected."
    end
end

# 2️⃣ 🔍 Find Files using `fd`
function fd_find
    set file (fd --type f "$argv" $HOME | fzf --preview 'bat --style=numbers --color=always --line-range=:100 {}')
    if test -n "$file"
        echo "📄 Selected: $file"
    else
        echo "❌ No file found for '$argv'."
    end
end

# 3️⃣ 🔍 Search File Contents using `rg`
function rg_find
    set file (rg --files-with-matches "$argv" $HOME | fzf --preview 'rg --context 5 --color=always --pretty {}')
    if test -n "$file"
        echo "📄 Found: $file"
    else
        echo "❌ No matches for '$argv'."
    end
end

# 4️⃣ 🔍 Search All File Contents using `rg-all`
function rg_all_find
    set file (rg-all --files-with-matches "$argv" $HOME | fzf --preview 'rg --context 5 --color=always --pretty {}')
    if test -n "$file"
        echo "📄 Found: $file"
    else
        echo "❌ No matches for '$argv'."
    end
end

# 5️⃣ 📂 Find & Open Files using `fd`
function fd_open
    set file (fd --type f "$argv" $HOME | fzf --preview 'bat --style=numbers --color=always --line-range=:100 {}')
    if test -n "$file"
        echo "📂 Opening: $file"
        xdg-open "$file" >/dev/null 2>&1 &
    else
        echo "❌ No file selected."
    end
end

# 6️⃣ 📂 Find & Delete Files with Confirmation
function fd_delete
    set file (fd --type f "$argv" $HOME | fzf --preview 'bat --style=numbers --color=always --line-range=:100 {}')
    if test -n "$file"
        echo "⚠️ Delete '$file'? (y/N)"
        read confirm
        if test "$confirm" = y
            rm "$file"
            echo "🗑️ File deleted: $file"
        else
            echo "✅ Deletion canceled."
        end
    else
        echo "❌ No file selected."
    end
end

### Finding and Navigating Directories

# 1️⃣ Find & Navigate using `find`
function find_cd
    set dir (find $HOME -type d -name "$argv" -print -quit)
    if test -n "$dir"
        cd "$dir"
    else
        echo "❌ Directory '$argv' not found."
    end
end

# 2️⃣ Find repository using `ghq`
function ghq_find
    ghq list | grep "$argv"
end

# 3️⃣ Find directory using `fd`
function fd_find
    set dir (fd -t d "$argv" $HOME | fzf)
    if test -n "$dir"
        cd "$dir"
    else
        echo "❌ No matching directories found."
    end
end

# 4️⃣ List directories matching pattern
function ls_find
    ls -d $HOME/* | grep "$argv"
end

# 5️⃣ Combine multiple search methods and navigate
function find_project
    echo "🔍 Searching for '$argv'..."

    set dir (find $HOME -type d -name "$argv" -print -quit)
    if test -n "$dir"
        echo "✅ Found using 'find': $dir"
        cd "$dir"
        return
    end

    set dir (ghq list | grep "$argv")
    if test -n "$dir"
        echo "✅ Found using 'ghq': $dir"
        return
    end

    set dir (fd -t d "$argv" $HOME | fzf)
    if test -n "$dir"
        echo "✅ Found using 'fd': $dir"
        cd "$dir"
        return
    end

    echo "❌ No matches found for '$argv'."
end

### 📌 Navigation & Directory Management

# Move up N levels in directory
function up
    set level (math (count $argv) + 1)
    eval cd (string repeat -n $level "../")
end

# Create directory and immediately enter it
function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end

# Change directory to Finder's current path (macOS only)
function cdf
    cd (osascript -e 'tell application "Finder" to get POSIX path of (target of front window as alias)')
end

### Manage Permissions (chmodx, chownme)

# Make a file executable
function chmodx
    chmod +x $argv
end

# Change file ownership to current user
function chownme
    sudo chown -R (whoami) $argv
end

### 🔍 FAST SEARCHING FUNCTIONS ###

# Search for files by name (recursive)
function ff
    find . -iname "*$argv*"
end

# Search for directories only
function fd
    find . -type d -iname "*$argv*"
end

# Search for text inside files
function search
    grep -rni "$argv" .
end

# 1️⃣ Search for files using ripgrep (`rg`)
function rgf
    rg --files | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}"
end

# 2️⃣ Search for content inside files using ripgrep (`rg`)
function rgc
    rg --color=always --line-number "$argv" | fzf --ansi --preview "bat --style=numbers --color=always --line-range=:100 {1}"
end

# 3️⃣ Advanced search using ripgrep-all (`rga`) for PDFs, docs, etc.
function rga_search
    rga --color=always --line-number "$argv" | fzf --ansi --preview "bat --style=numbers --color=always --line-range=:100 {1}"
end

# 4️⃣ Fast file search using `fd`
function fdf
    fd . "$argv" --type file --hidden --exclude .git | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}"
end

# 5️⃣ Search for directories using `fd`
function fdd
    fd . "$argv" --type d --hidden --exclude .git | fzf --preview "tree -C {} | head -50"
end

# 6️⃣ Fuzzy search & open files
function fo
    set file (fd . --type file | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}")
    if test -n "$file"
        $EDITOR $file
    end
end

### 📂 FILE & DIRECTORY NAVIGATION ###

# 7️⃣ Quickly navigate directories
function cdf
    set dir (fd . --type d --hidden --exclude .git | fzf --preview "tree -C {} | head -50")
    if test -n "$dir"
        cd "$dir"
    end
end

# 8️⃣ Open a directory in Finder (macOS)
function finder
    open .
end

### 🗑️ FILE MANAGEMENT FUNCTIONS ###

# 9️⃣ Move files to trash (requires `trash-cli`)
function fdtrash
    fd . "$argv" --type file | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}" | xargs trash-put
end

# 🔟 Remove files safely with confirmation
function rmf
    set file (fd . --type file | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}")
    if test -n "$file"
        echo "⚠️ Are you sure you want to delete '$file'? (y/N)"
        read -l confirm
        if test "$confirm" = y
            rm -rf "$file"
        else
            echo "Canceled."
        end
    end
end

### 🔄 GIT & FILE TRACKING ###

# 1️⃣1️⃣ Search git-tracked files
function gitf
    git ls-files | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}"
end

# 1️⃣2️⃣ Search untracked git files
function gituf
    git ls-files --others --exclude-standard | fzf --preview "bat --style=numbers --color=always --line-range=:100 {}"
end

# 1️⃣3️⃣ Git commit browser
function gitlog
    git log --oneline --graph --decorate --all | fzf --preview "git show --color=always {1}"
end

# 1️⃣4️⃣ Git branch selection
function gitbranch
    set branch (git branch | fzf)
    if test -n "$branch"
        git checkout "$branch"
    end
end

# Reload Fish configuration
function reload
    source ~/.config/fish/config.fish
    echo "🔄 Fish configuration reloaded!"
end
