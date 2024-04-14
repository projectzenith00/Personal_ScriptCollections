ssid_name=itsm.getParameter('ssid_name')
ssid_name=itsm.getParameter('ssid_password')

ps_HotSpot = r'''
$WirelessNetworkSSID = "''' + ssid_name + '''";
$WirelessNetworkPassword = "''' + ssid_password + '''";
$Authentication = 'WPA2PSK'; # This could also be WEP, WPA, WPA2, or WPA3. So make sure to change the value
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
'''

import os

def ecmd(command):
    import ctypes
    from subprocess import PIPE, Popen

    class disable_file_system_redirection:
        _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
        _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
        def __enter__(self):
            self.old_value = ctypes.c_long()
            self.success = self._disable(ctypes.byref(self.old_value))
        def __exit__(self, type, value, traceback):
            if self.success:
                self._revert(self.old_value)

    with disable_file_system_redirection():
        obj = Popen(command, shell = True, stdout = PIPE, stderr = PIPE)
    out, err = obj.communicate()
    ret=obj.returncode
    if ret==0:
        if out:
            return out.strip()
        else:
            return ret
    else:
        if err:
            return err.strip()
        else:
            return ret

file_name='powershell_fileSwitch.ps1'
file_path=os.path.join(os.environ['TEMP'], file_name)
with open(file_path, 'w') as script_file:
    script_file.write(ps_HotSpot)

ecmd('powershell "Set-ExecutionPolicy RemoteSigned"')
os.remove(file_path)
