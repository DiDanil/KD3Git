
gitRepoName=$1 ##Имя репозитория
gitBranchName=$2
commit=$3 ##Комментарий коммита
EPFPath=$4 ##Обработка менеджера
gitKD3GitPath=$5 ##Путь к репозиторию KD3Git/Вынести в общие настройки



gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" 
PathToDisassemblyScripts="$gitKD3GitPath/Модули/Разборка"

gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил
gitRulesPath="$gitCatPath/ПравилаОбмена" ##Правила обмена разобранные на функции
ResDisassemblyCat="$gitCatPath/Ignore/РезультатРазбораОбработкиНаИсходники" ##Обработка менеджера разобранная на исходники


RulesFileName="МенеджерОбмена.txt" ##Текстовый файл с менеджером обмена, получается из разбора обработки исходники, передается в разбор на процедуры


##cd "$RulesCatPath"

mkdir "$gitCatPath/Ignore" 2>/dev/null
rm -r "$ResDisassemblyCat" 2>/dev/null
mkdir "$ResDisassemblyCat" 2>/dev/null

#В ИФ через И докинуть cp
#Мб имеет смысл выгружать результат разбора в отдельный подкаталог чтоб они перезатирались?

##																Куда сохранить Что разбирать
if "$PathToDisassemblyScripts/РазборОбработкиНаИсходникиЧерезКонфигуратор.sh" "$ResDisassemblyCat" "$EPFPath" "$(pwd)\out.txt"; then
	
	cd "$gitCatPath"
	
	if echo $(git branch)|grep -q "$gitBranchName"; then
		git switch "$gitBranchName"
	else
		git switch -c "$gitBranchName" ##Если делаем новую ветку, то перед ее созданием надо выбрать и перейти на ее родителя
	fi
	
	git pull origin "$gitBranchName" ##??? / заменить origin на переменную
	
	cd "$ResDisassemblyCat"
	cp $(find "$ResDisassemblyCat" -name '*.bsl') "$RulesFileName";

	oscript "$PathToDisassemblyScripts/РазборПравилОбмена.os" "$ResDisassemblyCat/$RulesFileName" "$gitCatPath/ПравилаОбмена"

	cd "$gitCatPath"
	


	git add . 
	git commit -m "$commit"
	git push -u origin "$gitBranchName" ##??? / заменить origin на переменную
	
else 
	echo $?
fi

$SHELL