# ━━━━━━━━━━━━━━  Plugin Management ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if not functions -q fisher # Initialize Fisher plugin manager
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
