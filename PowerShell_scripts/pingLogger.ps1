# PowerShell Script that will log the ping results with Time and Date Stamp to Text file named "pinglog.txt" inside the "C:\Drive\Path\Folder" folder.
# If either or both the text file or path/folders doesn't exist, this script will create it.
# If the the text file already exist, it will add the new log entries below the the last log entries.

ping.exe -t 8.8.8.8 | ForEach {"{0} - {1}" -f (Get-Date),$_} | Out-File -FilePath "C:\Drive\Path\Folder\pinglogs.txt" -Append;
