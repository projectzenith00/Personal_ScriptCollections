# Note: Run this script as Admin
$targetDirectory = "C:\Users";

Get-ChildItem -force $targetDirectory -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | ForEach-Object {
    $len = 0;
    Get-ChildItem -recurse -force $_.fullname -ErrorAction SilentlyContinue | ForEach-Object { $len += $_.length }
    $_.fullname, '{0:N2} GB' -f ($len / 1Gb) 
}
