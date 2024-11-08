gitHome="/d/Общая/git/rep" ##Кореновой каталог репозиториев / Вынести в общие настройки
gitKD3GitPath="$gitHome/KD3Git" 
AD=$(pwd)

ResCatalogPath="/d/Общая/git/rep/KD3Git/Test/ТестовыеДанные/РезультатРазбораОбработкиНаИсходники/МнЖОбменаТест.xml" ##Исходники обработки для сборки
##EPFPath="/d/Общая/git/rep/KD3Git/Test/ТестовыеДанные/ПравилаОбменаСобранные_TestKD3/ПравилаОбменаСобранные_dev" ##Путь к собранной обработке

for RFile in $(ls ПравилаОбменаСобранные_*.txt) 
do

	cleaned_filename="${RFile/.txt/}"
	filepath="$AD/$cleaned_filename"
	
	cat $RFile > ../РезультатРазбораОбработкиНаИсходники/МнЖОбменаТест/Ext/ObjectModule.bsl
	
	"$gitKD3GitPath/СборкаОбработкиИзИсходниковЧерезКонфигуратор.sh" $ResCatalogPath "$filepath" "$AD\out.txt";
done

$SHELL


#cd /d
#cd общая/git/rep/KD3Git/Test/ТестовыеДанные/ПравилаОбменаСобранные_TestKD3
#ResCatalogPath="/d/Общая/git/rep/KD3Git/Test/ТестовыеДанные/РезультатРазбораОбработкиНаИсходники/МнЖОбменаТест.xml" ##Исходники обработки для сборки
#EPFPath="/d/Общая/git/rep/KD3Git/Test/ТестовыеДанные/ПравилаОбменаСобранные_TestKD3/ПравилаОбменаСобранные_dev" ##Путь к собранной обработке
#LogPath="/d/Общая/git/rep/KD3Git/Test/ТестовыеДанные/ПравилаОбменаСобранные_TestKD3/out.txt"#
#
#echo Запуск
#echo $ResCatalogPath
#cd "/c/Program Files/1cv8/8.3.24.1528/bin/" ## Вынести в общие настройки
#./1cv8.exe DESIGNER //LoadExternalDataProcessorOrReportFromFiles $ResCatalogPath $EPFPath /Out $LogPath


