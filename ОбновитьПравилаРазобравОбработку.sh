
gitRepoName=$1 ##Имя репозитория
gitBranchName=$2
commit=$3 ##Комментарий коммита
EPFPath=$4 ##Обработка менеджера
gitKD3GitPath=$5 ##Путь к репозиторию KD3Git/Вынести в общие настройки



gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" 
gitIgnoreDirName="Ignore" ##Вынести в общие настройки/Чет херня какая то

gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил
gitRulesPath="$gitCatPath/ПравилаОбмена" ##Правила обмена разобранные на функции
ResDisassemblyCat="$gitCatPath/Ignore/РезультатРазбораОбработкиНаИсходники" ##Обработка менеджера разобранная на исходники


RulesFileName="МенеджерОбмена.txt" ##Текстовый файл с менеджером обмена, получается из разбора обработки исходники, передается в разбор на процедуры


##cd "$RulesCatPath"

mkdir "$gitCatPath/$gitIgnoreDirName" 2>/dev/null
rm -r "$ResDisassemblyCat" 2>/dev/null
mkdir "$ResDisassemblyCat" 2>/dev/null

#В ИФ через И докинуть cp
#Мб имеет смысл выгружать результат разбора в отдельный подкаталог чтоб они перезатирались?

##																Куда сохранить Что разбирать
if "$gitKD3GitPath/РазборОбработкиНаИсходникиЧерезКонфигуратор.sh" "$ResDisassemblyCat" "$EPFPath" "$(pwd)\out.txt"; then
	
	cd "$gitCatPath"
	git pull origin "$gitBranchName" ##??? / заменить origin на переменную
	
	cd "$ResDisassemblyCat"
	cp $(find "$ResDisassemblyCat" -name '*.bsl') "$RulesFileName";

	oscript "$gitKD3GitPath/РазборПравилОбмена.os" "$ResDisassemblyCat/$RulesFileName" "$gitCatPath/ПравилаОбмена"

	cd "$gitCatPath"
	
	if echo $(git branch)|grep -q "$gitBranchName"; then
		git switch "$gitBranchName"
	else
		git switch -c "$gitBranchName"
	fi

	git add . 
	git commit -m "$commit"
	git push -u origin "$gitBranchName" ##??? / заменить origin на переменную
	
else 
	echo $?
fi

$SHELL