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



# BLCKBOX


# Define the log name and the new maximum size (in bytes)
$logName = "Application"
$newMaxSize = 10485760  # 10 MB (10 * 1024 * 1024)

# Get the event log
$eventLog = Get-WinEvent -ListLog $logName

# Check if the log exists
if ($eventLog) {
    # Set the new maximum size
    $eventLog.MaximumSizeInBytes = $newMaxSize

    # Save the changes
    $eventLog | Set-WinEventLog

    Write-Host "Successfully increased the size of the '$logName' log to $($newMaxSize / 1MB) MB."
} else {
    Write-Host "The log '$logName' does not exist."
}
