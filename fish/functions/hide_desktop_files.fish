function hide_desktop_files --description "Hide or unhide files on the Desktop for macOS"
    # Check if files are currently hidden
    if test (defaults read com.apple.finder CreateDesktop) -eq 0
        # Files are hidden, so unhide them
        defaults write com.apple.finder CreateDesktop -bool true
        echo "Desktop files are now Visible."
    else
        # Files are visible, so hide them
        defaults write com.apple.finder CreateDesktop -bool false
        echo "Desktop files are now Hidden."
    end

    # Restart Finder to apply changes
    killall Finder
end
