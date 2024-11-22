set +o history
source $(git rev-parse --show-toplevel)/config.sh
source $gitCatPath/RepoConfig.sh

PathToOtherScripts=$gitKD3GitPath/Модули/Прочее
PlatformPath="/c/Program Files/1cv8/8.3.24.1691/bin/1cv8c.exe"
UnloadEPF="/d/Общая/ВыгрузитьАктуальныйМенеджерОбменаПР.epf"

tmpEPFPath="$RulesUnloadDir"/"$RulesSyn"_Рабочие_$(date +%d_%m_%s).epf
EPFPath="$RulesUnloadDir"/"$RulesSyn"_Рабочие_$(date +%d_%m).epf

LaunchParameter="$tmpEPFPath"

gitBranchName="Prod"
commit="Загрузка рабочих правил"
git switch -c $gitBranchName

if $PathToOtherScripts/ЗапуститьОбработкуВПакетномРежиме.sh "$PlatformPath" "$UnloadEPF" "$IBName" "$Usr" "$Pwd" "$LaunchParameter"; then

	timeout=180  # 3 минуты
	interval=10  # Интервал между проверками (10 секунд)
	elapsed=0    # Время, прошедшее с начала ожидания

	# Ожидание появления файла
	while [ ! -f "$tmpEPFPath" ]; do
	  if [ $elapsed -ge $timeout ]; then
		echo "Ошибка: файл результата не появился за $((timeout / 60)) минут."
		exit 1  # Завершаем скрипт с ошибкой
	  fi

	  echo "Ожидание файла результата... (${elapsed}s/${timeout}s)"
	  sleep $interval  # Ждем 10 секунд
	  elapsed=$((elapsed + interval))  # Увеличиваем счетчик времени
	done
	
	mv "$tmpEPFPath" "$EPFPath"

   "$PathToDisassemblyScripts/ОбновитьПравилаРазобравОбработку.sh" "$gitRepoName" "$gitBranchName" "$commit" "$EPFPath" "$gitKD3GitPath" "$gitCatPath"
        
	echo Ok
fi

$SHELL
