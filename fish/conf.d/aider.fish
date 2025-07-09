# AI ecosystem
# Ensure asdf is installed before proceeding
if not command -q aider tgpt
    echo "🚀 Installing Aider..."
    brew install aider tgpt
end

# Initialize Aider if available
if test -x (command -q aider)
    function run_aider
        aider --deepseek --no-detect-urls --no-auto-commit --yes-always --message "$argv"
    end

    # aider \
    #     --model o3-mini \
    #     --architect \
    #     --reasoning-effort high \
    #     --editor-model sonnet \
    #     --no-detect-urls \
    #     --no-auto-commit \
    #     --yes-always \
    #     --file *.py

    # aider --model groq/deepseek-r1-distill-llama-70b --no-detect-urls --no-auto-commit --yes-always --file *.py --message "$1"

end
