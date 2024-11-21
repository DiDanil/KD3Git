#!/bin/bash
source $(git rev-parse --show-toplevel)/config.sh

set +o history

cd "$gitCatPath"

# Получаем список слитых веток
branches=$(git branch --merged | grep 'feature' | grep -v '\->' | sed 's/^[ *]*//')

# Преобразуем список веток в массив
branches_array=($branches)
for branch in "${branches_array[@]}"; do
	featurename=$(echo "$branch" |awk -F/ '{print $NF}' )
	newbranch="feature/done/$featurename"
	#echo "feature/done/$featurename"
	if echo $(git branch)|grep -q "$branch"; then
		git branch -m "$branch" "$newbranch"
		echo "$branch >> $newbranch"
	fi
	
done


$SHELL