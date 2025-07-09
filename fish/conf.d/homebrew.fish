# ━━━━━━━━━━━━━━  Homebrew Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if test (uname) = Darwin

    # https://docs.brew.sh/Manpag
    # macOS Intel-specific configuration for maximum performance, security, and speed

    # https://docs.brew.sh/Shell-Completion
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    # ━━━━━━━━━━━━━━ Homebrew PATH ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    # sudo chown -R $(whoami) /usr/local/*  # For Intel macOS
    # sudo chown -R $(whoami) /opt/homebrew # For Apple Silicon

    # Automatically determine Homebrew prefix (Intel Macs)
    set -gx HOMEBREW_PREFIX (brew --prefix) # /usr/local
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
    set -gx HOMEBREW_TAPS "$HOMEBREW_LIBRARY/Taps"
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_CASKROOM "$HOMEBREW_PREFIX/Caskroom"
    set -gx HOMEBREW_LIBRARY "$HOMEBREW_REPOSITORY/Library"
    set -gx HOMEBREW_LOGS "$HOME/Library/Logs/Homebrew"
    set -gx HOMEBREW_CACHE "$HOME/Library/Caches/Homebrew"
    # set -gx HOMEBREW_DEFAULT_TEMP /private/tmp # RAM disk for temp files

    # Brewfile location PATH
    set -gx HOMEBREW_BREWFILE "$XDG_CONFIG_HOME/brewfile/Brewfile"

    # Brewfile location Remote repo
    # set -gx HOMEBREW_BREWFILE "$XDG_CONFIG_HOME/brewfile/Dropbox"
    # set -gx HOMEBREW_BREWFILE "$XDG_CONFIG_HOME/brewfile/<github-repo>"

    # ━━━━━━━━━━━━━━  SECURITY HARDENING / PRIVACY PROTECTION  ━━━━━━━━━━━━━━━━━━━━━━━━━

    set -gx HOMEBREW_NO_ANALYTICS 1 # Disable telemetry and tracking
    # set -gx HOMEBREW_NO_GITHUB_API 1 # No external API calls 
    set -gx HOMEBREW_ARTIFACT_DOMAIN_NO_FALLBACK 1 # Fail closed on private cache

    set -gx HOMEBREW_CURL_WARNING 1
    set -gx HOMEBREW_CURL_RETRIES 3 # Retry failed downloads
    # set -gx HOMEBREW_CURL_VERBOSE 1 # Verbose download output
    # set -gx HOMEBREW_CURLRC "$HOME/.config/curl/curlrc" # Custom curl config
    set -gx HOMEBREW_FORCE_BREWED_GIT 1 # Use updated git
    set -gx HOMEBREW_FORCE_BREWED_CURL 1 # Use Homebrew's secure curl
    set -gx HOMEBREW_FORCE_VENDOR_RUBY 1 # Use Homebrew's Ruby instead of system
    # set -gx HOMEBREW_DOWNLOAD_ATTEMPTS 5 # Max download attempts
    set -gx HOMEBREW_VERIFY_ATTESTATIONS 1 # Verify bottle provenance
    set -gx HOMEBREW_NO_INSECURE_REDIRECT 1 # Prevent HTTPS→HTTP redirects
    # set -gx HOMEBREW_DISABLE_LOAD_FORMULA 1 # Block untrusted formulae
    # set -gx HOMEBREW_FORMULA_BUILD_NETWORK deny # No network during builds
    # set -gx HOMEBREW_FORMULA_POSTINSTALL_NETWORK deny # No post-install network
    # set -gx HOMEBREW_FORBIDDEN_TAPS "" # Block specific taps
    # set -gx HOMEBREW_FORBIDDEN_CASKS "" # Block dangerous casks
    # set -gx HOMEBREW_FORBIDDEN_FORMULAE "" # Block risky formulae
    # set -gx HOMEBREW_ALLOWED_TAPS "homebrew/core homebrew/cask" # Only allow official taps
    # set -gx HOMEBREW_SSH_CONFIG_PATH "$HOME/.ssh/brew_config" # Isolated SSH config
    # set -gx HOMEBREW_FORBIDDEN_LICENSES "AGPL-3.0" # Block restrictive licenses

    # CA Certificates Configuration
    set -gx HOMEBREW_FORCE_BREWED_CA_CERTIFICATES 1 # Fresh CA certificates
    if test -n "$HOMEBREW_FORCE_BREWED_CA_CERTIFICATES" -a -f "$HOMEBREW_PREFIX/etc/ca-certificates/cert.pem"
        set -gx SSL_CERT_FILE "$HOMEBREW_PREFIX/etc/ca-certificates/cert.pem"
        set -gx GIT_SSL_CAINFO "$HOMEBREW_PREFIX/etc/ca-certificates/cert.pem"
        set -gx GIT_SSL_CAPATH "$HOMEBREW_PREFIX/etc/ca-certificates"
    end

    # ━━━━━━━━━━━━━━  PERFORMANCE OPTIMIZATION  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    set -gx HOMEBREW_BOOTSNAP 1 # Enable Bootsnap caching
    set -gx HOMEBREW_UPDATE_TO_TAG 1 # Use stable versions instead of HEAD
    set -gx HOMEBREW_MAKE_JOBS (nproc) # Parallel compile jobs (sysctl -n hw.ncpu)
    set -gx HOMEBREW_NO_AUTOREMOVE # Enable autoremove
    set -gx HOMEBREW_NO_AUTO_UPDATE # Disable auto-update before commands
    set -gx HOMEBREW_AUTO_UPDATE_SECS 604800 # Weekly auto-update (7 days)
    set -gx HOMEBREW_API_AUTO_UPDATE_SECS 86400 # Daily API check (24h) 
    set -gx HOMEBREW_NO_INSTALL_UPGRADE # Allow install upgrades
    set -gx HOMEBREW_NO_INSTALL_CLEANUP # Enable install cleanup
    set -gx HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK # Check dependents
    set -gx HOMEBREW_CLEANUP_MAX_AGE_DAYS 7 # Aggressive cache cleanup
    set -gx HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 14 # Biweekly full cleanup

    # ━━━━━━━━━━━━━━  DEVELOPER SETTINGS  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # set -gx HOMEBREW_DEBUG 1 # Debug output
    set -gx HOMEBREW_EVAL_ALL 1 # Full formula evaluation
    set -gx HOMEBREW_DEVELOPER 1 # Enable dev mode
    set -gx HOMEBREW_SORBET_RUNTIME 1 # Type checking
    set -gx HOMEBREW_FAIL_LOG_LINES 20 # More failure context
    set -gx HOMEBREW_VERBOSE_USING_DOTS 1 # Progress dots for long tasks
    set -gx HOMEBREW_LIVECHECK_AUTOBUMP 1 # Track autobumped formulae
    set -gx HOMEBREW_DISPLAY_INSTALL_TIMES 1 # Show build metrics

    # ━━━━━━━━━━━━━━  VISUAL CUSTOMIZATION  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    set -gx HOMEBREW_COLOR 1 # Enable color output
    set -gx HOMEBREW_NO_EMOJI # Enable emojis
    set -gx HOMEBREW_NO_ENV_HINTS # Disable env hints
    set -gx HOMEBREW_INSTALL_BADGE "🚀" # Custom success emoji after installs
    set -gx HOMEBREW_UPGRADE_GREEDY 1 # Include greedy casks
    set -gx HOMEBREW_EDITOR $EDITOR # Editor for `brew edit`
    set -gx HOMEBREW_BAT 1 # Syntax highlighting for cat
    set -gx HOMEBREW_BAT_THEME Dracula # Syntax highlighting theme

    # Wrap 'brew' command for Homebrew-file
    # https://homebrew-file.readthedocs.io/en/latest/installation.html
    if test -f (brew --prefix)/etc/brew-wrap.fish
        source (brew --prefix)/etc/brew-wrap.fish
    end

    function _post_brewfile_update
        echo "🦄 Brewfile was updated sucesfully ✅"
    end

    # ━━━━━━━━━━━━━━  SYSTEM INTEGRATION  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    # 1. Create required directories if missing
    if not test -d "$HOME/Applications"
        mkdir -p "$HOME/Applications" || echo "Failed to create $dir" >&2 \
            && chmod 700 "$HOME/Applications"
    end

    # Set Homebrew Cask options with validation
    #set -gx HOMEBREW_CASK_OPTS "--appdir=/Applications --fontdir=$HOME/Library/Fonts --cachedir=$(brew --cache) --require-sha --language=en"
    #set -gx HOMEBREW_CASK_OPTS "--appdir=$HOME/Applications --fontdir=$HOME/Library/Fonts --cachedir=$(brew --cache) --no-quarantine --require-sha --language=en"
    set -gx HOMEBREW_SYSTEM_ENV_TAKES_PRIORITY 1 # System settings first
    set -gx HOMEBREW_QUARANTINE 1
    # set -gx HOMEBREW_NO_QUARANTINE # Disable macOS Gatekeeper quarantine

    # set -gx HOMEBREW_PIP_INDEX_URL "https://pypi.org/simple"
    # set -gx HOMEBREW_BREW_GIT_REMOTE "https://github.com/Homebrew/brew"
    # set -gx HOMEBREW_CORE_GIT_REMOTE "https://github.com/Homebrew/homebrew-core"
    # set -gx HOMEBREW_GITHUB_API_TOKEN "" # Blank unless required
    # set -gx HOMEBREW_DOCKER_REGISTRY_TOKEN "" # Private registry auth
    # set -gx HOMEBREW_DOCKER_REGISTRY_BASIC_AUTH_TOKEN ""

    # set -gx HOMEBREW_API_DOMAIN "" # Private API endpoint
    # set -gx HOMEBREW_ARTIFACT_DOMAIN "http://localhost:8080" # CDN for binaries
    # set -gx HOMEBREW_BOTTLE_DOMAIN "http://localhost:8080" # Official bottle source

