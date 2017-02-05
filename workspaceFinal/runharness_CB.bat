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

echo %date%
echo Execution Started On : %time%
echo Environment URL : %1

echo "---------------------------------------------------"
echo "----------- Business User Profile CRUD ------------"
echo "Add/Edit/Delete Business User Profile." 
rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
call newman run BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment.json -k --reporters html,cli,json,junit 
echo "-------- Business User Profile CRUD END -----------"


echo "--------------------------------------------------------"
echo "----------- Assign Profile to Business User ------------"
echo "Assign/Edit/ Profile to business user."
rem call newman -c BusinessBanking\ProfileAssignment\ProfileAssignmentsBusiness.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
call newman run BusinessBanking\ProfileAssignment\ProfileAssignmentsBusiness.json -e Environment.json -k --reporters html,cli,json,junit
echo "-------- Assign Profile to Business User END -----------" 


echo "-------------------------------------------------------"
echo "----------- Business User Profile Features ------------"

rem echo "PreReq for Business User Profile Features."
rem echo "PreReq will create business profile without assigning features."
rem call newman run BusinessBanking\Features\CBFeaturePreReq.json -e Environment.json -k --export-environment newmanExport.json --reporters cli

rem echo "Add/Edit/Delete Business User Profile Features."
rem rem call node appendEnvironment.js > EnvironmentCBFeature.json // requires for newman version 3.1

rem call newman run BusinessBanking\Features\BusinessProfileFeatures.json -e newmanExport.json -k -d BusinessBanking\Features\featureData.csv --reporters html,cli,json,junit



rem ***********************************************************************************
rem SECTION 4 :
rem following program will call harness from csv file located at root of prject named input.csv

cd src\dist\csvRunner
call csvRunner.exe CB
cd..

rem ***********************************************************************************
rem SECTION 5 :
rem following set of programs will generate report files and store it in operation/Archive/<Application> folder for particular execution
rem createFolderTemplate internally calls moveReport.bat which calls moveReportToDir, csvGenerator, tableGenerator
rem moveFolder drops all files <reports> to operation/Archive/<Application> which is passed as parameter 

cd createFolderTemplate
call createFolderTemplate.exe CB
cd..
cd moveFolder
call moveFolder.exe CB



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