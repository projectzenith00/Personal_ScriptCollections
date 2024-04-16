import _winreg
import os
import ctypes
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
    try:
        firstkey = _winreg.CreateKeyEx(_winreg.HKEY_LOCAL_MACHINE,"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate",0,_winreg.KEY_ALL_ACCESS)
        secondkey = _winreg.CreateKeyEx(_winreg.HKEY_LOCAL_MACHINE,"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU",0,_winreg.KEY_ALL_ACCESS)
        _winreg.SetValueEx(secondkey, "NoAutoUpdate", 0, _winreg.REG_DWORD, 1)
    except Exception as err:
        print(err)
    else:
        print("successfully deactivated the microsoft auto update")