end

# ━━━━━━━━━━━━━━  Homebrew Aliases ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Core Concepts
abbr -ag brw_cellar 'brew --cellar'
abbr -ag brw_caskroom 'brew --caskroom'
abbr -ag brw_prefix 'brew --prefix'
abbr -ag brw_keg 'brew --cellar'

# ========================
# Essential Commands
# ========================
abbr -ag bi 'brew install'
abbr -ag bu 'brew uninstall'
abbr -ag bl 'brew list'
abbr -ag bs 'brew search'

# ========================
# Advanced Command Functions
# ========================
function brew_autoremove
    switch "$argv[1]"
        case -n --dry-run
            brew autoremove --dry-run
        case ''
            brew autoremove
        case '*'
            echo "Invalid option: $argv[1]"
    end
end

function brew_cleanup --description 'Enhanced cleanup with options'
    set -l options (fish_opt -s n -l dry-run) (fish_opt -s s -l scrub)
    argparse $options -- $argv

    if set -q _flag_dry_run
        brew cleanup -n $argv
    else if set -q _flag_scrub
        brew cleanup --scrub $argv
    else
        brew cleanup $argv
    end
end

# ========================
# Configuration Helper
# ========================
function brew_config --wraps brew --description 'Show config with filtering'
    brew config | egrep -i "$argv"
