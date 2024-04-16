#Referrence: https://scripts.itarian.com/frontend/web/topic/download-and-install-any-application-from-the-url
#To define a particular parameter, replace the 'parameterName' inside itsm.getParameter('parameterName') with that parameter's name
URL=itsm.getParameter('Enter_the_URL')# Enter the URL
fileName=itsm.getParameter('Enter_the_File_Name')# Enter the File Name with extenstion eg .msi
silent=itsm.getParameter('Enter_the_silent_command')#Enter the silent command for this application

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

import ssl
with disable_file_system_redirection():
    import urllib

def Download(URL,silent):
    import urllib2
    import os
    print "Download started"
    src_path=os.environ['ProgramData']
    fp = os.path.join(src_path, fileName)
    print fp
    try:
        with open(fp, 'wb') as f:
            try:
                context = ssl._create_unverified_context()
                f.write(urllib.urlopen(URL,context=context).read())
            except:
                f.write(urllib.urlopen(fromURL).read())
        if os.path.isfile(fp):
            print '{} - {}KB'.format(fp, os.path.getsize(fp)/1000)
		
    except:
        return 'Please Check URL or Download Path!'
    print "The file downloaded successfully in specified path"+fp
    try:
        print'Downloaded Application %s Installation Started'%fileName
        os.popen(fp+' '+silent).read()
        print '%s Application Successfully Installed'%fileName
    except:
        return 'No : '+fp+' is exist'


Download(URL,silent)
