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

    set "textFile=Environment_RB.json"

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

echo "---------------------------------------"
echo "----------- Secondary User ------------"
echo "Secondary user summary"
call newman run RetailBanking\SecondaryUser\SecondaryUser.json -e Environment_RB.json -k --reporters html,cli,json,junit
echo "-------- Secondary User END -----------"

echo "-----------------------------------------"
echo "----------- Presonal Profile ------------"
echo "Presonal Profile summary"
call newman run RetailBanking\PersonalProfileEntitlements\PresonalProfileHarness.json -e Environment_RB.json -k --reporters html,cli,json,junit
echo "-------- Presonal Profile END -----------"
rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Application Backend Status ------------" >> reports/%fixed%
rem echo "Get Application Backend Status Using filter criteria" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment_RB.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\ApplicationBackendStatus\AppStatusBackendFilter.json -e Environment_RB.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Application Backend Status END -----------" >> reports/%fixed%

rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Application Account States Country List ------------" >> reports/%fixed%
rem echo "Get Application Account States Country List" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment_RB.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\ApplicationBackendStatus\AccountStatesCountryList.json -e Environment_RB.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Application Account States Country List END -----------" >> reports/%fixed%


rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Wire Release Count ------------" >> reports/%fixed%
rem echo "Get Wire Release Count" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment_RB.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\WireRelease\GetWireReleaseCountinBankingEvent.json -e Environment_RB.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Wire Release Count END -----------" >> reports/%fixed%


rem echo "-------------------------------------------------" >> reports/%fixed%
rem echo "----------- Retail Online Launchpad ------------" >> reports/%fixed%
rem echo "Get Retail Online Launchpad" >> reports/%fixed%
rem rem call newman -c BusinessBanking\Profiles\BusinessUserProfileCRUD.json -e Environment_RB.json -k --testReportFile result.xml>> testCaseDetails.txt
rem call newman run RetailBanking\RetailOnlineLaunchPad\RetailOnlineLaunchpad.json -e Environment_RB.json -k --reporter-cli-no-assertions >> reports/%fixed%
rem echo "-------- Retail Online Launchpad END -----------" >> reports/%fixed%

rem ***********************************************************************************
rem SECTION 4 :
rem following program will call harness from csv file located at root of prject named input.csv

cd src\dist\csvRunner
call csvRunner.exe RB
cd..

rem ***********************************************************************************
rem SECTION 5 :
rem following set of programs will generate report files and store it in operation/Archive/<Application> folder for particular execution
rem createFolderTemplate internally calls moveReport.bat which calls moveReportToDir, csvGenerator, tableGenerator
rem moveFolder drops all files <reports> to operation/Archive/<Application> which is passed as parameter 

cd createFolderTemplate
call createFolderTemplate.exe RB
cd..
cd moveFolder
call moveFolder.exe RB



rem ***********************************************************************************
rem SECTION 5 :
rem Execution ends here and it reverts changes made during execution in Environment.jso to orignal one

echo Execution Ends On : %time% 
echo "report generated"

@echo off 
    set "search=%1"
    set "replace=http://localhost:8080"

    set "textFile=Environment_RB.json"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        set "line=!line:%search%=%replace%!"
        >>"%textFile%" echo(!line!
        endlocal
    )