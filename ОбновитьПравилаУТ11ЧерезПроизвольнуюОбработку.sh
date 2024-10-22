gitRepoName="UT11TTT"
gitCatPath="/d/Общая/git/rep/$gitRepoName"

DefaultCommit="Обновление правил УТ11"
RulesCatPath="/d/Общая/Кд3Обмены/Правила"
RulesFileName="МенеджерОбмена.txt"
DefaultEPFPath="/d/Общая/Кд3Обмены/Правила/КЗ/Рабочие/МнЖОбменаУт11Разработка.epf"

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

read -e -p 'Текст коммита(номер запроса): ' -i "$DefaultCommit" commit

#echo $EPFPath

#В ИФ через И докинуть cp
#Мб имеет смысл выгружать результат разбора в отдельный подкаталог чтоб они перезатирались?
if /d/1с/Очоба/OS/РазборОбработкиНаИсходникиЧерезКонфигуратор.sh "$gitCatPath" "$EPFPath" "$(pwd)\out.txt"; then
	
	cd "$gitCatPath"
	cp $(find "$gitCatPath" -name '*.bsl') "$RulesFileName";

	oscript /d/1с/Очоба/OS/РазборПравилОбмена.os "$gitCatPath/$RulesFileName" "$gitRepoName"

	cd "$gitCatPath/$gitRepoName"
	#а ее может и не быть
	git switch 'dev'
	git add . 
	git commit -m "$commit"
else 
	echo $?
fi

$SHELL