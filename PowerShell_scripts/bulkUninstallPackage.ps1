# Bulk uninstall packages with the same name using winget
# Function to uninstall packages with the same name
function Uninstall-PackageByName {
    param(
        [string]$packageName
    )

    # Get a list of installed packages with the same name
    $packages = Get-Package | Where-Object { $_.Name -eq $packageName }

    # Uninstall each package
    foreach ($package in $packages) {
        Write-Host "Uninstalling $($package.Name) version $($package.Version)..."
        Uninstall-Package -Name $package.Name -Force
    }

    Write-Host "Bulk uninstallation of packages with name '$packageName' completed."
}

# Usage example
$packageName = "YouTube"
Uninstall-PackageByName -packageName $packageName

############################################
# Bulk uninstall packages from the array list using winget
$packageIDs=@('id_1',
'id_2',
'id_3'
)

foreach ($packageID in $packageIDs) 
    {
        winget uninstall -e --id $packageID --silent --force
    }
