# Check if 'tig' is installed
function tig_exists
    if not command -v tig >/dev/null
        echo "'tig' is not installed."
        return 1
    end
end

# Open tig in a repository (default: current directory)
function tig_open
    if not tig_exists
        return 1
    end
    tig $argv
end

# View tig log
function tig_log
    if not tig_exists
        return 1
    end
    tig log
end

# View tig status
function tig_status
    if not tig_exists
        return 1
    end
    tig status
end

# Configure tig to use XDG_CONFIG_HOME
function tig_configure
    set -gx TIGRC_PATH "$XDG_CONFIG_HOME/tig/tigrc"
    if test -f $TIGRC_PATH
        echo "Using config: $TIGRC_PATH"
    else
        echo "No tigrc found in $TIGRC_PATH"
    end
end
