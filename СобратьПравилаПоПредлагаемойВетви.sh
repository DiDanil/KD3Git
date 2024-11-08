#!/bin/bash

set +o history
gitRepoName=$(basename `git rev-parse --show-toplevel`)
PreviousFile=$1

gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" ##Вынести в общие настройки

gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил
gitRulesPath="$gitCatPath/ПравилаОбмена" ##Правила обмена разобранные на функции
ResCatalogPath="$gitCatPath/ПравилаОбменаСобранные" ##Каталог с результатами сборки правил
NotePadPath="C:/Program Files/Notepad++/notepad++.exe"

read -e -p 'Исключить feature ветки? (y/n, по умолчанию y): ' answer 
answer=${answer:-y}  # Если answer пустой (Enter), установить его в "y"
if [[ $answer == "y" ]]; then
branchfilter="grep -v '\->' | grep -v 'feature'"
else
branchfilter="grep -v '\->'"
fi

# Получаем список веток
#branches=$(git branch --all | grep -v '\->' | grep -v 'feature' | sed 's/^[ *]*//')
branches=$(git branch --all | $branchfilter | sed 's/^[ *]*//')
# Преобразуем список веток в массив
branches_array=($branches)

# Выводим меню для выбора ветки
echo "Выберите ветку:"

select branch in "${branches_array[@]}"; do
    # Проверяем, был ли сделан выбор
    if [ -n "$branch" ]; then
        echo "Вы выбрали ветку: $branch"
       
	    git switch "$branch"
		
		
		mkdir "$ResCatalogPath" 2>/dev/null
		
		cleaned_branchname="${branch//[\*\|\\\:\"<>\?\/]/_}"
		filename="ПравилаОбменаСобранные_$cleaned_branchname.txt"
		filepath="$ResCatalogPath/$filename"
		
		branchHead=$(git log -1 | awk '{print $1}')
	
		oscript "$gitKD3GitPath/СборкаПравилОбмена.os" "$gitRulesPath" "$filepath" "$gitRepoName" "$branch" $branchHead
		echo -e "\e[32mГотово. $filepath\e[0m"
		
		read -e -p 'Собрать обработку менеджера по выбранной ветви? (y/n, по умолчанию y): ' answer
		answer=${answer:-y}  # Если answer пустой (Enter), установить его в "y"
		if [[ $answer == "y" ]]; then
		
			EPFName="МнЖОбмена_${gitRepoName}_${cleaned_branchname}"
			EPFSynonym="Менеджер обмена ${gitRepoName}_${cleaned_branchname}"
			EPFComment="Дата сборки обработки $(date +"%Y-%m-%d %H:%M:%S"), Данные последнего изменения $(git log -n 1 --format="%cd %h" --date=format:"%Y-%m-%d %H:%M")"
			RulesTxt="$filepath"
			EPFPath="$ResCatalogPath"
			
			"$gitKD3GitPath/СборкаОбработкиПоПроизвольнымПравилам.sh" $EPFName "$EPFSynonym" "$EPFComment" "$RulesTxt" "$EPFPath";
			
			#exec "$0" $filepath # Перезапуск самого скрипта

		fi
				
        break
    else
        echo "Неверный выбор. Пожалуйста, попробуйте снова."
    fi
done



if [ -n "$PreviousFile" ]; then

    echo "Сравнить с предыдущей выгрузкой? (y/n)"
	read answer
	
	if [[ $answer == "y" ]]; then
		exec "$NotePadPath" -multiInst -nosession "$PreviousFile" "$filepath" # Открыть оба файла в новом окне нотпада
	fi
	
fi

echo "Скрипт завершен, хотите ли вы его перезапустить? (y/n)"
read answer
if [[ $answer == "y" ]]; then
    exec "$0" $filepath # Перезапуск самого скрипта
fi
fi

$SHELL