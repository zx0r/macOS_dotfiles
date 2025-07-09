# Ensure asdf is installed before proceeding
if not command -q asdf
    echo "🚀 Installing asdf..."
    brew install asdf
end

# Set ASDF environment variables
set -gx ASDF_DIR (brew --prefix asdf 2>/dev/null)
set -gx ASDF_DATA_DIR $HOME/.asdf
set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc

# Source asdf if it exists
set -l asdf_path "$ASDF_DIR/libexec/asdf.fish"
if test -f "$asdf_path"
    source "$asdf_path"
end

# Ensure shims directory exists and is in PATH
set -l asdf_shims "$ASDF_DATA_DIR/shims"
if not contains $asdf_shims $PATH
    fish_add_path $asdf_shims
end

# Set completions correctly
set -l asdf_completion "$ASDF_DATA_DIR/completions/asdf.fish"
set -l fish_completion "$XDG_CONFIG_HOME/fish/completions/asdf.fish"

mkdir -p $XDG_CONFIG_HOME/fish/completions
if test -f "$asdf_completion"; and not test -L "$fish_completion"
    ln -sf "$asdf_completion" "$fish_completion"
end
