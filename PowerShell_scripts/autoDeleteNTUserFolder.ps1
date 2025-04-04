# A PowerShell script that will automatically confirm the deletion of the NT User folder in C:\Users directory using the "-Confirm:$false" parameter. 
# This script is helpful if you want to avoid any file corruption to the NT User's folder in case they need to login to the same device/computer in the future.
# Make sure that you don't replace the admin and Public folder names in the array list. 
# Only start replacing the fuser.

$excludedFolders = @("admin", "Public", "fuser", "luser")
$allFolders = Get-ChildItem -Path "C:\Users\" -Directory

foreach ($folder in $allFolders) {
    if ($excludedFolders -notcontains $folder.Name) {
        Remove-Item -Path $folder.FullName -Recurse -Confirm:$false
        Write-Host "Deleted $($folder.FullName)"
    } else {
        Write-Host "Excluded $($folder.FullName)"
    }
}
