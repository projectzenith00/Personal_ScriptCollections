# PowerShell Script that will check if MS Teams is running. If it is, the numlock will turn on and off every 1 minute and will continue to do so until you close the script.
# If MS Teams is not running, it will try to run the MS Teams application and will execute it's main objective to turn on and off the numblock key every 1 minute.

while ($true) {
    try {
        Get-Process -Name 'ms-teams' -ErrorAction stop | Out-Null
        Write-Host ("{0} - Microsoft Teams is running..." -f $(get-date)) -ForegroundColor Green
        $wshell = New-Object -ComObject wscript.shell
        $wshell.sendkeys("{NUMLOCK}{NUMLOCK}")
        Write-Host ("{0} - Pressed NUMLOCK twice and waiting for 60 seconds" -f $(get-date)) -ForegroundColor Green
        Start-Sleep -Seconds 60          
    }
    catch {
        Write-Warning ("{0} - Microsoft Teams is not running, sleeping for 15 seconds..." -f $(get-date))
        Start-Process ms-teams.exe
        Start-Sleep -Seconds 15
        Get-Process -Name 'ms-teams' -ErrorAction stop | Out-Null
        Write-Host ("{0} - Microsoft Teams is running..." -f $(get-date)) -ForegroundColor Green
        $wshell = New-Object -ComObject wscript.shell
        $wshell.sendkeys("{NUMLOCK}{NUMLOCK}")
        Write-Host ("{0} - Pressed NUMLOCK twice and waiting for 60 seconds" -f $(get-date)) -ForegroundColor Green
        Start-Sleep -Seconds 60          
    }
}
