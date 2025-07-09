# Load encrypted environment variables
if test -f $HOME/.env.gpg
    chmod 600 ~/.env.gpg
    set -gx SECRETS (gpg --decrypt $HOME/.env.gpg)
    eval $SECRETS
end

# if test -f $HOME/.env.gpg
#     gpg --decrypt --quiet --batch --yes $HOME/.env.gpg | while read -l line
#         if string match -rq '^[A-Za-z_][A-Za-z0-9_]*=.*$' -- $line
#             set -gx (string split "=" -- $line)[1] (string split "=" -- $line)[2]
#         end
#     end
# end

# Development environment variables
if test -f $HOME/.env
    source $HOME/.env
end
