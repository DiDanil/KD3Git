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

if "$PathToDisassemblyScripts/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit"  "$EPFPath" "$gitKD3GitPath" "$gitCatPath"; then
	read -e -p "Запустить скрипт создания ветки? (y/n, по умолчанию n): " answer 
	answer=${answer:-n}  # Если answer пустой (Enter), установить его в "n"
	if [[ $answer == "y" ]]; then 
		cd $initialDir
		./ВызовСозданияВеткиЧеррипикомКоммита.sh "$gitBranchName"
	fi
fi


read -e -p "Скрипт завершен, хотите ли вы его перезапустить? (y/n, по умолчанию y)" answerRestart
answerRestart=${answerRestart:-y}  # Если answer пустой (Enter), установить его в "n"
if [[ $answerRestart == "y" ]]; then
    cd "$initialDir"
	clear
    exec "$0" # Перезапуск самого скрипта
fi
fi


$SHELL