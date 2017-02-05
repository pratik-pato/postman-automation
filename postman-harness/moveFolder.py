import os
import shutil
import sys
import time
import string

lst = os.listdir("./operation")

fldr = lst[1]


'''def findStr(str):
	global htmlFile,jsonFile,xmlFile
	for i in str:
		if '.html' in i:
			htmlFile = i
		elif '.json' in i:
			jsonFile = i
		else :
			xmlFile = i
#cnt = len(lst);
#op = findStr(lst)
findStr(lst)
filesList = [jsonFile,xmlFile,htmlFile]
src = "%s%s" % ("./newman/",htmlFile)
destn = "%s%s%s%s" % ("./operation/",sys.argv[1],"/html/",htmlFile)
os.rename(src,destn)

src = "%s%s" % ("./newman/",jsonFile)
destn = "%s%s%s%s" % ("./operation/",sys.argv[1],"/json/",jsonFile)
os.rename(src,destn)
'''
src = "%s%s" % ("./operation/",fldr)
destn = "%s%s%s%s" % ("./operation/Archive/",sys.argv[1],"/",fldr)
os.rename(src,destn)
#shutil.copytree(src,destn)