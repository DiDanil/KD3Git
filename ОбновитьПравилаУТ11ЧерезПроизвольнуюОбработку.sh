gitRepoName="testm"
gitBranchName="main"
DefaultCommit="Обновление правил УТ11"

gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" ##Вынести в общие настройки
gitIgnoreDirName="Ignore" ##Вынести в общие настройки/Чет херня какая то

gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил
gitRulesPath="$gitCatPath/ПравилаОбмена" ##Правила обмена разобранные на функции
ResDisassemblyCat="$gitCatPath/Ignore/РезультатРазбораОбработкиНаИсходники" ##Обработка менеджера разобранная на исходники

RulesCatPath="/d/Общая/Кд3Обмены/Срань" ##Где ищем обработку с правилами
RulesFileName="МенеджерОбмена.txt" ##Текстовый файл с менеджером обмена, получается из разбора обработки исходники, передается в разбор на процедуры


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
read -e -p 'Текст коммита(номер запроса): ' -i "$DefaultCommit" commit

mkdir "$gitCatPath/$gitIgnoreDirName" 2>/dev/null
mkdir "$ResDisassemblyCat" 2>/dev/null

#В ИФ через И докинуть cp
#Мб имеет смысл выгружать результат разбора в отдельный подкаталог чтоб они перезатирались?

##																Куда сохранить Что разбирать
if "$gitKD3GitPath/РазборОбработкиНаИсходникиЧерезКонфигуратор.sh" "$ResDisassemblyCat" "$EPFPath" "$(pwd)\out.txt"; then
	
	cd "$ResDisassemblyCat"
	cp $(find "$ResDisassemblyCat" -name '*.bsl') "$RulesFileName";

	oscript "$gitKD3GitPath/РазборПравилОбмена.os" "$ResDisassemblyCat/$RulesFileName" "$gitCatPath/ПравилаОбмена"

	cd "$gitCatPath"
	#а ее может и не быть
	git switch -c "$gitBranchName"
	git add . 
	git commit -m "$commit"
else 
	echo $?
fi

$SHELL