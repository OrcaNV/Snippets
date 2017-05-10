@echo off
d:
set MARIADB_HOME=D:\MariaDB5.5
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

Title Restarting MySQL - %dow% %yy%.%mm%.%dd% %hh%:%min%:%ss% 

echo Stopping MySQL...
net stop MySQL

:RENAME_LOGS
echo.
echo Renaming %MARIADB_HOME%\data\346107-batch.err to %MARIADB_HOME%\data\346107-batch_%yy%-%mm%-%dd%_%hh%-%min%-%ss%.err
cd %MARIADB_HOME%\data
ren 346107-batch.err 346107-batch_%yy%-%mm%-%dd%_%hh%-%min%-%ss%.err
if exist 346107-batch.err goto RENAME_LOGS


echo.
echo Starting MySQL...
net start MySQL

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
