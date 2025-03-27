try {
    if ((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "disabledomaincreds" -ErrorAction Stop).disabledomaincreds -eq 1) { 
        Write-Output "1" 
    } else { 
        Write-Output "0" 
    } 
} catch { 
    Write-Output "0" 
}
