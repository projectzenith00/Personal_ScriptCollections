#Export to CSV all Active Users from AD using Powershell
#Extracts the User's NT Username, Full Name and Organization Unit.
#Saves the exported list on the current login user's Desktop Folder

Get-ADUser -filter 'enabled -eq $true' 
-SearchBase "OU=Accounts,OU=Employees,DC=sophi-outsourcing,DC=local" 
-properties CanonicalName,Enabled | 
select SamAccountName,Name,@{n='OU';e={($_.CanonicalName  -split "/")[-2]}} | 
Export-CSV $env:USERPROFILE\Desktop\ADusers.csv -notypeinformation 
