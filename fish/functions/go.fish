function install_go
    echo "🚀 Installing Go on macOS..."

    # Check if Homebrew is installed
    if not type -q brew
        echo "❌ Homebrew is not installed. Install it first: https://brew.sh/"
        return 1
    end

    # Install Go
    brew install go

    # Ensure Go is properly installed
    if not type -q go
        echo "❌ Go installation failed. Check Homebrew installation."
        return 1
    end

    echo "✅ Go installed successfully!"

    # Get Go version
    set -l go_version (go version)
    echo "🛠️ Installed: $go_version"

    # Set environment variables
    echo "🔧 Configuring Go environment variables..."

    set -Ux GOROOT (brew --prefix go)
    set -Ux GOPATH $HOME/.go
    set -Ux GOBIN $GOPATH/bin
    set -Ux PATH $PATH $GOROOT/bin $GOPATH/bin

    # Create Go directories if they don’t exist
    mkdir -p $GOPATH/{bin,src,pkg}

    echo "📂 Created Go workspace at: $GOPATH"

    # Verify installation
    echo "✅ Go installation and configuration complete!"
    echo "🏗️ GOPATH: $GOPATH"
    echo "📌 Run 'go env' to verify configuration."

    # Reload fish shell
    exec fish
end
