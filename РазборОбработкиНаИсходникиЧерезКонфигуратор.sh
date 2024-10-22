ResCatalogPath=$1
EPFPath=$2
LogPath=$3

cd "/c/Program Files/1cv8/8.3.24.1528/bin/"
#./1cv8.exe DESIGNER //DumpExternalDataProcessorOrReportToFiles "D:\1с\Очоба\OS\test\TestUnpack\Res" "D:\1с\Очоба\OS\test\TestUnpack\T.epf" /Out "D:\1с\Очоба\OS\test\TestUnpack\Res\out.txt"
./1cv8.exe DESIGNER //DumpExternalDataProcessorOrReportToFiles $ResCatalogPath $EPFPath /Out $LogPath

