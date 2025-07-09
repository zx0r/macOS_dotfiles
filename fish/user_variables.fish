# ━━━━━━━━━━━━━━ System Compatibility & Behavior ━━━━━━━━━━━━━━

# set -gx COMMAND_MODE unix2003 # Ensures UNIX compliance on macOS
# set -gx COPYFILE_DISABLE 1 # Prevents metadata copying (useful for tar, cp)
# set -gx SYSTEM_VERSION_COMPAT 1 # Enables legacy software compatibility
# set -gx BASH_SILENCE_DEPRECATION_WARNING 1 # Silences bash deprecation warnings on macOS

# ━━━━━━━━━━━━━━ iTerm2 Integration ━━━━━━━━━━━━━━

# set -gx ITERM_SHELL_INTEGRATION YES # Enables shell integration for iTerm2  
# set -gx ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX 1 # Enables integration with tmux  

# ━━━━━━━━━━━━━━ Web & Safari Privacy/Security ━━━━━━━━━━━━━━

# set -gx WEBKIT_DISABLE_REMOTE_FONTS 1 # Disables remote fonts for privacy  
# set -gx WEBKIT_DISABLE_NETWORK_CACHE 1 # Ensures fresh page loads, disables cache  
# set -gx WEBKIT_DISABLE_COMPOSITING_MODE 1 # Disables compositing mode for performance  
# set -gx WEBKIT_FORCE_OVERLAY_SCROLLBARS 1 # Forces modern overlay scrollbars  

# ━━━━━━━━━━━━━━ macOS System Preferences ━━━━━━━━━━━━━━

# set -gx NSDocumentSaveNewDocumentsToCloud 0 # Disables default saving to iCloud  
# set -gx NSGlobalDomain AppleKeyboardUIMode 3 # Enables full keyboard access  
# set -gx NSGlobalDomain AppleShowAllExtensions 1 # Always show file extensions  
# set -gx NSGlobalDomain ApplePressAndHoldEnabled 0 # Disable press-and-hold for keys  
# set -gx NSGlobalDomain NSAutomaticCapitalizationEnabled 0 # Disable auto-capitalization  
# set -gx NSGlobalDomain NSAutomaticDashSubstitutionEnabled 0 # Disable smart dashes  
# set -gx NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled 0 # Disable smart quotes  
# set -gx NSGlobalDomain NSAutomaticSpellingCorrectionEnabled 0 # Disable spell check  
# set -gx NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled 0 # Disable auto periods  

# ━━━━━━━━━━━━━━ Display & Performance Optimization ━━━━━━━━━━━━━━

# set -gx NSGlobalDomain AppleFontSmoothing 2 # Adjust font smoothing  
# set -gx NSGlobalDomain NSScrollAnimationEnabled 0 # Disable scroll animations  
# set -gx NSGlobalDomain NSWindowResizeTime 0.001 # Speed up window resizing  
# set -gx NSGlobalDomain NSAutomaticWindowAnimationsEnabled 0 # Disable animations  
# set -gx NSGlobalDomain CGFontRenderingFontSmoothingDisabled 0 # Keep font smoothing enabled  

# ━━━━━━━━━━━━━━ High Refresh Rate Optimizations ━━━━━━━━━━━━━━ 

# set -gx NSHighResolutionCapable 1 # Enable Retina resolution  
# set -gx NSRequiresAquaSystemAppearance 0 # Force dark/light mode per app setting  
# set -gx NSSupportsAutomaticGraphicsSwitching 1 # Allow automatic GPU switching  

# ━━━━━━━━━━━━━━ macOS Apps Customization ━━━━━━━━━━━━━━

# Preview.app  
# set -gx Preview_PVImageDPI 300 # Set high DPI for image previews  
# set -gx Preview_PVImageCompression 0 # Disable image compression  

# # QuickTime Player  
# set -gx QuickTime_QTKitDisableCapture 1 # Disable screen recording capture  

# # TextEdit  
# set -gx TextEdit_RichText 0 # Open files in plain text mode  

