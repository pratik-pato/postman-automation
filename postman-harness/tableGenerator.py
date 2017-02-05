import csv
import sys
import tableMod as t
import time;

localtime = time.asctime( time.localtime(time.time()) )

src = "%s%s%s" % ("./operation/",sys.argv[1],"/xml/summary.csv")
with open(src, 'rb') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
	rowList = []
	elements = ""
	totalReq = 0
	totalAsr = 0
	totalAsrFail = 0
	totalReqError = 0
	asrHtml = ""
	for row in spamreader:
		#print ', '.join(row)
		rowList.append(row)

print rowList[0]
for i in rowList[1:]:# range (1,len(rowList)-1):
	processList = i[:5]
	failure = i[5]
	print processList[0]
	failEntry = failure.split("#")
	failEntry.pop(0)
	#print failEntry
	if len(failEntry)>0:
			suitBullet = "%s%s" % (processList[0]," :</br>")
			entryBullet = ""
			for ele in failEntry:
				entry = ele.split("$")
				temp1 = "%s%s%s" % (failEntry.index(ele) + 1,". ",entry[0])
				temp2 = t.getTD(entry[1])
				temp1 = t.getTD(temp1)
				entryBullet = "%s%s%s%s%s" % (entryBullet,"<tr>",temp1,temp2,"</tr>")
				print entry
			allEntriesBullet = "<tr><th>Request</th><th>Assertion</th></tr>" 
			masterBulletList = "%s%s%s%s%s" % ('<table class="gridtable">',suitBullet,allEntriesBullet,entryBullet,'</table>')
			asrHtml = "%s%s" % (asrHtml,masterBulletList)
	tabRow = list(map((lambda x: t.getTH(x)), rowList[0][:5]))
	cols = t.getRow(''.join(tabRow))
	op = list(map((lambda x: t.getTD(x)), processList))
	totalReq = totalReq + int(processList[1])
	totalAsr = totalAsr + int(processList[2])
	totalAsrFail = totalAsrFail + int(processList[3])
	totalReqError = totalReqError + int(processList[4])
	str1 = ''.join(op)
	str2 = t.getRow(str1)
	elements = "%s%s" % (elements,str2)
#elements = ''.join(str1)
elements = "%s%s" % (cols,elements)
#print elements # table data rows


print totalReq,totalAsr,totalAsrFail,totalReqError

totalStr = '<tr><th>Total</th><th>%s</th><th>%s</th><th>%s</th><th>%s</th></tr>' % (totalReq,totalAsr,totalAsrFail,totalReqError)
elements = "%s%s" % (elements,totalStr)
finalTable = t.getTable(elements)
print finalTable
metaInfoHtml = '%s%s%s' % ('<!DOCTYPE html><html><head><style>table.gridtable {font-family: verdana,arial,sans-serif;   width: 65%;	font-size:12px;	color:#333333;	border-width: 1px;	border-color: #666666;	border-collapse: collapse;}table.gridtable th {	border-width: 1px;	padding: 8px;	border-style: solid;	border-color: #666666;	background-color: #dedede;}table.gridtable td {	border-width: 1px;	padding: 8px;	border-style: solid;	border-color: #666666;	background-color: #ffffff;} table.table1 {  font-family: verdana,arial,sans-serif;border-collapse: collapse;    width: 100%;}table.table1 th,table.table1 td {    text-align: left;    padding: 8px;}table.table1 tr:nth-child(even) {    background-color: #a6c1ed}</style></head><body><h2>Postman Harness Report</h2><p>Execution Time :</p><p>@ <strong>',localtime,'</strong></p><div style="overflow-x:auto;">')
#failHtml = '<ul><li>Top Level Item</li> <ul><li>Sub-Item 1</li><li>Sub-Item 2</li> </ul> <li>Top Level Item</li></ul>
destn = "%s%s%s" % ("./operation/",sys.argv[1],"/summary.html")
f = open(destn, 'w')
f.write(metaInfoHtml)
f.write(finalTable)
f.write("<h2>Failed Test Cases :<br><br>")
f.write(asrHtml)