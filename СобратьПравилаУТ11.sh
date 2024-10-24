gitRepoName="TestM"

gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" ##Вынести в общие настройки


gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил
gitRulesPath="$gitCatPath/ПравилаОбмена" ##Правила обмена разобранные на функции

oscript "$gitKD3GitPath/СборкаПравилОбмена.os" "$gitRulesPath" "$gitCatPath/ПравилаОбменаСобранные.txt"

$SHELL