[ NOTE: You are currently reffering to unstable or one can say highly unorganised code so one may find some unused/redundant data and meant for specific application ]
This is set and first rough work :) of basic automation scripts for postman written for specific application in python, javascript and batch scripting

Prereq:
python
nodejs
node-module: newman,(if required mssql and ibm-db)


Directory Description :
BusinessBanking,BusinessCentral,RetailBanking : These are folders where test suits files (json files) written using postman application resides. These test suits gets called by batch script (Described further) using newman the cli companion for postman.

operation/Archive/<CB,BC,RB> : Contains reports (in format of html,json and xml) generated from execution of batch script (Described further) along with aggregate result in summary.html. For each run of batch script a folder with timestamp is created inside which these reports resides.

Important files and scripts :
batch scripts : runharness_BC, runharness_CB, runharness_RB are batch scripts doing same set of work but for making test suits for seperate sub application so that while adding test suits manually one can find it bit easy
      Working of batch script:
      1. script takes one command line argument which is ip address
      2. in the same directory there is Environment.json file in which default ip is of localhost, here script first looks for that ip and replace it with ip provided by command line
      3. then important lines are there to call our test suits files (json files) which are in those 3 directories using newman command
      4. after calling each individual suit newman has created its execution reports in seperate files so we need to organize them into seperate run event, to organize them we call some python scripts which results in everything that you see in operation/Archive Folder
      5. after evrything is done we revert changes made in Environment.json for next execution to run

python scripts :
       1> createFolderTemplate.py : takes argument as application name (CB/BC/RB) and create folder template with CB->timestampFolder->html,json,xml directories and then calls moveReport.bat which calls moveReportToDir.py csvGenerator.py tableGenerator.py
       2> moveReportToDir.py : old version of newman generates all reports in folder named newman, here we move all those specific reports to desired folders i.e. html,json and html
       3> csvGenerator.py : this scripts reads all xml reports generated in that specific run and creates aggregate run summary in summary.csv which gets generated at xml directory
       4>tableGenerator.py : this script reads summary.csv and create html file viz. summary.html (location is parallel to xml,json and html directory)