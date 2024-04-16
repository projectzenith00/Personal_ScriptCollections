URL=r"https://onedrive.live.com/download?cid=CFC812D5E983F253&resid=CFC812D5E983F253%21129&authkey=AEQOlQnUEYtqwCQ" #provide a URL 
import ctypes
import re
import time
import socket
import _winreg
import platform
import shutil
import ssl
import urllib2
import getpass
import zipfile
import shutil
import os
import glob
from subprocess import PIPE,Popen
import ctypes
start=time.time()
class disable_file_system_redirection:
    _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
    _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
    def __enter__(self):
        self.old_value = ctypes.c_long()
        self.success = self._disable(ctypes.byref(self.old_value))
    def __exit__(self, type, value, traceback):
        if self.success:
            self._revert(self.old_value)
def permissions(dirpath):
    mode=0o777
    if os.path.isdir(dirpath):
        try:
            for root,dirs,files in os.walk(dirpath,topdown=False):
                for dircs in [os.path.join(root,d) for d in dirs]:
                    os.chmod(dircs,mode)
                for s_file in [os.path.join(root,f) for f in files]:
                    os.chmod(s_file,mode)
        except Exception as E:
            print "File being Used %s"
            
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
fileName=r"hwlenova.zip"
src_path=Folder
fp = os.path.join(src_path, fileName)    
Excutable_path=Download(Folder, URL,fp)
print "Downloaded succesfully to "+Excutable_path+""

dest_path=os.environ['programdata']+r"\extraction_file"
def filezip(Excutable_path,dest_path):
    with zipfile.ZipFile(Excutable_path,"r") as zip_ref:
        zip_ref.extractall(dest_path)
        print 'file unzipped to ' +dest_path 
filezip(Excutable_path,dest_path)


permissions(dest_path)
#os.chdir(dest_path)

directory_list=[]
for root,dirs,files in os.walk("C:\ProgramData\extraction_file",topdown=False):
    for dirs  in [os.path.join(root,d) for d in dirs]:
        directory_list.append(dirs)
#print directory_list
def findfile(path):
    import glob
    for i in path:
        modify=i+"\*.cmd"
        cmd=glob.glob(modify)
        if cmd:
            filefound=cmd
            return filefound
        else:
            print "No .cmd file exsist"
filefound=findfile(directory_list)#[0].split("\\")[-1]
#print filefound
with disable_file_system_redirection():
    process=Popen(filefound[0],stdout=PIPE,stderr=PIPE)
    r,e=process.communicate()
    if e:
        print e
    else:
        print r
    shutil.rmtree(dest_path,ignore_errors=True)

end=time.time()
t=end-start
print "Execution Time %s"%t
