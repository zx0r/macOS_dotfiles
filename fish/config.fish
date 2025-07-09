# NOTE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

#  ███████ ██ ███████ ██   ██
#  ██      ██ ██      ██   ██
#  █████   ██ ███████ ███████
#  ██      ██      ██ ██   ██
#  ██      ██ ███████ ██   ██
#
#  Author       : zx0r
#  License      : MIT License
#  Description  : Stay hungry; Stay foolish
#  Contact Info : https://github.com/zx0r/hyprdots-gentoo

# set -gx PATH /Applications/phpmon.app/Contents/MacOS/ $PATH
# fish_add_path "/Users/x0r/.composer/vendor/bin"

# Flush DNS on Yosemite
abbr flush "sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

fish_add_path $HOME/.config/composer/vendor/bin
fish_add_path /usr/local/opt/php@8.4/bin
fish_add_path /usr/local/opt/php@8.4/sbin

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
set -Ux debug_mode 0 # Enable debug mode
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Group Management
if test (uname) = Darwin
    set -gx GROUP staff # Safer macOS default
else
    set -gx GROUP users # Standard Linux group
end

# Check if running in a graphical session
# if set -q DISPLAY
#     echo "GUI Mode detected |$DISPLAY|"
#     set -x GPG_TTY (tty)
#     # gpg $argv
# else
#     echo "No GUI detected, using loopback mode."
#     set -x GPG_TTY (tty)
#     # gpg --pinentry-mode loopback $argv
# end

