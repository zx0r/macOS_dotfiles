function _lazy_starship --on-event fish_prompt
    starship init fish | source
end

# if test -x (command -q starship)
#     starship init fish | source
# end
