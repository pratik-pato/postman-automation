import os
import sys
import time
import string
from subprocess import Popen
import datetime

dt = datetime.datetime.now().date()
#print dt


localtime = time.asctime( time.localtime(time.time()) )
fix1 = string.replace(localtime,':','-')
fix2 = string.replace(fix1,' ','_')
folderName = "%s%s" % ("./operation/",string.replace(fix1,' ','_'))
#folderName = string.replace(fix1,' ','_')
print folderName

if not os.path.exists(folderName):
    os.mkdir(folderName)


for x in ['html','json','xml']:
	print x
	fixFile = "%s%s" % ("/",x)
	dtPath = "%s%s" % (folderName,fixFile)
	print dtPath
	if not os.path.exists(dtPath):
   		os.mkdir(dtPath)

caller = "%s%s%s%s" % ("moveReport.bat ",fix2," ",sys.argv[1])
print caller
p = Popen(caller, cwd=r"./")
stdout, stderr = p.communicate()