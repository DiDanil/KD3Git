#!/bin/bash

# Определяем значения переменных
NAME="МояОбработочка"
Synonym="Моя обработочка"
Comment="Комментарий вот такой вот"
RulesTxt="ПравилаОбменаСобранные_main.txt"

NAME=$1
Synonym=$2
Comment=$3
RulesTxt=$4
EPFPath=$5

gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" 

SourcePath="$(pwd)/ИсходникиДляСборки/$NAME.xml" ##Исходники обработки для сборки

logpath="$(pwd)\ЛогСборкиОбработки.txt" 

rm -rf ИсходникиДляСборки/

mkdir ИсходникиДляСборки/
mkdir ИсходникиДляСборки/$NAME
mkdir ИсходникиДляСборки/$NAME/Ext

touch ИсходникиДляСборки/$NAME/Ext/ObjectModule.bsl

cat "$RulesTxt" > ИсходникиДляСборки/$NAME/Ext/ObjectModule.bsl

# Создаем файл с замененными значениями
sed -e "s/{{EPFName}}/$NAME/g" \
    -e "s/{{EPFSynonym}}/$Synonym/g" \
    -e "s/{{EPFComment}}/$Comment/g" $gitKD3GitPath/Шаблоны/templateEPF.xml > ИсходникиДляСборки/"$NAME.xml" 
	


# Преобразуем его в формат Windows
windows_logpath=$(echo "$logpath" | sed -E 's|^/([a-z])/|\U\1:\\|') ##Почему то для вывода лога линуксовые формат пути не работает

"$gitKD3GitPath/СборкаОбработкиИзИсходниковЧерезКонфигуратор.sh" "$SourcePath" "$EPFPath" "$windows_logpath";

# Проверка на ошибку выполнения команды
if [ $? -ne 0 ]; then

    echo "Произошла ошибка при выполнении команды."
	cat "$logpath" | while IFS= read -r line; do
		echo -e "\033[31m$line\033[0m"
	done

else
	rm -rf ИсходникиДляСборки/
	rm -rf "$logpath"
	
	echo -e "\e[32mГотово. Путь к собранной обработке\e[0m"
	echo -e "\e[32m$EPFPath\e[0m"
 
fi