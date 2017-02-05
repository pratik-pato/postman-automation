import xmltodict
import csv
import os
import sys

listSuit = []
listRequests = []
listAssertions = []
listFailCount = []
listFailMap = []
listError = []
#listFailMap = []
srcDir = "%s%s%s" % ("./operation/",sys.argv[1],"/xml")
#srcDir = '/BC/Wed_Nov_02_14-15-14_2016/xml'
for filename in os.listdir(srcDir):

	with open(os.path.join(srcDir, filename)) as fd:
	    doc = xmltodict.parse(fd.read())
		
	req = len(doc['testsuites']['testsuite'])
	cnt = 0
	failCnt = 0
	failREQCnt = 0
	failMap = []
	failMapStr = ""
	failedAssertionList = []
	failedREQRequestList = []
	failedREQList = []
	failedRequestList = []

	listSuit.append(doc['testsuites']['@name'])
	print req
	for i in range(0,req):
		#print (doc['testsuites']['testsuite'][i]['testcase']['@name'])
		#print type(doc['testsuites']['testsuite'][i]['testcase'])
		try:
			if type(doc['testsuites']['testsuite'][i]['testcase']) == list:
				#print "list"
				#print doc['testsuites']['@name'],i # suit name
				#print doc['testsuites']['testsuite'][i]['@name'],i  # request name
				for j in range (0,len(doc['testsuites']['testsuite'][i]['testcase'])):
					#print doc['testsuites']['testsuite'][i]['testcase'][j],i # assertion name
					#print doc['testsuites']['testsuite'][i]['testcase'][j],i,j
					try:
						fail = doc['testsuites']['testsuite'][i]['testcase'][j]['failure']
						failedAssertion = doc['testsuites']['testsuite'][i]['testcase'][j]['@name']
						failedAssertionList.append(failedAssertion)
						failedRequestList.append(doc['testsuites']['testsuite'][i]['@name'])
						failCnt = failCnt + 1
					except Exception, e:
						print e
					#print doc['testsuites']['testsuite'][i]['testcase'][j]['failure'],i
					cnt = cnt + 1
					#if doc['testsuites']['testsuite'][i]['testcase'][j]['failure']['@type']:
					#	print doc['testsuites']['testsuite'][i]['testcase'][j]['failure']['@type']
			else:
				#print "No"
				print len(doc['testsuites']['testsuite'][i]['testcase'])
				print doc['testsuites']['@name'],i # suit name
				print doc['testsuites']['testsuite'][i]['@name'],i  # request name
				print doc['testsuites']['testsuite'][i]['testcase'],i # assertion name
				try:
						fail = doc['testsuites']['testsuite'][i]['testcase']['failure']
						failedAssertion = doc['testsuites']['testsuite'][i]['testcase']['@name']
						failedAssertionList.append(failedAssertion)
						failedRequestList.append(doc['testsuites']['testsuite'][i]['@name'])
						failCnt = failCnt + 1
				except Exception, e:
						print e

				try:
						failREQ = doc['testsuites']['testsuite'][i]['error']
						# print failREQ console error string
						failREQCnt = failREQCnt + 1
						failedREQ = doc['testsuites']['testsuite'][i]['testcase']['@name']
						failedREQList.append(failedREQ)
						failedREQRequestList.append(doc['testsuites']['testcase'][i]['@name'])
				except Exception, e:
						print e
					#print doc['testsuites']['testsuite'][i]['testcase'][j]['failure'],i
					#cnt = cnt + 1
				cnt = cnt + 1
		except Exception, e:
				print e
				try:
						failREQ = doc['testsuites']['testsuite'][i]['error']
						# print failREQ console error string
						failREQCnt = failREQCnt + 1
						failedREQ = doc['testsuites']['testsuite'][i]['testcase']['@name']
						failedREQList.append(failedREQ)
						failedREQRequestList.append(doc['testsuites']['testcase'][i]['@name'])
				except Exception, e:
						print e
	#print len(doc['testsuites']['testsuite'][2]['testcase']['failure']['#text'])
	listRequests.append(i+1)
	listAssertions.append(cnt)
	listError.append(failREQCnt)
	#OrderedDict([(u'testsuites', OrderedDict([(u'@name', u'RetailUserProfileCRUD'), (u'testsuite', [OrderedDict([(u'@name', u'Login to BC as admin'), (u'@id', u'a8f1f722-8ed0-4531-889e-0ad01ffe0dd6'), (u'@time', u'839'), (u'testcase', OrderedDict([(u'@name', u'status code is 201 : Created')]))]), OrderedDict([(u'@name', u'Add RetailUser Profile'), (u'@id', u'4a24dfbd-f40a-4dc3-bd3b-7c43a884c077'), (u'@time', u'377'), (u'testcase', OrderedDict([(u'@name', u'status code is 201 : Created')]))]), OrderedDict([(u'@name', u'delete Retail profile 1'), (u'@id', u'46e596ae-d74a-4331-811f-87730086087d'), (u'@time', u'756'), (u'testcase', OrderedDict([(u'@name', u'status code is 204 : No Content'), (u'failure', OrderedDict([(u'@type', u'AssertionFailure'), ('#text', u'Failed 1 times.')]))]))]), OrderedDict([(u'@name', u'Add RetailUserProfile to test Duplicate profile'), (u'@id', u'bda3aed6-581e-4a23-a982-7237cf3a8ff5'), (u'@time', u'317'), (u'testcase', OrderedDict([(u'@name', u'status code is 201 : Created')]))]), OrderedDict([(u'@name', u'Add RetailUserProfile Duplicate profile'), (u'@id', u'820cd3fb-f1d2-4c77-9d41-387a4d9cfa60'), (u'@time', u'735'), (u'testcase', OrderedDict([(u'@name', u'status code is 400 : Bad Request')]))]), OrderedDict([(u'@name', u'delete Retail profile 2'), (u'@id', u'e97d1dd5-8a24-40da-aca8-d5e91cf892f9'), (u'@time', u'1026'), (u'testcase', OrderedDict([(u'@name', u'status code is 204 : No Content')]))]), OrderedDict([(u'@name', u'Add Business Profile Invalid Channel'), (u'@id', u'ee171bd9-61eb-419e-b846-e66f4ab11c90'), (u'@time', u'678'), (u'testcase', OrderedDict([(u'@name', u'status code is 400 : Bad Request')]))]), OrderedDict([(u'@name', u'Add Retail Profile Duplicate Channel'), (u'@id', u'ae87419c-2eb9-40b2-bee3-d03c2ecd134e'), (u'@time', u'1087'), (u'testcase', [OrderedDict([(u'@name', u'status code is 400 : Bad Request')]), OrderedDict([(u'@name', u'Error Message : Duplicate channel in profile.')])])]), OrderedDict([(u'@name', u'Add Retail Profile With Special Character'), (u'@id', u'8920c674-1f0b-46f8-8da9-d9b94fb47b8f'), (u'@time', u'1007'), (u'testcase', [OrderedDict([(u'@name', u'status code is 400 : Bad Request')]), OrderedDict([(u'@name', u'Error Message : Name is 3-200 characters and can include numbers, letters, spaces, periods, and underscores.')])])]), OrderedDict([(u'@name', u'Add Retail Profile With Not allowed parentEntId'), (u'@id', u'8ca233b6-90f8-489e-b0e3-2f9893be88bd'), (u'@time', u'983'), (u'testcase', [OrderedDict([(u'@name', u'status code is 400 : Bad Request')]), OrderedDict([(u'@name', u'Error Message : Invalid Parent Group for Profile')])])]), OrderedDict([(u'@name', u'Add RetailProfile With Invalid parentEntId'), (u'@id', u'0862e481-e5b5-4784-a9ed-932e01c3c2ef'), (u'@time', u'1619'), (u'testcase', [OrderedDict([(u'@name', u'status code is 400 : Bad Request')]), OrderedDict([(u'@name', u'Error Message : Invalid Profile')])])]), OrderedDict([(u'@name', u'Add Retail Profile With No Channel'), (u'@id', u'2236c926-0f2c-421a-817a-c8909e9b19a2'), (u'@time', u'1088'), (u'testcase', [OrderedDict([(u'@name', u'status code is 400 : Bad Request')]), OrderedDict([(u'@name', u'Error Message : Please select atleast one channel.')])])]), OrderedDict([(u'@name', u'Add Retail Profile for get by Id'), (u'@id', u'f59029ed-26e0-430c-897d-fa9657023043'), (u'@time', u'658'), (u'testcase', OrderedDict([(u'@name', u'status code is 201 : Created')]))]), OrderedDict([(u'@name', u'get profile by Id'), (u'@id', u'de2adab0-508f-425f-a60d-2d67ce547582'), (u'@time', u'244'), (u'testcase', [OrderedDict([(u'@name', u'status code is 200 : OK')]), OrderedDict([(u'@name', u'Profile Id verified : 2057')])])]), OrderedDict([(u'@name', u'Modify Retail user profile'), (u'@id', u'8b20a73a-0ca8-4261-98df-c34aace5b438'), (u'@time', u'472'), (u'testcase', OrderedDict([(u'@name', u'status code is 204 : No Content')]))]), OrderedDict([(u'@name', u'get profile by Id Verify modification'), (u'@id', u'8a59b959-2cfa-4aca-81b2-eb5912a3882b'), (u'@time', u'238'), (u'testcase', [OrderedDict([(u'@name', u'Body has Sms Channel')]), OrderedDict([(u'@name', u'Body has No Mobile Channel')]), OrderedDict([(u'@name', u'status code is 200 : OK')]), OrderedDict([(u'@name', u'Profile Id verified : 2057')])])]), OrderedDict([(u'@name', u'delete profile3'), (u'@id', u'6ee6e4a5-7a76-4fe7-b960-c057a996dc7c'), (u'@time', u'1260'), (u'testcase', OrderedDict([(u'@name', u'status code is 204 : No Content')]))]), OrderedDict([(u'@name', u'get profile by Id Verify Delete'), (u'@id', u'3a5f4c90-d482-4988-8867-732fb17f5bce'), (u'@time', u'687'), (u'testcase', [OrderedDict([(u'@name', u'status code is 400 : Bad Request')]), OrderedDict([(u'@name', u'Error Message : Invalid Profile Id')])])])])]))])

	#print doc['testsuites']['testsuite'][i]['testcase'][j]['failure']['@type']
	for x in range (0,len(failedRequestList)):
		reqAsrTuple = (failedRequestList[x],failedAssertionList[x])
		strn = "%s$%s" % (failedRequestList[x],failedAssertionList[x])
		#print strn
		failMapStr = "%s#%s" % (failMapStr,strn)
		failMap.append(reqAsrTuple)

	#print failMapStr
	#str = 
	#print len(failedAssertionList)
	listFailCount.append(len(failedAssertionList))
	listFailMap.append(failMapStr)


	print "Suit: ",listSuit
	print "Assertiuons: ",listAssertions
	print "ReqCnt: ",listRequests
	print "FailAssrCnt: ",listFailCount
	print "FailMap: ",listFailMap
	print "ReqFail: ",listError

	csvDestn = "%s%s" % (srcDir,"/summary.csv")
	with open(csvDestn, 'wb') as csvfile:
		fieldnames = ['Suit', 'Requests', 'Assertions', 'FailCount','ErrorCount', 'FailMap']
		writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
	
		writer.writeheader()
		for k in range (0,len(listSuit)):
			writer.writerow({'Suit': listSuit[k], 'Requests': listRequests[k], 'Assertions': listAssertions[k], 'FailCount': listFailCount[k], 'ErrorCount': listError[k], 'FailMap': listFailMap[k]})
