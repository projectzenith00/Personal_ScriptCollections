function Set-ConsoleColor ($bc, $fc) {
    $Host.UI.RawUI.BackgroundColor = $bc
    $Host.UI.RawUI.ForegroundColor = $fc
    Clear-Host
}
Set-ConsoleColor 'Black' 'Green'
Set-ExecutionPolicy Bypass -Force
#Disable Windows Update in services.msc
Stop-Service -Name wuauserv; 
Write-Host 'Windows Update Services has STOPPED' -ForegroundColor Green; 
Set-Service -Name wuauserv -StartupType Disabled; 
Write-Host 'Windows Update Services Startup Type has been set to "Disabled"' -ForegroundColor Green; 
Set-Service -Name wuauserv -Status Stopped; 
Write-Host 'Windows Update Services Status has been set to "Stopped"' -ForegroundColor Green;

#Disable Windows Update in REGISTRY
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$valueName = "NoAutoUpdate"
$requiredValue = "1"
$regkeyexists = Test-Path -Path $regPath
if ($regkeyexists) {
   #Check if registry entry named NoAutoUpdate exists
   $regentryexists = Get-ItemProperty -Path $regpath -Name NoAutoUpdate -ErrorAction SilentlyContinue
   if ($regentryexists) {
   #If registry entry named NoAutoUpdate exists, then fetch its value
    $currentValue = Get-ItemProperty -Path $regpath | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue
    #Match NoAutoUpdate registry entry value with requied value
    if ($currentValue -eq $requiredvalue) {
            Write-Host "Reg value exists and matching the required value."
        } else {
            Write-Host "Reg value exists, but does not match the required value." -ForegroundColor Red  -BackgroundColor White; 
            Write-Host "Current value:" -ForegroundColor White -NoNewline; Write-Host " "$currentValue"  " -ForegroundColor Red -BackgroundColor White;
            Write-Host "Required value:" -ForegroundColor White -NoNewline; Write-Host " "$requiredValue"  " -ForegroundColor Blue -BackgroundColor White; 
            <#Write-Host " Changing Registry value.. " -ForegroundColor Black -BackgroundColor Green;
            Remove-ItemProperty -Path $regpath -Name $valueName -Force
            New-ItemProperty -Path $regpath -Name $valueName -Value $requiredValue -PropertyType DWord -Force
            Write-Host "Updated registry value for " $valueName -ForegroundColor Green;#>
        }  
    } 
    else {
        Write-Host "Registry value does not exist." -ForegroundColor Red; 
    }
} 
else {
    Write-Host "Registry key does not exist." -ForegroundColor Green; 
}
