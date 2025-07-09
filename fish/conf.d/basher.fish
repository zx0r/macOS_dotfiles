if test -x (command -q basher)
    # Initialize Basher in Fish
    status --is-interactive; and . (basher init - fish | psub)

    # Update Basher
    # echo "Updating Basher..."
    # cd $HOME/.basher; and git pull
end

# if not command -v basher
#     # brew install bash coreutils

#     # Install Basher
#     # echo "Installing Basher..."
#     #  curl -s https://raw.githubusercontent.com/basherpm/basher/master/install.sh | bash

#     # Ensure Basher directory exists
#     if test -d $HOME/.basher
#         set -gx BASHER $HOME/.basher/bin
#         fish_add_path $BASHER
#         fish_add_path $BASHER_ROOT/cellar/bin

#         # set -gx BASHER_SHELL fish
#         # set -gx BASHER_ROOT $HOME/.basher
#         # set -gx BASHER_PREFIX $HOME/.basher/cellar
#         # set -gx BASHER_PACKAGES_PATH $HOME/.basher/cellar/packages

#         source "$BASHER_ROOT/completions/basher.fish"

#         echo "Basher installed successfully."
#     else
#         echo "Error: Basher installation failed."
#         return 1
#     end

#     # Initialize Basher in Fish
#     status --is-interactive; and . (basher init - fish | psub)

#     # Update Basher
#     echo "Updating Basher..."
#     cd $HOME/.basher; and git pull

#     # Install additional Basher packages
#     # echo "Installing additional Basher packages..."
#     # basher install sstephenson/bats
#     # basher install bitbucket.org/user/repo_name

#     echo "Basher installation and setup complete."
# end
