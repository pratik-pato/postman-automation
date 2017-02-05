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

call python createFolderTemplate.py BC
call python moveFolder.py BC
rem find and relace in file -> replace #ip# with param
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