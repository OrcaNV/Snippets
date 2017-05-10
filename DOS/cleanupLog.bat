
pushd C:\java\logArchives
forfiles /P "C:\java\logArchives" /S /M *log*.zip /D -366 /C "cmd /c del @path"
popd


pushd C:\java\logs
forfiles /P "C:\java\logs" /S /M *log*.zip /C "cmd /c move /y @path C:\Java\logArchives"
forfiles /P "C:\java\logs" /S /M *log* /D -3 /C "cmd /c if @isdir==FALSE zip @path.zip @path && cmd /c if @isdir==FALSE if exist @path.zip del @path"
popd


pushd C:\ftp\logs
forfiles /P "C:\ftp\logs" /S /M *log*.zip /C "cmd /c move /y @path C:\Java\logArchives"
forfiles /P "C:\ftp\logs" /S /M *log* /D -3 /C "cmd /c if @isdir==FALSE zip @path.zip @path && cmd /c if @isdir==FALSE if exist @path.zip del @path"
popd


pushd c:\
forfiles /P "C:" /M *log*.zip /C "cmd /c move /y @path C:\Java\logArchives"
forfiles /P "C:" /M *log* /D -3 /C "cmd /c if @isdir==FALSE zip @path.zip @path && cmd /c if @isdir==FALSE if exist @path.zip del @path"
popd

REM pause
@echo off
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