# ━━━━━━━━━━━━━━ Security & Privacy Enhancements ━━━━━━━━━━━━━━

set -x NPM_CONFIG_AUDIT true # Enable NPM security audit  
set -x DOCKER_CONTENT_TRUST 1 # Enable Docker image signature verification  

# ━━━━━━━━━━━━━━ Disable Telemetry & Tracking ━━━━━━━━━━━━━━  

set -x DO_NOT_TRACK 1
set -x HINT_TELEMETRY off
set -x SAM_CLI_TELEMETRY 0
set -x DENO_NO_ANALYTICS 1
set -x NEXT_TELEMETRY_DISABLED 1
set -x NUXT_TELEMETRY_DISABLED 1
set -x GATSBY_TELEMETRY_DISABLED 1
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x POWERSHELL_TELEMETRY_OPTOUT 1
set -x AZURE_CORE_COLLECT_TELEMETRY 0

# ━━━━━━━━━━━━━━ Disable History Storage (Privacy) ━━━━━━━━━━━━━━

set -x NODE_REPL_HISTORY "" # Disable Node.js REPL history  
set -x PSQL_HISTORY /dev/null # Disable PostgreSQL history  
set -x LESSHISTFILE /dev/null # Disable less command history  
set -x MYSQL_HISTFILE /dev/null # Disable MySQL history  
set -x SQLITE_HISTORY /dev/null # Disable SQLite history  
set -x PYTHONHISTFILE /dev/null # Disable Python history  
set -x REDISCLI_HISTFILE /dev/null # Disable Redis CLI history  

# # ━━━━━━━━━━━━━━ Language & Locale Settings ━━━━━━━━━━━━━━

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_TIME en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_NUMERIC en_US.UTF-8
set -gx PYTHONIOENCODING UTF-8
set -gx LC_MESSAGES en_US.UTF-8
set -gx LC_MONETARY en_US.UTF-8

# # ━━━━━━━━━━━━━━  Terminal Settings

set -gx TERMINAL kitty

set -gx CLICOLOR 1
set -gx FORCE_COLOR 1
set -gx CLICOLOR_FORCE 1
set -gx TERM xterm-256color
set -gx COLORTERM truecolor
# # set -Ux LSCOLORS gxfxcxdxbxegedabagacad

# # Man/Info
set -gx MANPATH "$HOMEBREW_PREFIX/share/man"
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info"

# ━━━━━━━━━━━━━━ Pager & Text Display Settings ━━━━━━━━━━━━━━

set -gx LESS "-F -g -i -M -R -S -w -X -z-4"
set -gx PAGER less
set -gx MANPAGER "less --no-init --RAW-CONTROL-CHARS"

# ━━━━━━━━━━━━━━ Color Configurations ━━━━━━━━━━━━━━

set -gx FDFIND_COLORS "sp=33:ex=31:fi=32:di=34:ln=35:or=31"
set -gx GREP_COLORS 'mt=1;33:sl=:cx=:fn=35:ln=32:bn=32:se=36'
set -gx EZA_COLORS "di=34:ur=32:uw=31:ux=36:ue=36:gr=33:gw=31:gx=36:tr=33:tw=31:tx=36:uu=38;5;244"

# ━━━━━━━━━━━━━━ VSCode & VSCodium Flags ━━━━━━━━━━━━━━

# set -gx VSCODE_CLI 1
# set -gx VSCODE_DEV 0
# set -gx VSCODE_DEBUG 0
# set -gx VSCODE_PORTABLE 1 # Enables portable mode  
# set -gx VSCODE_CRASH_REPORTER_START_OPTIONS '{"companyName":"","productName":"","uploadToServer":false}'

# ━━━━━━━━━━━━━━ Chromium Flags ━━━━━━━━━━━━━━

# set -gx CHROMIUM_FLAGS "--disable-background-networking --disable-breakpad --disable-crash-reporter --disable-default-apps --disable-domain-reliability --disable-sync --disable-telemetry --no-default-browser-check --no-first-run --no-pings"

