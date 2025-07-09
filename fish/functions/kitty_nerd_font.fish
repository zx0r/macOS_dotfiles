
function install_nerd_fonts
    echo "📂 Creating fonts directory..."
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts

    echo "🌐 Downloading FiraCode Nerd Font..."
    curl -fLo "FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

    if test -f "FiraCode.zip"
        echo "📦 Extracting fonts..."
        unzip -o FiraCode.zip
        rm FiraCode.zip
    else
        echo "❌ Failed to download FiraCode Nerd Font."
        return 1
    end

    echo "🔄 Updating font cache..."
    fc-cache -fv

    echo "🍺 Installing FiraCode Nerd Font via Homebrew..."
    if command -q brew
        brew install --cask font-fira-code-nerd-font
    else
        echo "⚠️ Homebrew is not installed. Skipping..."
    end

    echo "🔍 Verifying installation..."
    fc-list :family | grep -i fira

    font_family FiraMono Nerd Font Mono
    font_family FiraCode Nerd Font Propo

    echo "✅ Installation complete!"
end
