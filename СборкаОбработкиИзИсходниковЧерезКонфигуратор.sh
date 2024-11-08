ResCatalogPath=$1 ##Исходники обработки для сборки
EPFPath=$2 ##Путь к собранной обработке
LogPath=$3 

cd "/c/Program Files/1cv8/8.3.24.1528/bin/" ## Вынести в общие настройки
./1cv8.exe DESIGNER //LoadExternalDataProcessorOrReportFromFiles $ResCatalogPath $EPFPath -Plain /Out$LogPath 

