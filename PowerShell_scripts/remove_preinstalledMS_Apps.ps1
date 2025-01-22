$packageIDs=@(
'ARP\Machine\X64\O365HomePremRetail - en-us',
'ARP\Machine\X64\O365HomePremRetail - es-es',
'ARP\Machine\X64\O365HomePremRetail - fr-fr',
'ARP\Machine\X64\O365HomePremRetail - pt-br',
'ARP\Machine\X64\OneNoteFreeRetail - en-us',
'ARP\Machine\X64\OneNoteFreeRetail - es-es',
'ARP\Machine\X64\OneNoteFreeRetail - fr-fr',
'ARP\Machine\X64\OneNoteFreeRetail - pt-br',
'Microsoft Teams',
'Microsoft.OneDrive'
)

foreach ($packageID in $packageIDs) 
    {
        winget uninstall -e --id $packageID --silent --accept-source-agreements;
    } 
