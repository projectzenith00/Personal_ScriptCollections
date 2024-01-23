$WirelessNetworkSSID = 'ssid_name';
$WirelessNetworkPassword = 'ssid_password';
$Authentication = 'WPA2PSK'; # This could also be WEP, WPA, WPA2, or WPA3
$Encryption = 'AES';

$WirelessProfile = @'
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
	<name>{0}</name>
	<SSIDConfig>
		<SSID>
			<name>{0}</name>
		</SSID>
	</SSIDConfig>
	<connectionType>ESS</connectionType>
	<connectionMode>auto</connectionMode>
	<MSM>
		<security>
			<authEncryption>
				<authentication>{2}</authentication>
				<encryption>{3}</encryption>
				<useOneX>false</useOneX>
			</authEncryption>
			<sharedKey>
				<keyType>passPhrase</keyType>
				<protected>false</protected>
				<keyMaterial>{1}</keyMaterial>
			</sharedKey>
		</security>
	</MSM>
</WLANProfile>
'@ -f $WirelessNetworkSSID, $WirelessNetworkPassword, $Authentication, $Encryption;

$random = Get-Random –Minimum 1 –Maximum 99999999;
$tempProfileXML = "$ENV:USERPROFILE\$random.xml";
$WirelessProfile | Out-File $tempProfileXML;

Start-Process netsh ('wlan add profile filename={0}' -f $tempProfileXML);

Start-Process netsh ('wlan connect name="{0}"' -f $WirelessNetworkSSID);