if status is-login
    # 🔹 Fix GPG tty issues
    # set -gx DISPLAY :0
    set -gx GPG_TTY (tty)
    set -gx PINENTRY_USER_DATA "USE_CURSES=1"

    # Check if gpg-agent is running
    if not pgrep -x -u (whoami) gpg-agent >/dev/null
        # If not running, ensure gpg-agent is terminated (cleanup)
        # # 🔹 Ensure gpg-agent is running
        # gpgconf --kill gpg-agent
        # gpg-connect-agent reloadagent /bye
        # gpg-connect-agent updatestartuptty /bye
        #gpgconf --launch gpg-agent
        gpg-connect-agent /bye >/dev/null

        # Start the gpg-agent
        # gpgconf --kill gpg-agent
        # gpg-agent --daemon
        # gpg-connect-agent reloadagent /bye
    end

    # Add this to your fish config file (e.g., ~/.config/fish/config.fish)
    # if test -n "$TMUX"
    #     # Inside tmux, use loopback mode
    #     set -x GPG_TTY $(tty)
    #     export GPG_PINENTRY_MODE="loopback"
    # else
    #     # Outside tmux, use standard pinentry (if you want to use a GUI-based pinentry)
    #     set -x GPG_TTY $(tty)
    #     export GPG_PINENTRY_MODE="ask"
    # end

    # Ensure the directory and its contents are owned by the correct user and group
    # sudo chown -R $USER:staff /Users/x0r/.gnupg

    # Set directory permissions to 700 (only owner can read/write/execute)
    # find /Users/x0r/.gnupg -type d -exec chmod 700 {} +

    # Set file permissions to 600 (only owner can read/write)
    # find /Users/x0r/.gnupg -type f -exec chmod 600 {} +

    # Ensure that the gpg-agent.conf file has the correct permissions
    # chmod 600 /Users/x0r/.gnupg/gpg-agent.conf

    # pkill -f ssh-agent
    # pkill -f gpg-agent

    # 🔹 Start the SSH agent (Fish Shell)
    # ps -ax | grep ssh-agent
    eval (ssh-agent -c) >/dev/null
    # eval "$(ssh-agent -s)" >/dev/null
    # Generate a SSH key pair using ssh-keygen, such as:
    # ssh-keygen -t ed25519 -b 4096 -C "{username@emaildomain.com}" -f ~/.ssh/{ssh-key-name}
    # ssh-add -l || ssh-add ~/.ssh/zx0r@github  # Match generated key type

    # One alternative to satisfy your implied desire to not have decrypted keys available all the time is to turn off both UseKeychain and AddKeysToAgent, as in:
    # Host *
    #   UseKeychain no
    #   AddKeysToAgent no

    # Then, manually add keys to your running ssh-agent with limited lifetimes using the -t <lifetime> option to ssh-add, as in:
    # ssh-add -t 4h ~/.ssh/id_rsa
    # ssh-add --apple-use-keychain ~/.ssh/id_dsa

    # 🔑 Add SSH keys to agent
    # set -l SSH_KEYS (fd '^id_' $SSH_HOME --type f --exclude '*.pub' --absolute-path)
    # fd "$(git config user.name)@github" $SSH_HOME --type f --exclude '*.pub' --absolute-path
    # for key in $SSH_KEYS
    #     ssh-add $key # Add each key to the SSH agent
    # end

    # 🔹 macOS-specific SSH Agent Handling
    # if test (uname) = Darwin
    #     # Use macOS Keychain for SSH keys
    #     set -gx SSH_AUTH_SOCK "$HOME/Library/Containers/com.apple.ssh-agent/Data/ssh-agent.sock"

    #     # Ensure launchctl is aware of the ssh-agent socket
    #     if not test -S $SSH_AUTH_SOCK
    #         launchctl load -w /System/Library/LaunchAgents/org.openbsd.ssh-agent.plist 2>/dev/null
    #     end
    # end

    # 🔹 Check if SSH keys are loaded into the agent
    # if test (ssh-add -l 2>/dev/null | wc -l) -eq 0
    #     echo "🚧 No SSH keys loaded! Run: ssh-add ~/.ssh/<your_id_rsa>"
    # else
    #     ssh-add -l
    # end

    # 🔹 Use GPG agent for SSH if available
    if gpgconf --list-dirs agent-ssh-socket | grep -q /; and test -S (gpgconf --list-dirs agent-ssh-socket)
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    else
        # 🔹 Fallback to ssh-agent if gpg-agent is not available
        if not set -q SSH_AGENT_PID
            eval (ssh-agent -c | tee ~/.ssh/ssh-agent.env) # Start and save env variables
        end
        if test -f ~/.ssh/ssh-agent.env
            source ~/.ssh/ssh-agent.env
        end
    end

    # 🔹 Check if GPG private key for SSH signing is available
    set -l gpg_keys (gpg --list-secret-keys --keyid-format LONG 2>/dev/null | grep -o 'sec' | wc -l)
    if test $gpg_keys -eq 0
        echo "🚧 No GPG private key found for SSH signing!" # Output warning if no GPG key is found
    else
        # 🔹 List and format GPG private key details
        gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print "sec " $2 ": [ultimate]" substr($0, index($0,$2) + length($2))}'
    end

    # # Path to the SSH key (replace with your actual key path)
    # set -l ssh_keys (fd '^id_' $SSH_HOME --type f --exclude '*.pub' --absolute-path)

    # # Set SSH to use gpg-agent (based on 'man gpg-agent', section EXAMPLES)
    # set -e SSH_AGENT_PID

    # # Check if the current SSH_AUTH_SOCK is not pointing to the gpg-agent socket
    # # if not set -q SSH_AUTH_SOCK; or test (gpgconf --list-dirs agent-ssh-socket) != $SSH_AUTH_SOCK
    # #   set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    # # end

    # if not set -q gnupg_SSH_AUTH_SOCK_by
    #     set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    # end

    # # Check if the key file exists
    # if test -f $ssh_keys

    #     # Set owner (u) permissions correctly, remove all for group (g) and others (o)
    #     chmod -R u=rwX,go= $SSH_HOME
    #     fd --type f --exec chmod 600 {} $SSH_HOME
    #     fd --type d --exec chmod 700 {} $SSH_HOME
    #     # ls -l $SSH_HOME  # Verify permissions

    #     # Check if gpg-agent is correctly set up for SSH
    #     if test -z $SSH_AUTH_SOCK
    #         echo "🚧 SSH_AUTH_SOCK is not set! Ensure gpg-agent is running."
    #         return
    #     end

    #     # Add SSH key to gpg-agent
    #     echo "Adding SSH key to gpg-agent..."
    #     ssh-add $ssh_keys
    #     # Add SSH key (uses keychain-stored passphrase)
    #     # ssh-add --apple-use-keychain $ssh_keys # macOS keychain integration

    #     # Check if the key was successfully added
    #     if test (ssh-add -l | wc -l) -gt 0
    #         echo "✅ SSH key successfully added to gpg-agent."
    #     else
    #         echo "🚧 Failed to add SSH key to gpg-agent."
    #     end
    # else
    #     echo "🚧 SSH key not found at $ssh_key_path."
    # end

