@echo off
For /f "tokens=1-7 delims=:/-, " %%i in ('echo exit^|cmd /q /k"prompt $D $T"') do (
        For /f "tokens=2-4 delims=/-,() skip=1" %%a in ('echo.^|date') do (
                set dow=%%i
                set %%a=%%j
                set %%b=%%k
                set %%c=%%l
                set hh=%%m
                set min=%%n
                set ss=%%o
        )
)

Title Restarting Tomcat8 - %dow% %yy%.%mm%.%dd% %hh%:%min%:%ss% 


echo Stopping Tomcat8...
net stop Tomcat8

D:

:DELETE_WORK
REM echo Deleting D:\Java\Tomcat8.0\work
del /Q /S  D:\Java\Tomcat8.0\work
for /f "delims=" %%a in ('dir /ad /s /b D:\Java\Tomcat8.0\work') do (
   echo deleting %%a
   if exist %%a\nul rmdir /s /q %%a
)
echo Deleting D:\Java\Tomcat8.0\work
rmdir /s/q D:\Java\Tomcat8.0\work
echo.
if exist D:\Java\Tomcat8.0\work\nul goto DELETE_WORK

:RENAME_LOGS
echo.
echo Renaming D:\Java\Tomcat8.0\logs to D:\Java\Tomcat8.0\logs_%yy%-%mm%-%dd%_%hh%-%min%-%ss% 
cd D:\Java\Tomcat8.0\
ren logs logs_%yy%-%mm%-%dd%_%hh%-%min%-%ss% 
if exist logs\nul goto RENAME_LOGS

echo.
echo Starting Tomcat8...
net start Tomcat8
ping -n 1 127.0.0.1 > nul
net start Tomcat8
ping -n 1 127.0.0.1 > nul
net start Tomcat8
ping -n 1 127.0.0.1 > nul
net start Tomcat8

echo.
echo done!
REM pause

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
