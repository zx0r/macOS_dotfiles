# Check if Miniconda (via Miniforge3) is installed, and install it if not
# if not command -q conda
#     set installer_url "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
#     set installer_path "/tmp/install.sh"

#     echo "Conda is not installed. Installing Miniforge now..."
#     # Download and execute the installer
#     curl -fsSLo $installer_path $installer_url
#     chmod +x $installer_path && bash $installer_path -b -p $HOME/conda
# end

# # Install Mamba in the base environment if not already installed
# if not type -q mamba
#     echo "Installing Mamba in the base Conda environment..."
#     conda install -y mamba -n base -c conda-forge
# end

# mamba create -n AI-Disput -c conda-forge jupyterlab pandas numpy matplotlib seaborn tqdm faiss-cpu sentence-transformers PyPDF2 requests
# mamba activate AI-Disput

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/conda/bin/conda
    eval /Users/x0r/conda/bin/conda "shell.fish" hook $argv | source
else
    if test -f "$HOME/conda/etc/fish/conf.d/conda.fish"
        . "$HOME/conda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH $HOME/conda/bin $PATH
    end
end
test -f "$HOME/conda/etc/fish/conf.d/mamba.fish"; and source "$HOME/conda/etc/fish/conf.d/mamba.fish"
# <<< conda initialize <<<

# # Source Conda and Mamba for the Fish shell if their configuration scripts exist
# test -f "$HOME/conda/etc/fish/conf.d/conda.fish"; and source "$HOME/conda/etc/fish/conf.d/conda.fish"
# test -f "$HOME/conda/etc/fish/conf.d/mamba.fish"; and source "$HOME/conda/etc/fish/conf.d/mamba.fish"
