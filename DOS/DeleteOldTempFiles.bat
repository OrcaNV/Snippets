@echo off
title Title Deleting files older 1 day in D:\TEMP
echo Title Deleting files older 1 day in D:\TEMP
forfiles /p "D:\TEMP" /d -1 /c "cmd /c IF @isdir == FALSE echo @path @fdate && IF @isdir == FALSE del @path"
echo.
echo.
echo Closing in approximately 30 seconds.....
ping -n 25 127.0.0.1 > nul
echo Closing in approximately 5 seconds....
ping -n 1 127.0.0.1 > nul
echo Closing in approximately 4 seconds...
ping -n 1 127.0.0.1 > nul
echo Closing in approximately 3 seconds..
ping -n 1 127.0.0.1 > nul
echo Closing in approximately 2 seconds.
ping -n 1 127.0.0.1 > nul
echo Closing in approximately 1 second
ping -n 1 127.0.0.1 > nul
exit