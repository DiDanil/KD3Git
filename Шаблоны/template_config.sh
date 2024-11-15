RulesCatPath="/d/Общая/Кд3Обмены/Правила" ##Где ищем обработку с правилами !!
gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки !!
NotePadPath="C:/Program Files/Notepad++/notepad++.exe"

gitRepoPath=$(git rev-parse --show-toplevel)
gitRepoName=$(basename $gitRepoPath)

if [ "$gitRepoName" == "KD3Git" ];  then
	#Сабмодуль, репозиторий скриптов в репозитории правил
	isKD3GitRep=true
	gitKD3GitPath=$gitRepoPath ##Путь к репозиторию KD3Git/Репозиторий в репозитории

	gitRepoName=$(basename "$(git -C "$gitRepoPath/.." rev-parse --show-toplevel)")
    gitCatPath=$(git -C "$gitRepoPath/.." rev-parse --show-toplevel) ##Каталог репозитория правил || gitRepoPath
    
else
	#Скрипты скопированны , внешний реп
	isKD3GitRep=false	
	gitKD3GitPath="$gitHome/KD3Git" ##Путь к репозиторию KD3Git/Вынести в общие настройки
    gitCatPath="$gitHome/$gitRepoName" ##Каталог репозитория правил || gitRepoPath
fi

PathToDisassemblyScripts="$gitKD3GitPath/Модули/Разборка"
PathToRepoEditScripts="$gitKD3GitPath/Модули/РаботаСРепозиторием"
PathToAssemblyScripts="$gitKD3GitPath/Модули/Сборка"