end

# ━━━━━━━━━━━━━━  Startup Commands ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if status is-interactive

    # Source configurations
    source $XDG_CONFIG_HOME/fish/themes/colorscheme.fish
    source $XDG_CONFIG_HOME/fish/abbr.fish
    source $XDG_CONFIG_HOME/fish/user_variables.fish
end

# ━━━━━━━━━━━━━━  Shell Behavior ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Fish shell performance optimizations
set -g fish_greeting ""
set -g fish_handle_reflow 0
set -g fish_escape_delay_ms 10
set -g fish_cursor_insert line
set -g fish_cursor_visual block
set -g fish_cursor_default underline
set -g fish_prompt_pwd_dir_length 0
set -g fish_key_bindings fish_vi_key_bindings

# Command execution optimization
set -gx fish_command_timer_enabled 1
set -gx async_prompt_functions fish_prompt

# History optimization
set -gx fish_history_max_length 50000
set -gx fish_history_merge_sessions 1

# Command execution optimization
set -g fish_trace_commands 0
set -g fish_command_timer_enabled 0
set -g fish_history_merge_session_only 1
set -gx fish_history global

# Shell state indicators
set -g shell_interactive (status is-interactive)
set -g shell_login (status is-login)
set -g shell_job_control (status job-control full)
set -g shell_restricted (status is-command-substitution)

# SECURITY & PRIVACY
set -gx HISTCONTROL ignoredups # Ignore duplicate commands in history
# set -gx fish_history_global 0 # Disable shared history across sessions
# set -gx fish_private_mode 1 # Prevent writing commands to history in private mode
umask 077 # Restrict default file permissions

# Completion system tuning
fish_delta --no-completions fish_git_prompt
#set -g fish_complete_timeout 0.5
set -g fish_autosuggestion_enabled 1
# set -g fish_complete_patfish /usr/local/share/fish/completions $XDG_CONFIG_HOME/fish/completions
# set -g fish_function_path /usr/local/share/fish/functions $XDG_CONFIG_HOME/fish/functions
set -g __fish_git_prompt_show_informative_status 1 # Better git info

# set fish_complete_path ~/.local/share/fish/plugins/*/completions $fish_complete_path
# set fish_function_path ~/.local/share/fish/plugins/*/functions $fish_function_path
# for plugin in ~/.local/share/fish/plugins/*
#   if test -f $plugin/init.fish
#     source $plugin/init.fish
#   else if test -d $plugin/conf.d
#     for file in $plugin/conf.d/*.fish; source $file; end
#   else
#     for file in $plugin/*.fish; source $file; end
#   end
# end

# Enable vi cursor shapes when using tmux
if string match -q -- 'tmux*' $TERM
    set -g fish_vi_force_cursor 1
end

# ━━━━━━━━━━━━━━ Color Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Icons and colors
# set -gx LS_COLORS $XDG_CONFIG_HOME/colorsdb
set -gx LS_COLORS $XDG_CONFIG_HOME/iconsdb

# GNU ls colors (if using coreutils via Homebrew)
if test -f $XDG_CONFIG_HOME/lscolors.csh
    set -gx LS_COLORS (string replace 'setenv LS_COLORS ' '' < $XDG_CONFIG_HOME/lscolors.csh | string trim -c "'")
end

# Use vivid for modern color generation
# if command -v vivid >/dev/null
#     set -gx LS_COLORS (vivid generate cyberdream) 
# end

# ━━━━━━━━━━━━━━  Functions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Force reload all SSH configs
function sshreload
    pkill -9 ssh-agent
    eval (ssh-agent -c)
    ssh-add $HOME/.ssh/(ls $HOME/.ssh | grep -v .pub)
end

