$wifiName = "Wi-Fi Name"; #Replace with the correct Wi-Fi name
$wifiPassword = "Wi-Fi Password"; #Replace with the correct Wi-Fi password
 
# Create a Wi-Fi profile
$Profile = @"
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
  <name>$wifiName</name>
  <SSIDConfig>
    <SSID>
      <name>$wifiName</name>
    </SSID>
  </SSIDConfig>
  <connectionType>ESS</connectionType>
  <connectionMode>manual</connectionMode>
  <MSM>
    <security>
      <authEncryption>
        <authentication>WPA2PSK</authentication>
        <encryption>AES</encryption>
        <useOneX>false</useOneX>
      </authEncryption>
      <sharedKey>
        <keyType>passPhrase</keyType>
        <protected>false</protected>
        <keyMaterial>$wifiPassword</keyMaterial>
      </sharedKey>
    </security>
  </MSM>
</WLANProfile>
"@
 
# Export the profile to an XML file
$Profile | Out-File -FilePath "$env:USERPROFILE\$wifiName.xml";
 
# Add the profile to the Wi-Fi interface
netsh wlan add profile filename="$env:USERPROFILE\$wifiName.xml";
  
# Connect to the Wi-Fi network
netsh wlan connect name="$wifiName";
Remove-Item -Path "$env:USERPROFILE\$wifiName.xml" -Force;
