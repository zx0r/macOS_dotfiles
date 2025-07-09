# Initialize 'thefuck' alias for Fish shell (https://github.com/nvbn/thefuck)
if test -x (command -q thefuck)
    thefuck --alias | source
end
