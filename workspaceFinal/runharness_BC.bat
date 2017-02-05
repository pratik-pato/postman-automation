rem SUMMARY:

rem This batch is meant for executing OData harness written in Postman using newman the cli companion for postman,
rem script reqires target machine address against which harness is going to execute,
rem script is divided into sections(chunk of script which execute part of whole batch)

rem Prerequisites :
rem 1.Nodejs
rem 2.newman (module)


rem ***********************************************************************************
rem SECTION 1 :
rem find and relace in file -> replace #ip# with parameter passed

echo %1

@echo off 
    set "search=http://localhost:8080"
    set "replace=%1"

    set "textFile=Environment.json"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        set "line=!line:%search%=%replace%!"
        >>"%textFile%" echo(!line!
        endlocal
    )

@echo off

rem ***********************************************************************************
rem SECTION 2 :
rem uncomment PATH if you are using it in jenkins project and assign required path according to machine

rem set PATH=%PATH%;C:\python27\
rem set PATH=%PATH%;C:\Users\Administrator\AppData\Roaming\npm\


rem ***********************************************************************************
rem SECTION 3 :
rem Execution of harness starts here, you may refer newman manual for usage of newman
rem You can manually enter harness in this SECTION

echo "-------------------------------------------------"
echo "----------- Retail User Profile CRUD ------------"
echo "Add/Edit/Delete Retail User Profile."
rem call newman -c BusinessCentral\Profiles\RetailUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
call newman run BusinessCentral\Profiles\RetailUserProfileCRUD.json -e Environment.json -k --reporters html,cli,json,junit
echo "-------- Retail User Profile CRUD END -----------"

echo "--------------------------------------------------------"
echo "----------- Assign Profile to Consumer User ------------"
echo "Assign/Edit/ Profile to retail user."
rem call newman -c BusinessCentral\ProfileAssignment\ProfileAssignmentRetail.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
call newman run BusinessCentral\ProfileAssignment\ProfileAssignmentRetail.json -e Environment.json -k --reporters html,cli,json,junit
echo "-------- Assign Profile to Consumer User END -----------"

echo "-------------------------------------------------"
echo "----------- Bank Employee Creation --------------"
echo "Add/Edit/Delete Bank Employee."
rem call newman -c BusinessCentral\Profiles\RetailUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
call newman run BusinessCentral\BankEmployee\BankEmployee.json -e Environment.json -k --reporters html,cli,json,junit
echo "-------- Bank Employee Creation END -------------"

echo "-----------------------------------------------" 
echo "----------- Lean Business Creation ------------"
echo "Add/Edit/Delete Lean Business"
call node addBusiness.js
rem call newman -c BusinessCentral\ProfileAssignment\ProfileAssignmentRetail.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
call newman run BusinessCentral\LeanBusinessCreation\LeanBusinesswithBusinessEmployees.json -e Environment.json -k -d business.csv --reporters html,cli,json,junit
echo "-------- Lean Business Creation END -----------"

echo "-----------------------------------------------------------"
echo "----------- Omni Channel User Profile Features ------------"

echo "PreReq for Omni Channel User Profile Features."
echo "PreReq will create Omni Channel profile without assigning features."

call newman run BusinessCentral\Features\OmniChannelProfileFeature\OnmiChannelFeaturePreReq.json -e Environment.json -k --export-environment newmanExport.json --reporters cli

echo "Add/Edit/Delete Omni Channel User Profile Features."
rem call node appendEnvironment.js > EnvironmentCBFeature.json // requires for newman v 3.1

call newman run BusinessCentral\Features\OmniChannelProfileFeature\OmniChannelProfileFeatures.json -e newmanExport.json -k -d BusinessCentral\Features\OmniChannelProfileFeature\OCBFeatures.csv --reporters html,cli,json,junit

echo "-------- Omni Channel User Profile Features END -----------"

echo "-----------------------------------------------------" 
echo "----------- Retail User Profile Features ------------"

echo "PreReq for Retail User Profile Features."
echo "PreReq will create Retail user profile without assigning features."

call newman run BusinessCentral\Features\ConsumerGroupFeature\RetailUserProfileFeaturePreReq.json -e Environment.json -k --export-environment newmanExport.json --reporters cli

echo "Add/Edit/Delete Retail User Profile Features."
rem call node appendEnvironment.js > EnvironmentCBFeature.json // requires for newman v 3.1

call newman run BusinessCentral\Features\ConsumerGroupFeature\RetailUserProfileFeatures.json -e newmanExport.json -k -d BusinessCentral\Features\ConsumerGroupFeature\retailFeatures.csv --reporters html,cli,json,junit

echo "-------- Retail User Profile Features END -----------"


rem ***********************************************************************************
rem SECTION 4 :
rem following program will call harness from csv file located at root of prject named input.csv

cd src\dist\csvRunner
call csvRunner.exe BC
cd..

rem ***********************************************************************************
rem SECTION 5 :
rem following set of programs will generate report files and store it in operation/Archive/<Application> folder for particular execution
rem createFolderTemplate internally calls moveReport.bat which calls moveReportToDir, csvGenerator, tableGenerator
rem moveFolder drops all files <reports> to operation/Archive/<Application> which is passed as parameter 

cd createFolderTemplate
call createFolderTemplate.exe BC
cd..
cd moveFolder
call moveFolder.exe BC



rem ***********************************************************************************
rem SECTION 5 :
rem Execution ends here and it reverts changes made during execution in Environment.jso to orignal one

echo Execution Ends On : %time%
echo "report generated"

@echo off 
    set "search=%1"
    set "replace=http://localhost:8080"

    set "textFile=Environment.json"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        set "line=!line:%search%=%replace%!"
        >>"%textFile%" echo(!line!
        endlocal
    )