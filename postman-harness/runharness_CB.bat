rem find and relace in file -> replace #ip# with param

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

echo "PreReq for Business User Profile Features."
echo "PreReq will create business profile without assigning features."

call newman run BusinessBanking\Features\CBFeaturePreReq.json -e Environment.json -k --export-environment newmanExport.json --reporters cli

echo "Add/Edit/Delete Business User Profile Features."

rem call node appendEnvironment.js > EnvironmentCBFeature.json // requires for newman version 3.1

call newman run BusinessBanking\Features\BusinessProfileFeatures.json -e newmanExport.json -k -d BusinessBanking\Features\featureData.csv --reporters html,cli,json,junit

rem find and relace in file -> replace #ip# with param
call python createFolderTemplate.py CB
call python moveFolder.py CB
echo Execution Ends On : %time% >> reports/%fixed%
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