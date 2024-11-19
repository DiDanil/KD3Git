source $(git rev-parse --show-toplevel)/config.sh

set +o history

cd "$gitCatPath"

git rebase HEAD~1
git reset HEAD~1