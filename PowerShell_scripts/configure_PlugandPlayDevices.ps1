# Enable, Disable or Check plug and play devices (e.g. USB Keyboard, USB Mouse, USB Headset)
# To get all currently connected Plug-in-Play devices.
Get-PnpDevice  -PresentOnly | Select-Object -Property InstanceID, FriendlyName, Class, Status | Sort-Object -Property Class

# To get all currently connected Speaker(Media) and Microphone(AudioEndpoint) Plug-in-Play devices.
Get-PnpDevice -Class 'Media', 'AudioEndpoint' -PresentOnly -Status 'OK' | Select-Object -Property InstanceID, FriendlyName, Class | Sort-Object -Property Class

Disable-PnpDevice -InstanceId 'replace-with-correct-InstanceId'
