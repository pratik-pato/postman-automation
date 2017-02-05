Description for workspace:
This workspace is meant for executing OData testing harness written using Postman and newman

Prerequisites :
1.Nodejs
2.newman (module)

1.
[If node.js is already installed you may skip this]
Get Node.js installer and install its open source.
How to check node is installed:
in command prompt run: 
    node -v
        > it will show version of node running on machine
    npm -v
        > it will show version of npm [npm is package manager]
2.
Once node and npm is installed you can install newman
Install newman module:
in command prompt run:
    npm install -g newman
        > it will install newman globally for that user
        location for module is : C:\Users\<UserName>\AppData\Roaming\npm
        [If you install any package with -g it will go to mentioned directory else it will install that package in current directory/node_module folder]




├───BusinessBanking
│   < Location for Business banking harness >
├───BusinessCentral
│   < Location for Business Central harness >
├───harnessData
│   < csv files passed to harness >
├───newman
│	< report files gets generated here and then moved to Archive during execution [This folder should be empty]>
├───operation
│   └───Archive
│       ├───BC
│       ├───CB
│       └───RB
├───RetailBanking
│   < Location for Consumer Banking harness >
└───src
    ├───dist
    │   ├───createFolderTemplate
    │   ├───csvGenerator
    │   ├───csvRunner
    │   │   └───newman
    │   ├───moveFolder
    │   ├───moveReportToDir
    │   └───tableGenerator
    │       └───__pycache__
    └───__pycache__


Description for batch files:
[ Each batch file contains summary in same file ]

runharness.bat : runs CB and BC Harness on same hit with ip as parameter
<usage>: runharness.bat https://10.97.188.237:8081

runharness_BC.bat : runs BC Harness on same hit with ip as parameter
<usage>: runharness_BC.bat https://10.97.188.237:8081

runharness_CB.bat : runs CB Harness on same hit with ip as parameter
<usage>: runharness_CB.bat https://10.97.188.237:8081

