@ECHO OFF
set IS_EMPTY=Y

for /f "delims=" %%a in ('dir /a-d /s /b C:\Java\Tomcat7.0\updates\*.war') do (
   echo x > C:\Java\Tomcat7.0\updates\restart
   :HAS_NOT_MOVED
   echo move %%~fa  C:\Java\Tomcat7.0\webapps
   move /y %%~fa C:\Java\Tomcat7.0\webapps
   if exist %%~fa goto HAS_NOT_MOVED
   
   :HAS_NOT_BEEN_WIPED
   echo wiping C:\Java\Tomcat7.0\webapps\%%~na
   rmdir /s/q C:\Java\Tomcat7.0\webapps\%%~na
   if exist C:\Java\Tomcat7.0\webapps\%%~na goto HAS_NOT_BEEN_WIPED

)

if not exist C:\Java\Tomcat7.0\updates\restart goto DONE
echo Needs to restart
del C:\Java\Tomcat7.0\updates\restart 
C:\Java\batch_jobs\restartTomcat.bat

:DONE
echo.
echo done!
REM pause

echo.
echo.
echo Closing in approximately 10 seconds.....
ping -n 5 127.0.0.1 > nul
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
