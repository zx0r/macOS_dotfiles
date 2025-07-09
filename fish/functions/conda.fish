function conda -d 'Initialize conda'
    # Remove any existing conda function
    functions -e conda

    if test -e ~/conda/bin/conda
        set -gx PATH ~/conda/bin $PATH

        # Initialize conda for the current shell session
        # eval command conda "shell.fish" hook | source
        eval (conda shell.fish hook)
    end

    # Override the __conda_add_prompt function to do nothing
    # This prevents conda from modifying the prompt (as it's handled by starship)
    function __conda_add_prompt
    end

    # Execute conda with the provided arguments
    conda $argv
end


# function conda
#     # Remove any existing conda function
#     functions -e conda
#
#     set -l conda_path "$HOME/miniconda3/bin/conda"
#     set -l conda_fish_conf "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
#     set -l mamba_fish_conf "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"
#
#     if test -f $conda_path
#         eval $conda_path "shell.fish" hook $argv | source
#     else if test -f $conda_fish_conf
#         source $conda_fish_conf
#     else
#         set -gx PATH "$HOME/miniconda3/bin" $PATH
#     end
#
#     if test -f $mamba_fish_conf
#         source $mamba_fish_conf
#     end
#
#     # Override the __conda_add_prompt function to do nothing
#     # This prevents conda from modifying the prompt (as it's handled by starship)
#     function __conda_add_prompt
#     end
#
#     # Execute conda with the provided arguments
#     command conda $argv
# end

# Conda and Mamba configurations
# test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"; and source "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
# test -f "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"; and source "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"



# function mamba
#     conda $argv
# end
#
