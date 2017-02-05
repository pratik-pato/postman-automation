import os
import sys
import time
import string
import psycopg2

htmlFile = [] 
jsonFile = []
xmlFile = []

# each will have list of respective files list at end
lst = os.listdir("./newman")

#print lst

def findStr(str):
    global htmlFile,jsonFile,xmlFile
    for i in str:
        if '.html' in i:
            htmlFile.append(i)
        elif '.json' in i:
            jsonFile.append(i)
        else :
            xmlFile.append(i)
#cnt = len(lst);
#op = findStr(lst)
findStr(lst)
#filesList = [jsonFile,xmlFile,htmlFile]
#argv[1] = foldername_date
try:
     
    #con = psycopg2.connect(database='postman', user='postgres') 
    #cur = con.cursor()

    for x in htmlFile:
        src = "%s%s" % ("./newman/",x)
        destn = "%s%s%s%s" % ("./operation/",sys.argv[1],"/html/",x)
        #qry = "insert into reportFile values('%s','%s','%s');" % (x,sys.argv[2],sys.argv[1])
        #print qry
        #cur.execute(qry)
        os.rename(src,destn)


    for x in xmlFile:
        src = "%s%s" % ("./newman/",x)
        destn = "%s%s%s%s" % ("./operation/",sys.argv[1],"/xml/",x)
        #qry = "insert into reportFile values('%s','%s','%s');" % (x,sys.argv[2],sys.argv[1])
        #print qry
        #cur.execute(qry)
        os.rename(src,destn)

    for x in jsonFile:
        src = "%s%s" % ("./newman/",x)
        destn = "%s%s%s%s" % ("./operation/",sys.argv[1],"/json/",x)
        #qry = "insert into reportFile values('%s','%s','%s');" % (x,sys.argv[2],sys.argv[1])
        #print qry
        #cur.execute(qry)
        os.rename(src,destn)
    #con.commit()
except Exception, e:
    print 'Error %s' % e    
    sys.exit(1)
 #finally:
 #   
 #   if con:
 #       con.close()