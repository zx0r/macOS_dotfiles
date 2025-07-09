function change_wallpaper
    set -l dir "$HOME/Documents/Wallpapers" # Expand ~ to $HOME
    set -l wallpaper (find $dir -type f | fzf --prompt="Select Wallpaper: ")

    if test -n "$wallpaper"
        # Convert path to absolute POSIX format
        set -l posix_wallpaper (realpath "$wallpaper" | sed 's/ /\\ /g')
        osascript -e "tell application \"System Events\" to set picture of every desktop to \"$posix_wallpaper\""
        echo "Wallpaper changed to: $posix_wallpaper"
    end
end
