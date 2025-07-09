# Direnv integration (macOS optimized)
if test -x (command -v direnv)
    direnv hook fish | source
end
