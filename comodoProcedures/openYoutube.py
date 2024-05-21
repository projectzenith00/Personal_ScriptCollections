#curl -L "https://raw.githubusercontent.com/projectzenith00/Personal_ScriptCollections/main/comodoProcedures/openYoutube.py?token=GHSAT0AAAAAACSTN7ASJ6NEDYPM6ZXVYSHCZSNFL3A" --output

Youtube_url = "https://www.youtube.com/watch?v=8AaxrGKvoQY" 
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
    def volume():
        cmd = 'Function Set-Speaker($Volume){$wshShell = new-object -com wscript.shell;1..50 | % {$wshShell.SendKeys([char]174)};1..$Volume | % {$wshShell.SendKeys([char]175)}}; Set-Speaker -Volume 50'
        obj = subprocess.Popen(["powershell",cmd],shell=True,stdout=subprocess.PIPE,stdin=subprocess.PIPE)
        result,error=obj.communicate()
        if error:
            print(error)
        else:
            pass

    def yt_video(url):
        obj = subprocess.Popen(["powershell",url],shell=True,stdout=subprocess.PIPE,stdin=subprocess.PIPE)
        result,error=obj.communicate()
        if error:
            print(error)
        else:
            print("Video playing....")


    if "watch" in Youtube_url:
        my_string = Youtube_url
        index = my_string.find('watch')+5
        final_url = my_string[:index] + '_popup' + my_string[index:]
        volume()
        if os.path.exists("C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"):
            command = 'start-process "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" '+final_url
            yt_video(command)
        elif os.path.exists("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"):
            command = 'start-process "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe" '+final_url
            yt_video(command)
        else:
            print("Google Chrome doesn't exists in your device..")
    else:
        print("Youtube url is not in proper format...")
