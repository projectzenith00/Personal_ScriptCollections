$directoryPath = "C:\Users"

$timeSpan = New-TimeSpan -Days 60

$currentDate = Get-Date

$items = Get-ChildItem -Path $directoryPath -Recurse

foreach ($item in $items) {
    $itemAge = $currentDate - $item.LastWriteTime

    if ($itemAge -gt $timeSpan) {
        try {
            if ($item.PSIsContainer) {
                Remove-Item -Path $item.FullName -Recurse -Force
                Write-Host "Removed directory: $($item.FullName)"
            } else {
                Remove-Item -Path $item.FullName -Force
                Write-Host "Removed file: $($item.FullName)"
            }
        } catch {
            Write-Host "Error removing item: $($item.FullName) - $_"
        }
    }
}
