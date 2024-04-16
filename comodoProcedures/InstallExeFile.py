file_path = r'C:\\ITarianRemoteAccessSetup_MTI5NTkwNQ==.exe' ### provide your file path with correct extention here ###
Silent_Install_Argument = r'/silent' #give here the correct silent install argument for the above exe file
import os
import subprocess
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
    if os.path.exists(file_path):
        fileName = file_path.split('/')[-1]
        cmd = '"%s" %s'%(file_path,Silent_Install_Argument)
        obj = subprocess.Popen(cmd, shell=True, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
        out, err = obj.communicate()
        if err:
            print(err)
        else:
            print(fileName+' installed successfully...')
    else:
        print(file_path+' didn"t found...!')
