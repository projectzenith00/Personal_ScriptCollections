URL=r"https://script-downloads.itarian.com/Registry/Edge_Ayar.reg" #provide a URL of 32 bit package
import ctypes
import time
import socket
import _winreg
import platform
import shutil
import ssl
import urllib2
import getpass
import shutil
import os
def Download(src_path, URL,fp):
    import urllib2
    request = urllib2.Request(URL, headers={'User-Agent' : "Magic Browser"})
    try:
        gcontext = ssl.SSLContext(ssl.PROTOCOL_TLSv1)
        parsed = urllib2.urlopen(request,context=gcontext)
    except:
        parsed = urllib2.urlopen(request)
    if not os.path.exists(src_path):
        os.makedirs(src_path)
    with open(fp, 'wb') as f:
        while True:
            chunk=parsed.read(100*1000*1000)
            if chunk:
                f.write(chunk)
            else:
                break
    return fp
Folder=os.environ['programdata']+r"\extraction_file"
if not os.path.exists(Folder):
    os.mkdir(Folder)
fileName=r"Edge_Ayer.reg"
src_path=Folder
fp = os.path.join(src_path, fileName)    
Excutable_path=Download(Folder, URL,fp)




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

ecmd('reg import '+Excutable_path)

os.remove(Excutable_path)