# Remote session editor
if set -q SSH_CONNECTION
    set -gx EDITOR vi
end

# ━━━━━━━━━━━━━━ NODE Management ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# jorgebucaran/nvm.fish
set --universal nvm_default_version latest
set --universal nvm_default_packages npm

# ━━━━━━━━━━━━━━  Set USTC mirror for Rustup ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -x RUSTUP_DIST_SERVER "https://mirrors.ustc.edu.cn/rust-static"
set -x RUSTUP_UPDATE_ROOT "https://mirrors.ustc.edu.cn/rust-static/rustup"

# ━━━━━━━━━━━━━━━ Path Management ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Path optimization
set -g fish_user_paths_first 1

# System paths in order of priority
fish_add_path /bin /sbin /usr/bin /usr/local/bin /usr/local/sbin /usr/local/opt /usr/sbin /usr/lib/go/bin /usr/lib/rustup/bin

# Development tools paths
fish_add_path $ASDF_SHIMS $PYENV_ROOT/bin $BUN_PATH $NODE_PATH $CONDA_PATH $GOROOT/bin $GOBIN $CARGO_HOME/bin

# User and custom paths
fish_add_path $XDG_BIN_HOME $XDG_SCRIPTS_HOME $BOB_HOME $RIPGREP_CONFIG_PATH

# SSL
fish_add_path $OPENSSL_DIR

# Basher
fish_add_path $BASHER_ROOT/.basher/bin $BASHER_ROOT/cellar/bin

# Documentation paths
# fish_add_path $MANPATH $INFOPATH

# Trash-cli
fish_add_path (brew --prefix)/opt/trash/libexec/bin

# GnuPG Stuff
# Override GPG Suite’s Binaries (brew install gnupg) with GPG-Suite pinentry-program
fish_add_path (brew --prefix gnupg)/bin

# fish_add_path (brew --prefix)/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS

# 👆 GPG Suite with Pinetry brew install --cask gpg-suite (GPG Older version.Use Gnupg last version binaries)
# fish_add_path /usr/local/MacGPG2/bin /usr/local/MacGPG2/libexec

# ━━━━━━━━━━━━━━  Comprehensive history ignore patterns

set -U fish_history_ignore '[ ]*' '*--help' 'cd *' c clear 'echo *' 'df *' 'du *' egrep exit 'eza *' head history hostname 'ls*' 'll*' 'man *' pgrep poweroff pwd reboot 'rm *' 'sudo su' tail 'type *' 'touch *' 'uname *' unzip upload uptime useradd 'which *' whois whoami

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Package Management
abbr -a brew_up "brew update && brew upgrade" # Update Homebrew packages
abbr -a brew_clean "brew cleanup && brew autoremove" # Clean unused packages

# System Monitoring
abbr -a mem "vm_stat | awk '{print \$1, \$2}'" # Check memory usage
abbr -a cpu "top -o cpu -stats pid,cpu,command" # Monitor CPU usage

# Git Bare repository
abbr -a dot "git --git-dir=$HOME/.git_bare_repo --work-tree=$HOME"

# Fast directory navigation using fzf
function fzf_cd
    set -l dir (fd --type d | fzf --prompt="Select Directory: ")
    if test -n "$dir"
        cd "$dir"
    end
end

# Secure file removal
# function rmf
#     if test (count $argv) -lt 1
#         echo "Usage: rmf <file>"
#         return 1
#     end
#     shred -u $argv
#     echo "Securely removed $argv"
# end

# if test (uname) = Darwin

#     # Homebrew paths
#     # fish_add_path $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $HOMEBREW_PREFIX/opt

#     abbr -a flushdns "sudo killall -HUP mDNSResponder" # Clear DNS cache
#     abbr -a restart-ui "killall Dock; killall Finder; killall SystemUIServer" # Refresh UI
# end

# Trash-CLI Aliases
#alias rm='trash-put'
alias trlist='trash-list'
alias trempty='trash-empty'
alias trrestore='trash-restore'
alias trrm='trash-rm'

# https://gist.github.com/dfrommi/453f4e2c6635d2965802ac84b88519f5
# ~/.config/fish/conf.d/_krill.fish:
# set krill_path $HOME/.config/fish/krill