# ━━━━━━━━━━━━━━ Mozilla Firefox Flags (macOS) ━━━━━━━━━━━━━━

# set -gx MOZ_DATA_REPORTING 0
# set -gx MOZ_TELEMETRY_REPORTING 0
# set -gx MOZ_CRASHREPORTER_DISABLE 1
# set -gx MOZ_CRASHREPORTER 0
# set -gx MOZ_MAINTENANCE_SERVICE false

# Specific to Linux/Wayland environments and are not needed for macOS
# set -gx MOZ_USE_XINPUT2 1
# set -gx MOZ_DBUS_REMOTE 1
# set -gx EGL_PLATFORM wayland
# set -gx MOZ_ENABLE_WAYLAND 1
# set -gx MOZ_WAYLAND_USE_VAAPI 1
# set -gx MOZ_DISABLE_RDD_SANDBOX 1

# ━━━━━━━━━━━━━━  Electron apps  ━━━━━━━━━━━━━━

# set -gx ELECTRON_ENABLE_LOGGING 0
# set -gx ELECTRON_NO_ATTACH_CONSOLE 1
# set -gx ELECTRON_ENABLE_STACK_DUMPING 0

# ━━━━━━━━━━━━━━ Tmux Configuration ━━━━━━━━━━━━━━

set -gx TMUX_TMPDIR $XDG_RUNTIME_DIR
set -gx TMUX_CONFIG_HOME "$XDG_CONFIG_HOME/tmux"
set -gx TMUX_PLUGIN_MANAGER_PATH "$XDG_DATA_HOME/tmux/plugins"
# set -gx TMUXINATOR_CONFIG_HOME "$XDG_CONFIG_HOME/tmux/tmuxinator"  

# ━━━━━━━━━━━━━━ Browser & Notebook Settings ━━━━━━━━━━━━━━

set -gx BROWSER Safari
set -gx BROWSERCLI w3m
set -gx NOTEBOOK obsidian
# set -gx XDG_NOTEBOOK_HOME "$HOME/notebook"  

# ━━━━━━━━━━━━━━ Development Tools Configuration ━━━━━━━━━━━━━━

# ghq
set -Ux GHQ_ROOT $HOME/projects
# set -gx GIT_CONFIG "$XDG_CONFIG_HOME/git/.gitconfig"  

# Git User Config (Defaults to global settings if available)  
# set -gx GIT_USER_NAME_GLOBAL (git config --global user.name)  
# set -gx GIT_USER_EMAIL_GLOBAL (git config --global user.email)  

# Define default author and committer details  
# set -gx GIT_AUTHOR_NAME "Your Name"  
# set -gx GIT_AUTHOR_EMAIL "your.email@example.com"  
# set -gx GIT_COMMITTER_NAME "Your Name"  
# set -gx GIT_COMMITTER_EMAIL "your.email@example.com"  

# ━━━━━━━━━━━━━━ Git Security & Behavior ━━━━━━━━━━━━━━  

set -gx GIT_ASKPASS "" # Disable GUI password prompts
set -gx GIT_SSL_NO_VERIFY 0 # Enforce SSL verification

# Git Performance  
set -gx GIT_DISCOVERY_ACROSS_FILESYSTEM 0 # Prevent scanning outside the repo  

# Git Colors  
set -gx GIT_TERMINAL_PROMPT 1
set -gx GIT_PS1_SHOWDIRTYSTATE 1
set -gx GIT_PS1_SHOWSTASHSTATE 1
set -gx GIT_PS1_SHOWUNTRACKEDFILES 1

# Git Behavior  
set -gx GIT_MERGE_AUTOEDIT no # Disable auto-edit in merge  
set -gx GIT_COMPLETION_CHECKOUT_NO_GUESS 1 # Prevent checkout guessing  
set -gx GIT_PAGER "less -FX" # Optimize pager for Git  

