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

Title Restarting Hamachi - %dow% %yy%.%mm%.%dd% %hh%:%min%:%ss% 

echo Stopping Hamachi...
net stop Hamachi2Svc & goto :STOPPED
ping -n 1 127.0.0.1 > nul
net stop Hamachi2Svc & goto :STOPPED
ping -n 1 127.0.0.1 > nul
net stop Hamachi2Svc & goto :STOPPED
ping -n 1 127.0.0.1 > nul
net stop Hamachi2Svc & goto :STOPPED

:STOPPED
echo.
echo Starting Hamachi...
net start Hamachi2Svc & goto :STARTED
ping -n 1 127.0.0.1 > nul
net start Hamachi2Svc & goto :STARTED
ping -n 1 127.0.0.1 > nul
net start Hamachi2Svc & goto :STARTED
ping -n 1 127.0.0.1 > nul
net start Hamachi2Svc & goto :STARTED

:STARTED
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