# set fish_function_path (find $krill_path -depth 2 -type d -name functions) $fish_function_path
# set fish_complete_path (find $krill_path -depth 2 -type d -name completions) $fish_complete_path

# for file in (find $krill_path -path "*/conf.d/*.fish" -depth 3 -type f)
#     builtin source $file 2> /dev/null
# end

# function reset_launchpad
#     rm ~/Library/Application\ Support/Dock/*.db && killall Dock
#     defaults write com.apple.dock ResetLaunchPad -bool true && killall Dock
# end

# function redis-start
#     $REDIS_HOME/redis-server $REDIS_HOME/redis.conf
#     echo "redis server started on 6379"
# end

# function redis-stop
#     ps -ef | grep redis | grep -v 'grep' | awk '{print $2}' | xargs kill -9
#     echo "redis server stoped"
# end

# function noproxy
#     unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY all_proxy ALL_PROXY
#     echo "clear proxy done"
# end

# http='http://127.0.0.1:7890'
# socks5='socks5://127.0.0.1:7890'

# function proxy
#     set -x http_proxy "$http"
#     set -x HTTP_PROXY "$http_proxy"
#     set -x https_proxy "$http_proxy"
#     set -x HTTPS_PROXY "$https_proxy"
#     set -x all_proxy "$http_proxy"
#     set -x ALL_PROXY "$http_proxy"
#     echo "current proxy is ${http_proxy}"
#     export http_proxy HTTP_PROXY https_proxy HTTPS_PROXY all_proxy ALL_PROXY
# end

function show
    defaults write com.apple.finder AppleShowAllFiles -boolean true
    killall Finder
end

function hide
    defaults write com.apple.finder AppleShowAllFiles -boolean false
    killall Finder
end

# # Set default "New Page" as HTML in TextMate
# defaults write com.macromates.textmate OakDefaultLanguage 17994EC8-6B1D-11D9-AC3A-000D93589AF6

# # Remap "New Folder" to Command+N, "New Finder Window" to Cmd+Shift+N in Mac OS X
# defaults write com.apple.finder NSUserKeyEquivalents -dict 'New Finder Window' '@$N' 'New Folder' '@N'; killall Finder

# # Make the Mac OS X Dock 2D once more (10.5 and above only)
# defaults write com.apple.Dock no-glass -boolean YES; killall Dock

# # Turns hidden applications transparent in the Mac OS X dock.
# defaults write com.apple.Dock showhidden -bool YES

# # use the short username by default for network authentication
# defaults write /Library/Preferences/com.apple.NetworkAuthorization UseShortName -bool YES

# # Stop Mac OSX from creating .DS_Store files when interacting with a remote file server with the Finder
# defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# # Show hidden files
# defaults write com.apple.finder AppleShowAllFiles TRUE

# # Drag A Dashboard Widget Onto OS X Desktop
# defaults write com.apple.dashboard devmode YES

# # Change Mac OS X Login Picture
# defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture "/System/Library/CoreServices/Finder.app/Contents/Resources/vortex.png"

# # Show hidden files in OS X
# defaults write com.apple.Finder AppleShowAllFiles TRUE

# # Disable Mac OS X Dashboard
# defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock

# # Make keyboard keys repeat properly
# defaults write -g ApplePressAndHoldEnabled -bool false

# # Add spacer to left side of Dock
# defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'; killall Dock

# # Add spacer to right side of Dock
# defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'; killall Dock

# # Terminal window focus on mouseover (mimicking X11 behavior) in Mac OS X
# defaults write com.apple.terminal FocusFollowsMouse -string YES

# # Make the Mac OS X Dock 2D once more (10.5 and above only)
# defaults write com.apple.Dock no-glass -boolean YES; killall Dock
# e-modifier -float 0;

# # set dock icons size
# defaults write com.apple.dock tilesize -int 24;

# # set dock icons magnification
# defaults write com.apple.dock magnification -bool true;

# # set dock icons magnification size
# defaults write com.apple.dock largesize -int 36;

# killall Dock;
# #endregion

# #region Keyboard
# # Disable press-and-hold for keys in favor of key repeat
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false;

