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

echo "---------------------------------------"
echo "----------- Secondary User ------------"
echo "Secondary user summary"
call newman run RetailBanking\SecondaryUser\SecondaryUser.json -e Environment.json -k --reporters html,cli,json,junit
echo "-------- Secondary User END -----------"

echo "-----------------------------------------"
echo "----------- Presonal Profile ------------"
echo "Presonal Profile summary"
call newman run RetailBanking\PersonalProfileEntitlements\PresonalProfileHarness.json -e Environment.json -k --reporters html,cli,json,junit
echo "-------- Presonal Profile END -----------"
rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Application Backend Status ------------" >> reports/%fixed%
rem echo "Get Application Backend Status Using filter criteria" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\ApplicationBackendStatus\AppStatusBackendFilter.json -e Environment.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Application Backend Status END -----------" >> reports/%fixed%

rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Application Account States Country List ------------" >> reports/%fixed%
rem echo "Get Application Account States Country List" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\ApplicationBackendStatus\AccountStatesCountryList.json -e Environment.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Application Account States Country List END -----------" >> reports/%fixed%


rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Wire Release Count ------------" >> reports/%fixed%
rem echo "Get Wire Release Count" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\WireRelease\GetWireReleaseCountinBankingEvent.json -e Environment.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Wire Release Count END -----------" >> reports/%fixed%


rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Retail Online Launchpad ------------" >> reports/%fixed%
rem echo "Get Retail Online Launchpad" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\RetailOnlineLaunchPad\RetailOnlineLaunchpad.json -e Environment.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Retail Online Launchpad END -----------" >> reports/%fixed%


rem find and relace in file -> replace #ip# with param

call python createFolderTemplate.py RB
call python moveFolder.py RB
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