$ieObject = New-Object -com internetexplorer.application
$ieObject.Visible = $true
$ieObject.Top = 0
$ieObject.Left = 0
$ieObject.Navigate('https://www.google.com/')
