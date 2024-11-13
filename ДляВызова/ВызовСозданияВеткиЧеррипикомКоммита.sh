set +o history

gitRepoName=$(basename `git rev-parse --show-toplevel`)

gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" ##Путь к репозиторию KD3Git/Вынести в общие настройки
PathToRepoEditScripts="$gitKD3GitPath/Модули/РаботаСРепозиторием"

gitBranchName=$1

read -e -p 'branch: ' -i "${gitBranchName:-dev}" gitBranchName

git cherry-pick --skip
"$PathToRepoEditScripts/СоздатьВеткуЧерепикомКоммита.sh" "$gitBranchName"

echo "Скрипт завершен, хотите ли вы его перезапустить? (y/n)"
read answer
if [[ $answer == "y" ]]; then
    exec "$0" "$gitBranchName" # Перезапуск самого скрипта
fi
fi

$SHELL