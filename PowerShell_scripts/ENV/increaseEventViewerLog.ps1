# PowerShell script to update file size of an Event Log. 
# Note it's better to just use MB when setting the new file size.
# "-as [Int]" will interpret the string to a number.

$LogName = "Application"; # Name of the Event Log
$NewMaxSize = 500MB -as [Int]; # Set the new file size of the event log here.

Limit-EventLog -LogName "Application" -MaximumSize $NewMaxSize; 

Get-EventLog -List | Where-Object Log -eq Application | Select Log, MaximumKiloBytes | Format-Table; 

Write-Host "Sucessfully updated file size:"$LogName;