end

# ========================
# Dependency Visualization
# ========================
function brew_deps_tree --wraps brew --description 'Show dependency tree'
    brew deps --tree --annotate $argv
end

# ========================
# Analytics Control
# ========================
function brew_analytics
    switch "$argv[1]"
        case on off state
            brew analytics $argv[1]
        case '*'
            echo "Usage: brew_analytics [on|off|state]"
    end
end

# ========================
# Environment Helpers
# ========================
function brew_env --description 'Show Homebrew environment variables'
    set -l brew_vars (set -x | grep HOMEBREW_)
    printf "%s\n" $brew_vars
end

# ========================
# Intelligent Search
# ========================
function brew_desc_search --description 'Enhanced formula/cask search'
    if string match -qr '^/.*/$' -- $argv[1]
        brew desc -s $argv[1]
    else
        brew desc -s "$argv"
    end
end

# ========================
# Completions and Helpers
# ========================

complete -c brew_inspect -f -a "(brew list; brew casks list)"
complete -c brew_safe_upgrade -f -a "(brew leaves)"
complete -c brew_services -f -a "start stop restart"

function brew_help --description 'Show custom command help'
    echo "🍺 Custom Homebrew Commands:"
    echo ---------------------------
    echo "brew_update       - Update, upgrade, and cleanup"
    echo "brew_inspect      - Detailed package inspection"
    echo "brew_safe_upgrade - Safe upgrade with version pinning"
    echo "brew_doctor_plus  - Enhanced system diagnostics"
    echo "brew_outdated     - Formatted outdated packages list"
    echo "brew_services     - Service management with tree view"
end

# ========================
# Core Maintenance Functions
# ========================

function brew_update --description 'Update Homebrew and cleanup'
    argparse -n brew_update v/verbose q/quiet -- $argv || return

    echo "🍺 Starting Homebrew maintenance..."

    # Update process
    if set -q _flag_quiet
        brew update >/dev/null
    else
        brew update
    end

    # Upgrade process
    echo "➡️ Upgrading installed packages..."
    if set -q _flag_quiet
        brew upgrade --quiet
    else
        brew upgrade
    end

    # Cleanup process
    echo "🧹 Cleaning up..."
    brew cleanup

    # Check for problems
    echo "🩺 Running health check..."
    brew doctor

    if test $status -eq 0
        echo "✅ System healthy"
    else
        echo "⚠️  Issues detected - run 'brew doctor' manually"
    end
