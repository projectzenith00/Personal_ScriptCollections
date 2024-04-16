import _winreg
Key= r"SOFTWARE\Policies\Microsoft\Windows\Personalization" ## Here give the registry Key path. STRING
Sub_Key= "NoChangingLockScreen" ## Here give the sub Key of the registry. STRING
Field= _winreg.REG_DWORD ##Here give the field of it
value = 1 ##Mention the value To Disable = 1, to Enable = 0

import os
from _winreg import *
try:
    if not os.path.exists(Key):
        key = _winreg.CreateKey(HKEY_LOCAL_MACHINE,Key)
    Registrykey= OpenKey(HKEY_LOCAL_MACHINE,Key, 0,KEY_WRITE)
    _winreg.SetValueEx(Registrykey,Sub_Key,0,Field,value)
    CloseKey(Registrykey)
    print "Successfully created"
except WindowsError:
    print "Error"



import _winreg
Key= r"Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" ## Here give the registry Key path. STRING
Sub_Key= "NoChangingWallPaper" ## Here give the sub Key of the registry. STRING
Field= _winreg.REG_DWORD ##Here give the field of it
value = 1 ##Mention the value To Disable = 1, to Enable = 0

import os
from _winreg import *
try:
    if not os.path.exists(Key):
        key = _winreg.CreateKey(HKEY_CURRENT_USER,Key)
    Registrykey= OpenKey(HKEY_CURRENT_USER,Key, 0,KEY_WRITE)
    _winreg.SetValueEx(Registrykey,Sub_Key,0,Field,value)
    CloseKey(Registrykey)
    print "Successfully created"
except WindowsError:
    print "Error"
