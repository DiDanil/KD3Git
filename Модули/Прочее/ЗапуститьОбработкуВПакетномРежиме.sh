PlatformPath="$1"
EPFPath="$2"
IBName="$3"
Usr="$4"
Pwd="$5"

"$PlatformPath" ENTERPRISE //IBName"$IBName" //N"$Usr" //P"$Pwd" //C'\\it-tsr5\Общая\Обработка222.epf' //DisableStartupMessages //DisableSplash //WA+ //AU- //Execute "$EPFPath" 

#\
PlatformPath="/c/Program Files/1cv8/8.3.24.1691/bin/1cv8c.exe"\
IBName="Розница КР"\
Usr="Администратор"\
Pwd="@pi35963ts"\
EPFPath="/d/Общая/ВыгрузитьАктуальныйМенеджерОбменаПР.epf"\
./ЗапуститьОбработкуВПакетномРежиме.sh "$PlatformPath" "$EPFPath" "$IBName" "$Usr" "$Pwd" 