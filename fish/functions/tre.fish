function tre
    if not command -v tre >/dev/null
        brew install tre-command
    end

    command tre $argv -e; and source /tmp/tre_aliases_$USER ^/dev/null
end
