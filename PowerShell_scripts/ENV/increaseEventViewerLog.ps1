# Define the event log name and new maximum size (in KB)
$LogName = "Application"  # Change this to the desired event log (e.g., System, Security, etc.)
$NewMaxSizeKB = 512000  # Set the new log size in KB (500 MB in this example)

# Check the current log size
$CurrentLog = Get-EventLog -LogName $LogName -List
Write-Output "Current Log Size: $($CurrentLog.MaximumKilobytes) KB"

# Set the new maximum log size
wevtutil sl $LogName /ms:$NewMaxSizeKB

# Verify the change
$UpdatedLog = Get-EventLog -LogName $LogName -List
Write-Output "Updated Log Size: $($UpdatedLog.MaximumKilobytes) KB"