# Git Debugging & Tracing (Disabled by default)  
set -gx GIT_TRACE 0
set -gx GIT_TRACE_CURL 0
set -gx GIT_TRACE_SETUP 0
set -gx GIT_TRACE_PACKET 0
set -gx GIT_TRACE_SHALLOW 0
set -gx GIT_TRACE_PACK_ACCESS 0
set -gx GIT_TRACE_PERFORMANCE 0
set -gx GIT_TRACE_CURL_NO_DATA 0

# ━━━━━━━━━━━━━━ Tig: text-mode interface for Git ━━━━━━━━━━━━━━

set -gx TIGRC_USER "$XDG_CONFIG_HOME/tig/tigrc"

# # ━━━━━━━━━━━━━━ Development Environments ━━━━━━━━━━━━━━

# set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"

# Databese 
# set -gx REDIS_HOME ~/develop/redis
# set -gx MONGODB_HOME ~/develop/mongodb
# fish_add_path $MONGODB_HOME/bin $REDIS_HOME

# ━━━━━━━━━━━━━━ Language-Specific Paths ━━━━━━━━━━━━━━  

# Go
set -gx GOROOT "$(go env GOROOT)"
set -gx GOPATH "$(go env GOPATH)"
set -gx GOBIN "$(go env GOBIN)"
set -gx GO111MODULE on
set -gx GOPROXY "https://goproxy.cn,direct"
set -gx GOSUMDB "sum.golang.google.cn"
set -gx GOPRIVATE "gitlab.51idc.com,git.code.oa.com"

# Node
set -gx BUN_PATH "$HOME/.bun/bin"
set -gx NODE_PATH "$HOME/.npm-global/bin"

# set -gx CARGO_HOME "$HOME/.cargo"
# set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
# set -gx LUAROCKS_CONFIG "$XDG_CONFIG_HOME/luarocks/config.lua"

# # ━━━━━━━━━━━━━━ Python Environment ━━━━━━━━━━━━━━  

# Set ASDF environment variables
# set -gx ASDF_DIR (brew --prefix asdf)
# set -gx ASDF_DATA_DIR $HOME/.asdf
# set -gx ASDF_SHIMS $ASDF_DATA_DIR/shims
# set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc

# # Set Pyenv root directory only if not already set
# set -gx PYENV_ROOT "$HOME/.pyenv"
# set -Ux PIPENV_VENV_IN_PROJECT 1
# set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"

# set -gx CONDA_PATH "$HOME/miniconda3/bin
# set -gx CONDA_HOME "$XDG_CONFIG_HOME/conda/condarc"
# set -gx PIP_LOG_FILE "$XDG_DATA_HOME/pip/log"  
# set -gx PIP_CONFIG_FILE "$XDG_CONFIG_HOME/pip/pip.conf"  

# set -gx WORKON_HOME "$XDG_DATA_HOME/virtualenvs"  

# # ━━━━━━━━━━━━━━ Media & Utilities ━━━━━━━━━━━━━━  

# set -gx W3M_DIR "$XDG_DATA_HOME/w3m"  
# set -gx FFMPEG_DATADIR "$XDG_CONFIG_HOME/ffmpeg" 

# ━━━━━━━━━━━━━━ Editor & X11 ━━━━━━━━━━━━━━  

set -gx XINITRC "$HOME/.xinitrc"
set -gx NVIM_HOME "$XDG_CONFIG_HOME/nvim-profiles/nvim"
set -gx NVIMRC "$NVIM_HOME/init.lua"

# ━━━━━━━━━━━━━━ Tools & Utilities ━━━━━━━━━━━━━━  

set -gx BOB_HOME "$XDG_DATA_HOME/bob/nvim-bin"
set -gx BOB_CONFIG "$XDG_CONFIG_HOME/bob/config.json"
set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# The terminal starts to slow down
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

# ━━━━━━━━━━━━━━ Security & Network ━━━━━━━━━━━━━━  

set -gx GNUPGHOME "$HOME/.gnupg"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -gx CURL_HOME "$XDG_CONFIG_HOME/curl/curlrc"
# set -gx LYNX_CFG "$XDG_CONFIG_HOME/lynx/lynx.cfg"

# ━━━━━━━━━━━━━━ OpenSSL (Find Latest Version) ━━━━━━━━━━━━━━  

