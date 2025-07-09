# Basic Git Commands
abbr -a g git
abbr -a ga "git add"
abbr -a gaa "git add --all"
abbr -a gc "git commit -m"
abbr -a gca "git commit --amend"
abbr -a gcm "git commit -m (date '+%Y-%m-%d')"
abbr -a gs "git status"
abbr -a gsh "git show"
abbr -a gb "git branch"
abbr -a gba "git branch -a"
abbr -a gco "git checkout"
abbr -a gcb "git checkout -b"
abbr -a gm "git merge"
abbr -a gmt "git mergetool"
abbr -a gp "git push"
abbr -a gpf "git push --force"
abbr -a gpl "git pull"
abbr -a gcl "git clone"

# Stash Management
abbr -a gst "git stash"
abbr -a gstp "git stash pop"
abbr -a gsta "git stash apply"
abbr -a gstl "git stash list"
abbr -a gstd "git stash drop"

# Log & History
abbr -a gl "git log --oneline --graph --decorate --all"
abbr -a glp "git log -p"
abbr -a gls "git log --stat"
abbr -a glg "git log --graph --pretty=format:'%C(auto)%h %C(blue)%d %C(reset)%s %C(green)(%cr) %C(bold blue)<%an>%C(reset)'"
abbr -a glf "git log --pretty=format:'%h %s' --graph"
abbr -a gld "git log --since='1 week ago'"

# git checkout e45b9a2811ee65ff755bf30366032bbf7ecda150
# git archive --format=zip --output=commit.zip e45b9a2811ee65ff755bf30366032bbf7ecda150

# Search Commit & Changes
abbr -a gsco "git log --grep"
abbr -a gsf "git log -S"
abbr -a gsd "git diff"
abbr -a gss "git shortlog -sn"

# Diff & Blame
abbr -a gd "git diff"
abbr -a gdc "git diff --cached"
abbr -a gds "git diff --staged"
abbr -a gbl "git blame"
abbr -a gblf "git blame -L"

# Reset & Clean
abbr -a gr "git reset"
abbr -a grh "git reset --hard"
abbr -a grs "git reset --soft HEAD~1"
abbr -a gcln "git clean -fd"

# Rebase
abbr -a grb "git rebase"
abbr -a grba "git rebase --abort"
abbr -a grbc "git rebase --continue"
abbr -a grbi "git rebase -i HEAD~5"

# Tags
abbr -a gt "git tag"
abbr -a gta "git tag -a"
abbr -a gtd "git tag -d"
abbr -a gtp "git push --tags"

# Submodules
abbr -a gsbu "git submodule update --init --recursive"
abbr -a gsbp "git submodule foreach git pull origin master"

# Fetch
abbr -a gf "git fetch"
abbr -a gfa "git fetch --all"
abbr -a gfp "git fetch --prune"

# Cherry-Pick
abbr -a gcp "git cherry-pick"
abbr -a gcpa "git cherry-pick --abort"
abbr -a gcpc "git cherry-pick --continue"

# Git Alias Usage in Fish
# if command -v git >/dev/null
#     echo "Git abbreviations loaded in Fish shell ✅"
# end
