@echo off
REM This script is used to collect information for Incident Response and Analysis.
REM Written by: Derek Armstrong, November 20, 2014

set datestamp=fixme
set systemid=localhost

ver | find "5.1" > nul
if %ERRORLEVEL% == 0 set datestamp=%date:~10,4%%date:~4,2%%date:~7,2%

ver | find "6.1" > nul
if %ERRORLEVEL% == 0 set datestamp=%date:~6,4%%date:~3,2%%date:~0,2%

echo Please ensure you can connect to the system and you are running this script as your FunctionalID account. If not, kill this batch file NOW!
echo.

set /p systemid=System to scan: 
echo.

echo Ready To Scan System: %systemid%
pause
echo.

psinfo64.exe \\%systemid% -s -d -accepteula > output\%systemid%-%datestamp%-psinfo.txt
psloggedon64.exe \\%systemid% -l -accepteula > output\%systemid%-%datestamp%-psloggedon.txt
pslist64.exe \\%systemid% -t -accepteula > output\%systemid%-%datestamp%-pslist.txt
pslist64.exe \\%systemid% -x -accepteula >> output\%systemid%-%datestamp%-pslist.txt
psexec64.exe \\%systemid% -accepteula ipconfig /displaydns > output\%systemid%-%datestamp%-ipconfigdns.txt
psexec64.exe \\%systemid% -accepteula netstat -nao > output\%systemid%-%datestamp%-netstat.txt
psservice64.exe \\%systemid% -accepteula > output\%systemid%-%datestamp%-psservice.txt
psexec64.exe \\%systemid% -c -f autorunsc64.exe -a * -h -c -s -vt -vs -accepteula * > output\%systemid%-%datestamp%-autorunsc.csv

pause