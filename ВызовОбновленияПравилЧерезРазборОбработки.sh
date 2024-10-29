set +o history

gitRepoName=$(basename `git rev-parse --show-toplevel`)

RulesCatPath="/d/Общая/Кд3Обмены/Правила" ##Где ищем обработку с правилами
gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" ##Путь к репозиторию KD3Git/Вынести в общие настройки

gitBranchName="dev"
commit="Обновление правил $gitRepoName"

cd "$RulesCatPath"

echo "Обработка для разбора"
select fname in $(find . -type f  -name "*.epf" -print0 | xargs -0 -exec ls -t| head -n 10);
do
	if [ -n "$fname" ]; then
		EPFPath="$RulesCatPath/$fname"
		break;
	else
		echo "Неверный выбор. Пожалуйста, попробуйте снова."
    fi
done

read -e -p 'branch: ' -i "$gitBranchName" gitBranchName
read -e -p 'Текст коммита(номер запроса): ' -i "$commit" commit

"$gitKD3GitPath/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit"  "$EPFPath" "$gitKD3GitPath"

$SHELL