end

# ========================
# Package Inspection
# ========================

function brew_inspect --description 'Inspect package details'
    argparse -n brew_inspect f/formula c/cask -- $argv || return

    if not set -q argv[1]
        echo "Usage: brew_inspect [--formula|--cask] <package>"
        return 1
    end

    set package $argv[1]

    echo "🔍 Inspecting $package:"
    echo ------------------------

    # Basic info
    if set -q _flag_formula
        brew info $package
        echo "\nDependencies:"
        brew deps --tree $package
    else if set -q _flag_cask
        brew info --cask $package
        echo "\nArtifact info:"
        brew --cask $package cat | grep -E 'url|sha256|version'
    else
        brew info $package
    end

    # Analytics
    echo "\n📊 Install analytics:"
    brew analytics (string replace -r 'homebrew/' '' $package)

    # Service status (for formulae with services)
    if brew services list | grep -q $package
        echo "\n🛎️  Service status:"
        brew services info $package
    end
end

# ========================
# Advanced Upgrade Control
# ========================

function brew_safe_upgrade --description 'Safe package upgrade with backup'
    argparse -n brew_safe_upgrade d/dry-run 'k/keep=' -- $argv || return

    if not set -q argv[1]
        echo "Usage: brew_safe_upgrade [--dry-run] [--keep DAYS] <package>"
        return 1
    end

    set package $argv[1]
    set keep_days (set -q _flag_keep; and echo $_flag_keep; or echo 7)

    echo "🔄 Preparing to upgrade $package"

    # Backup current version
    set current_version (brew list --versions $package | cut -d ' ' -f 2)
    echo "📦 Current version: $current_version"

    if not set -q _flag_dry_run
        brew upgrade $package

        set new_version (brew list --versions $package | cut -d ' ' -f 2)

        if test "$current_version" != "$new_version"
            echo "✅ Successfully upgraded to $new_version"
            echo "⏳ Old versions will be kept for $keep_days days"
            brew pin $package@$current_version
        else
            echo "ℹ️  No new version available"
        end
    else
        echo "⚠️  Dry run: Would upgrade $package (current: $current_version)"
    end
end

# ========================
# Diagnostic Tools
# ========================

function brew_doctor_plus --description 'Enhanced system diagnostics'
    echo "🩺 Running basic health check..."
    brew doctor

    echo "\n🧪 Additional checks:"

    # Check for common issues
    set -l issues 0

    # Check for outdated pip packages
    if command -v pip3 >/dev/null
        echo "🐍 Checking Python packages:"
        pip3 list --outdated
    end

    # Check Node.js packages
    if command -v npm >/dev/null
        echo "📦 Checking global npm packages:"
        npm outdated -g
    end

    # Check Ruby gems
    if command -v gem >/dev/null
        echo "💎 Checking Ruby gems:"
        gem outdated
    end

    # System permissions check
    echo "\n🔒 Permission checks:"
    for dir in (brew --prefix)/* /usr/local/*
        if not test -w $dir
            echo "⚠️  No write permissions: $dir"
            set issues (math $issues + 1)
        end
    end

    if test $issues -eq 0
        echo "✅ No permission issues found"
    end
end

# ========================
# Utility Functions
# ========================

function brew_outdated --description 'List outdated packages with details'
    echo "📅 Outdated packages:"
    brew outdated --verbose | awk '
        BEGIN { printf "%-25s %-15s %-15s\n", "Package", "Current", "Latest" }
        { printf "%-25s %-15s %-15s\n", $1, $3, $4 }
    '

    echo "\n🍺 Cask updates:"
    brew outdated --cask --verbose | awk '
        { printf "%-25s %-15s %-15s\n", $1, $3, $4 }
    '
end

function brew_services --description 'Manage services with visual tree'
    argparse -n brew_services t/tree -- $argv || return

    if set -q _flag_tree
        brew services list | awk '
            NR==1 { print "🛎️  Active Services" }
            NR>1 { printf "%-20s %-15s %s\n", $1, $2, $3 }
        '

        echo "\n🌳 Dependency tree:"i
        brew deps --tree --installed
    else
        brew services $argv
    end
end

function brew_fix
    brew update-reset
    brew upgrade
    brew outdated
    brew cleanup -s
    brew doctor
end

# Regular maintenance function
function brew_maintain
    brew update
    brew upgrade
    brew autoremove
    brew cleanup -s
end
