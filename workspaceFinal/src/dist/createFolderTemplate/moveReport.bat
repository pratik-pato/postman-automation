cd ../moveReportToDir
echo "moving reports from newman to Archive"
moveReportToDir.exe %1 %2
cd ../csvGenerator
echo "generating csv"
csvGenerator.exe %1
cd ../tableGenerator
dir
tableGenerator.exe %1