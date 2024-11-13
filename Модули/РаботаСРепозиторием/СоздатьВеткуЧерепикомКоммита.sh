#!/bin/sh

git switch $1

# Получаем список коммитов
commits=$(git log --no-merges --pretty=format:"%h %s")
commits="${commits//[\*\|\\\:\"<>\?\/ ]/_}"

# Преобразуем список коммитов в массив
commits_array=($commits)

# Выводим меню для выбора коммита
echo "Выберите коммит для создания/обновления ветви:"

select commit in "${commits_array[@]}"; do

 if [ -n "$commit" ]; then
        echo "Вы выбрали коммит: $commit"
		
		
		commit_hash=$(echo "$commit" | awk -F_ '{print $1}')       
		commit_comment=$(echo "$commit" |sed s/"$commit_hash"/_/)
		gitBranchName=$commit_comment
		echo $commit_hash
		
		
		if echo $(git branch)|grep -q "feature/$gitBranchName"; then
			git switch "feature/$gitBranchName"
		else
			git switch -c "feature/ready/$gitBranchName" main
		fi

		git cherry-pick "$commit_hash"
		#git switch dev 
		#git merge "feature/$gitBranchName"

       
	   
		#echo -e "\e[32mГотово. $filepath\e[0m"
		
        break
    else
        echo "Неверный выбор. Пожалуйста, попробуйте снова."
    fi

done
