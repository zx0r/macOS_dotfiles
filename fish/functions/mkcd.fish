# Create and jump to dir
function mkcd
    mkdir -p $argv && cd $argv
end