# # Set a blazingly fast keyboard repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 1;

# # Set a shorter Delay until key repeat
# defaults write NSGlobalDomain InitialKeyRepeat -int 15;
#endregion

#region Screen
# Save screenshots to the desktop
# mkdir -p "${HOME}/Desktop/Screenshots";
# defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots";

# # Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true;

# # set the screensaver to start after 5 minutes
# defaults -currentHost write com.apple.screensaver idleTime -int 300;

# # Require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1;
# defaults write com.apple.screensaver askForPasswordDelay -int 0;
# #endregion

# #region Cursor / Pointer
# # Disable "natural" scrolling
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false;

# # Disable mouse acceleration
# defaults write .GlobalPreferences com.apple.mouse.scaling -1;
# defaults write .GlobalPreferences com.apple.trackpad.scaling -1;
# defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1;

# # enable three finger drag
# defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true;
# #endregion

# #region Mail
# # Copy email addresses as `foo@example.com` instead of `Foo Bar ` in Mail.app
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false;
# #endregionWebKitDeveloperExtrasEnabledPreferenceKey -bool true;
# defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true;

# # Add a context menu item for showing the Web Inspector in web views
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true;
# #endregion

# #region Files
# # Disable the warning when changing a file extension
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;

# # Avoid creating .DS_Store files on network volumes
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;
# #endregion

# #region Security
# # Empty Trash securely by default
# defaults write com.apple.finder EmptyTrashSecurely -bool true;
# #endregion

# #region Dock
# # Automatically hide and show the Dock
# defaults write com.apple.dock autohide -bool true;

# # Remove the auto-hiding Dock delay
# defaults write com.apple.dock autohide-delay -float 0;

# # Remove the animation when hiding/showing the Dock
# defaults write com.apple.dock autohide-tim
# # # Turns hidden applications transparent in the Mac OS X dock.
# # defaults write com.apple.Dock showhidden -bool YES

# # # use the short username by default for network authentication
# # defaults write /Library/Preferences/com.apple.NetworkAuthorization UseShortName -bool YES

# # # Stop Mac OSX from creating .DS_Store files when interacting with a remote file server with the Finder
# # defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# # # Show hidden files
# # defaults write com.apple.finder AppleShowAllFiles TRUE

# # # Drag A Dashboard Widget Onto OS X Desktop
# # defaults write com.apple.dashboard devmode YES

# # # Change Mac OS X Login Picture
# # defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture "/System/Library/CoreServices/Finder.app/Contents/Resources/vortex.png"

# # # Show hidden files in OS X
# # defaults write com.apple.Finder AppleShowAllFiles TRUE

# # # Disable Mac OS X Dashboard
# # defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock

# # # Make keyboard keys repeat properly
# # defaults write -g ApplePressAndHoldEnabled -bool false

# #region Finder
# # Show hidden files in Finder
# defaults write com.apple.finder AppleShowAllFiles -boolean true;

# # Show all filename extensions in Finder
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true;

# # Show status bar in Finder
# defaults write com.apple.finder ShowStatusBar -bool true;

# # Show path bar in Finder
# defaults write com.apple.finder ShowPathbar -bool true;

# # Show the ~/Library folder
# chflags nohidden ~/Library;

# # Show the /Volumes folder
# sudo chflags nohidden /Volumes;

# # Expand save panel by default
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true;

# # Expand print panel by default
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true;

# killall Finder;
# #endregion

# #region Safari
# # Enable Safari's debug menu
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true;

