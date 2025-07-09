# Update the LuaRocks path if installed
if test -x (command -q luarocks)
    luarocks path | source
end
