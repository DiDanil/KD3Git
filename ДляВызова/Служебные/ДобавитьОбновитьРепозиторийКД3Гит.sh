path=$(pwd)
RulesRepoPath=${path%%KD3Git*}

read -e -p "Создать/Обновить репозиторий KD3Git в папке ${RulesRepoPath}? (y/n, по умолчанию y): " answer 
answer=${answer:-y}  # Если answer пустой (Enter), установить его в "y"
if [[ $answer == "y" ]]; then

	if ! grep -q "/KD3Git" "$RulesRepoPath/.gitignore"; then	
		echo -e "\n/KD3Git" >> .gitignore
	fi

	if ! [ -d "$RulesRepoPath/KD3Git" ]; then 
		git clone ../KD3Git.git KD3Git 
	else
		cd "$RulesRepoPath/KD3Git"
		git pull origin main
	fi

else
	break
fi 
$SHELL