# # Enable the Develop menu and the Web Inspector in Safari
# defaults write com.apple.Safari IncludeDevelopMenu -bool true;
# defaults write com.apple.Safari 
#
# if [ "$OS" = Linux ]
#     then
#     CPU=`more /proc/cpuinfo | grep "^model name" | head -n 1 | cut -d: -f 2`
#     BOARDVENDOR=`sudo dmidecode | grep -A 1 "Base Board" | grep "Manufacturer:" | cut -d: -f 2`
#     BOARD=`sudo dmidecode | grep -A 2 "Base Board" | grep "Product Name:" | cut -d: -f 2`
#     PROCS=`cat /proc/cpuinfo | grep ^processor | wc -l`
#     MEMVENDOR=`sudo dmidecode -t memory | grep "Manufacturer:" | sort | uniq | head -n 1 | cut -d: -f2`
#     MEMTYPE=`sudo dmidecode -t memory | grep "Type:" | cut -d: -f 2 | grep -v None | sort | uniq | head -n 1`
#     MEMSPEED=`sudo dmidecode -t memory | grep "Speed:" | sort | uniq | head -n 1 | cut -d: -f2`
#     MEMPART=`sudo dmidecode -t memory | grep "Part Number" | head -n 1 | cut -d" " -f3`

#     # TODO Handle more than one entry in disklist
#     DISKMODEL=`sudo smartctl -i /dev/${DISKLIST} | egrep "^Model Number|^Device Model" | cut -d":" -f2`
#     DISKFW=`sudo smartctl -i /dev/${DISKLIST} | grep "^Firmware Version" | cut -d":" -f2`

#     DISKGB=`df -B1G | grep ${DISKLIST} | head -n 1 | awk '{print $4}'`
#     MEMGB=`free -h | grep "^Mem:" | awk '{print $2}'`

# 	# Remove possible endings of G or Gi
# 	MEMGB=${MEMGB%"Gi"}
# 	MEMGB=${MEMGB%"G"}

#     elif [ "$OS" = Darwin ]
#     then
#   mySerial=$(system_profiler SPHardwareDataType | grep 'Serial Number' | awk '{print $NF}')
#   currentUser=$( stat -f%Su /dev/console )
#   compHostName=$( scutil --get LocalHostName )
#   timeStamp=$( date '+%Y-%m-%d-%H-%M-%S' )
#   osMajor=$(/usr/bin/sw_vers -productVersion | awk -F . '{print $1}')
#   osMinor=$(/usr/bin/sw_vers -productVersion | awk -F . '{print $2}')
# 	 BOARDVENDOR=`system_profiler SPHardwareDataType | grep "Model Name:" | cut -d":" -f 2`
#     BOARD=`system_profiler SPHardwareDataType | grep "Model Identifier:" | cut -d":" -f 2`
#     CPU=`sysctl machdep.cpu.brand_string | cut -d" " -f 2-`
#     PROCS=`sysctl hw.ncpu | cut -d" " -f 2`
#     MEMGB=`sysctl hw.memsize | awk '{print $2 / 1024 / 1024 / 1024}'`
#     MEMSPEED=`system_profiler SPMemoryDataType | grep "Speed:" | head -n 1 | awk '{print $2}'`
#     MEMTYPE=`system_profiler SPMemoryDataType | grep "Type:" | head -n 1 | awk '{print $2}'`
#     MEMVENDOR=`system_profiler SPMemoryDataType | grep "Manufacturer:" | head -n 1 | cut -d":" -f 2`
#     # Memory part number is often "-", save it regardless.
#     MEMPART=`system_profiler SPMemoryDataType | grep "Part Number:" | head -n 1 | cut -d":" -f 2`
#     DISKMODEL=`system_profiler SPStorageDataType | grep "Device Name:" | head -n 1 | cut -d":" -f 2`
#     DISKGB=`df -g | grep ${DISKLIST} | head -n 1 | awk '{print $2}'`
#     # There doesn't seem to be a way to get at disk firmware on Darwin.
#     # Use the volume type, like "AppleAPFSMedia", instead.
#     DISKFW=`system_profiler SPStorageDataType | grep "Media Name:" | head -n 1 | cut -d":" -f 2`
# else
#     echo Unsupported OS: $OS
#     exit 1
#     fi

# For compilers to find zlib you may need to set:
set -gx LDFLAGS -L/usr/local/opt/zlib/lib
set -gx CPPFLAGS -I/usr/local/opt/zlib/include
set -gx CFLAGS -I/usr/local/opt/zlib/include

# set -gx LDFLAGS "-L/usr/local/opt/zlib/lib -L/usr/local/opt/xz/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/zlib/include -I/usr/local/opt/xz/include"

# For pkg-config to find zlib you may need to set:
set -gx PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig
