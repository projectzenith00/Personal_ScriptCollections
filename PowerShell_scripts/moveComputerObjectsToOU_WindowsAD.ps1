# PowerShell script to move all computers inside an OU to another OU

$sourceOU = "OU=VAPT Devices,DC=sophi-outsourcing,DC=local" 
$destinationOU = "OU=Computers,OU=Employees,DC=sophi-outsourcing,DC=local"

$computers = Get-ADComputer -Filter * -SearchBase $sourceOU
https://sophi.stats.pbx.commpeak.com/login
foreach ($computer in $computers) {
    Move-ADObject -Identity $computer.DistinguishedName -TargetPath $destinationOU
    Write-Output "Moved computer $($computer.Name) to $destinationOU"
}