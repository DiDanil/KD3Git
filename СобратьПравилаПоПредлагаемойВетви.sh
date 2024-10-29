#!/bin/bash

set +o history
gitRepoName=$(basename `git rev-parse --show-toplevel`)
PreviousFile=$1

gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" ##Вынести в общие настройки

gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил
gitRulesPath="$gitCatPath/ПравилаОбмена" ##Правила обмена разобранные на функции
NotePadPath="C:/Program Files/Notepad++/notepad++.exe"

# Получаем список веток
branches=$(git branch --all | grep -v '\->' | sed 's/^[ *]*//')

# Преобразуем список веток в массив
branches_array=($branches)

# Выводим меню для выбора ветки
echo "Выберите ветку:"

select branch in "${branches_array[@]}"; do
    # Проверяем, был ли сделан выбор
    if [ -n "$branch" ]; then
        echo "Вы выбрали ветку: $branch"
       
	    git switch "$branch"
		
		mkdir "$gitCatPath/ПравилаОбменаСобранные" 2>/dev/null
		
		filename="ПравилаОбменаСобранные_$branch"
		cleaned_filename="${filename//[\*\|\\\:\"<>\?\/]/_}"
		filepath="$gitCatPath/ПравилаОбменаСобранные/$cleaned_filename.txt"
		
		branchHead=$(git log -1 | awk '{print $1}')
	
		oscript "$gitKD3GitPath/СборкаПравилОбмена.os" "$gitRulesPath" "$filepath" "$gitRepoName" "$branch" $branchHead
		echo -e "\e[32mГотово. $filepath\e[0m"
		
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