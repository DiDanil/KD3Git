set +o history
source $(git rev-parse --show-toplevel)/config.sh

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

"$PathToDisassemblyScripts/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit"  "$EPFPath" "$gitKD3GitPath"

$SHELL