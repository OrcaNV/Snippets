REM @echo off
date /t
time /t
echo.
rem Create the date and time elements.
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

REM For %%i in (dow dd mm yy hh min ss) do set %%i

title archiving OLD log files in %CATALINA_HOME%  %yy%/%mm%/%dd% %dow% %hh%:%min%:%ss%

echo CATALINA_HOME=%CATALINA_HOME%
echo.
if not exist %CATALINA_HOME%\nul goto CATALINA_NOT_FOUND

cd %CATALINA_HOME%
if not exist %CATALINA_HOME%\archive\nul mkdir %CATALINA_HOME%\archive
for /f %%a IN ('dir /b/ad logs_*') do (
   echo.
   echo.
   echo ===================================
   echo zip -9 -v  %%~fa.zip %%~nxa
   zip -9 -v  %%~fa.zip  %%~nxa/*
   
   :DELETE_TEMP
   if exist %%~fa.zip echo Deleting %%~fa
   if exist %%~fa.zip del /Q /S  %%~fa
   if exist %%~fa.zip if exist %%~fa\nul rmdir /s/q %%~fa
   if exist %%~fa.zip if exist %%~fa\nul goto DELETE_TEMP
   if exist %%~fa.zip echo.
   if exist %%~fa.zip move %%~fa.zip %CATALINA_HOME%\archive
   
   if exist %%~fa\nul pause
)

echo.
echo done!
REM pause
goto END

:CATALINA_NOT_FOUND
echo.
echo Tomcat NOT SET!!!
echo.
pause

:END
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
