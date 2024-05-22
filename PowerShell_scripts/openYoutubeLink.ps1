Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '--kiosk', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
Start-Sleep -Seconds 7;
[System.Windows.Forms.SendKeys]::SendWait('f');
#[System.Windows.Forms.SendKeys]::SendWait('{F11}')
