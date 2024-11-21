set +o history
source $(git rev-parse --show-toplevel)/config.sh

gitBranchName=$1

cd $gitCatPath

read -e -p 'branch: ' -i "${gitBranchName:-dev}" gitBranchName

git cherry-pick --skip
"$PathToRepoEditScripts/СоздатьВеткуЧерепикомКоммита.sh" "$gitBranchName"

echo "Скрипт завершен, хотите ли вы его перезапустить? (y/n)"
read answer
if [[ $answer == "y" ]]; then
    cd "$initialDir"
    exec "$0" "$gitBranchName" # Перезапуск самого скрипта
fi
fi

$SHELL