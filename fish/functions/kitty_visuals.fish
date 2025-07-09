function kitty_visuals
    set -l KITTY_CONF "$XDG_CONFIG_HOME/kitty/kitty.conf"

    function update_kitty
        echo "Reloading Kitty configuration..."
        kitty @ set-colors --all --configured
    end

    function set_blur
        set -l blur_level (echo -e "off\nlow\nmedium\nhigh" | fzf --prompt="Select Blur Level: ")
        if test -n "$blur_level"
            echo "Setting blur to $blur_level..."
            sed -i '' -E "s/^background_blur\s+.*/background_blur $blur_level/" $KITTY_CONF
            update_kitty
        end
    end

    function set_opacity
        set -l opacity (seq 0.1 0.1 1 | fzf --prompt="Select Opacity: ")
        if test -n "$opacity"
            echo "Setting opacity to $opacity..."
            sed -i '' -E "s/^background_opacity\s+.*/background_opacity $opacity/" $KITTY_CONF
            update_kitty
        end
    end

    function set_theme
        set -l theme (ls $XDG_CONFIG_HOME/kitty/themes | fzf --prompt="Select Theme: ")
        if test -n "$theme"
            echo "Setting theme to $theme..."
            sed -i '' -E "s/^include themes\/.*/include themes\/$theme/" $KITTY_CONF
            update_kitty
        end
    end

    function set_wallpaper
        set -l wallpaper (find ~/Pictures/Wallpapers -type f | fzf --prompt="Select Wallpaper: ")
        if test -n "$wallpaper"
            echo "Setting wallpaper to $wallpaper..."
            sed -i '' -E "s|^background_image\s+.*|background_image $wallpaper|" $KITTY_CONF
            update_kitty
        end
    end

    function set_macos_keys
        echo "Applying macOS keybindings..."
        echo "
map cmd+c copy_to_clipboard
map cmd+v paste_from_clipboard
map cmd+t new_tab
map cmd+n new_window
map cmd+w close_tab
map cmd+q quit
" >>$KITTY_CONF
        update_kitty
    end

    set -l choice (echo -e "Blur\nOpacity\nTheme\nWallpaper\nmacOS Keybindings" | fzf --prompt="Choose Option: ")

    switch $choice
        case Blur
            set_blur
        case Opacity
            set_opacity
        case Theme
            set_theme
        case Wallpaper
            set_wallpaper
        case "macOS Keybindings"
            set_macos_keys
        case '*'
            echo "No valid selection."
    end
end
