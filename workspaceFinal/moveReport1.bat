cd src/dist/moveReportToDir
start moveReportToDir.exe %1 %2
cd ../csvGenerator
start csvGenerator.exe %1
cd ../tableGenerator
call tableGenerator.exe %1