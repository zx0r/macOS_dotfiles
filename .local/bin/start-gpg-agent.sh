#!/usr/bin/env bash

# The configuration will keep your GPG agent running smoothly across all applications!
if [ -f $HOME/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source $HOME/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file $HOME/.gnupg/.gpg-agent-info)
fi

# This line is important for GUI tools to also find it
launchctl setenv GPG_AGENT_INFO $GPG_AGENT_INFO