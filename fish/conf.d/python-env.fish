# Python environment configuration (Pyenv & Pipenv)

# Initialize Pyenv if available
if test -x (command -q pyenv)
    pyenv init - | source
end

# Add Pyenv to PATH if the directory exists
if test -d "$PYENV_ROOT/bin"

    # Set Pyenv root directory only if not already set
    set -q PYENV_ROOT || set -gx PYENV_ROOT "$HOME/.pyenv"

    # Ensure Pipenv creates virtual environments inside the project
    set -q PIPENV_VENV_IN_PROJECT || set -Ux PIPENV_VENV_IN_PROJECT 1

    fish_add_path "$PYENV_ROOT/bin"

end