# set -gx OPENSSL_PREFIX (brew --prefix openssl@3)
# set -gx OPENSSL_INCDIR "$OPENSSL_PREFIX/include"
# set -gx OPENSSL_LIBDIR "$OPENSSL_PREFIX/lib"
# set -gx OPENSSL_DIR "$OPENSSL_PREFIX/bin"
# set -gx LDFLAGS "-L$OPENSSL_LIBDIR"
# set -gx CPPFLAGS "-I$OPENSSL_INCDIR"
# set -gx SSL_CERT_FILE (brew --prefix)/etc/ca-certificates/cert.pem

# ━━━━━━━━━━━━━━ Task Management ━━━━━━━━━━━━━━  

set -gx TASKRC "$XDG_CONFIG_HOME/task/taskrc"
set -gx TASKDATA "$XDG_CONFIG_HOME/task"
set -gx TASKOPENRC "$XDG_CONFIG_HOME/taskopen/taskopenrc"
set -gx TIMEWARRIORDB "$XDG_DATA_HOME/timewarrior/tw.db"

# ━━━━━━━━━━━━━━ Debugging (Uncomment if needed) ━━━━━━━━━━━━━━  

# set -gx STARSHIP_LOG error # Enable Starship logging  

# ━━━━━━━━━━━━━━  🛡️ Safe rm Configuration for Fish ━━━━━━━━━━━━━━ 

# brew install trash
set -gx TRASHDIR "$HOME/.Trash"

# A package manager for shell scripts
# set -gx BASHER_SHELL fish
# set -gx BASHER_ROOT $HOME/.basher
# set -gx BASHER_PREFIX $HOME/.basher/cellar
# set -gx BASHER_PACKAGES_PATH $HOME/.basher/cellar/packages

# ━━━━━━━━━━━━━━  SSH ENVIRONMENT VARIABLES ━━━━━━━━━━━━━━ 

set -gx SSH_HOME "$HOME/.ssh" # Default SSH directory
# set -gx SSH_CONFIG "$SSH_HOME/config" # User-specific SSH configuration
# set -gx SSH_KNOWN_HOSTS "$SSH_HOME/known_hosts" # File storing known host keys
# set -gx SSH_PRIVATE_KEY "$SSH_HOME/github/id_ed25519_github" # Default SSH private key
# set -gx SSH_ALLOWED_SIGNERS "$SSH_HOME/allowed_signers" # Allowed signers file for signing commits
# set -gx SSH_ASKPASS (which sshpass) # GUI prompt for SSH passphrase # brew install sshpass

# ━━━━━━━━━━━━━━  GPG ENVIRONMENT VARIABLES ━━━━━━━━━━━━━━ 

set -gx GNUPGHOME "$HOME/.gnupg" # Default GPG directory
# set -gx GPG_CONF "$GNUPGHOME/gpg.conf" # GnuPG configuration file
# set -gx GPG_AGENT_CONF "$GNUPGHOME/gpg-agent.conf" # GPG Agent configuration
# set -gx GPGSSH_KEY_PRIMARY "$GNUPGHOME/sshcontrol" # Primary SSH key for GPG
# set -gx GPG_KEYRING "$GNUPGHOME/pubring.kbx" # Path to the public keyring
# set -gx GPG_PRIVATE_KEYS "$GNUPGHOME/private-keys-v1.d" # Directory for private keys
# set -gx GPGSSH_ALLOWED_SIGNERS "$GNUPGHOME/allowed_signers" # Allowed signers for GPG-SSH authentication

# ━━━━━━━━━━━━━━  ADDITIONAL VARIABLES (for GPG + SSH integration) ━━━━━━━━━━━━━━ 

# set -gx SSH_GPG_SIGNING_KEY "0CAC2A4E261857AAEBF781333243007017F285DA" # Example GPG key for SSH signing
# set -gx SSH_GPG_SIGNING_OPTION "--local-user $SSH_GPG_SIGNING_KEY" # Use specific key for commit signing

set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/password-store"
