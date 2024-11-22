ResCatalogPath=$1 ##Куда выгрузить результат разбора
EPFPath=$2 ##Обработка для разбора
LogPath=$3 

cd "/c/Program Files/1cv8/8.3.24.1528/bin/" ## Вынести в общие настройки
#./1cv8.exe DESIGNER //DumpExternalDataProcessorOrReportToFiles "D:\1с\Очоба\OS\test\TestUnpack\Res" "D:\1с\Очоба\OS\test\TestUnpack\T.epf" /Out "D:\1с\Очоба\OS\test\TestUnpack\Res\out.txt"
./1cv8.exe DESIGNER //DumpExternalDataProcessorOrReportToFiles $ResCatalogPath $EPFPath -Plain /Out $LogPath

