PlatformPath="$1"
EPFPath="$2"
IBName="$3"
Usr="$4"
Pwd="$5"
LaunchParameter="$6"

"$PlatformPath" ENTERPRISE //IBName"$IBName" //N"$Usr" //P"$Pwd" //C"$LaunchParameter" //DisableStartupMessages //DisableSplash //WA+ //AU- //Execute "$EPFPath" 


