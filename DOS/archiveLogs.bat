@echo off

if %1.==. goto FOLDER_NOT_SET
if not exist %1\nul goto FOLDER_DOES_NOT_EXIST

pushd %1
cd

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

REM   help call

for /f %%a IN ('dir /b/a-d *.txt') do (
   if not exist %%~dpa%yy%                  mkdir %%~dpa%yy%
   if not exist %%~dpa%yy%\%mm%             mkdir %%~dpa%yy%\%mm%
   rem if not exist %%~dpa%yy%\%mm%\%dd%-%dow%  mkdir %%~dpa%yy%\%mm%\%dd%-%dow%
   echo fullpath=%%~fa
   rem ECHO filedrive=%%~da
   rem ECHO filepath=%%~pa
   rem ECHO filename=%%~na
   rem ECHO fileextension=%%~xa
   rem ECHO filename_ext=%%~nxa

   C:\zip-3.0\bin\zip -u %%~dpa%yy%\%mm%\logs-%yy%%mm%%dd%-%dow%.zip  %%~nxa
   del %%~fa
   rem move %%~fa  %%~dpa%yy%\%mm%\%dd%-%dow%\
)


popd
goto END


:FOLDER_NOT_SET
echo.
echo.
echo [%0] MUST be invoked with the PATH to checkout!
echo.
echo.
pause
goto END


:FOLDER_DOES_NOT_EXIST
echo.
echo.
echo [%0] MUST be invoked with an existing FOLDER!
echo.
echo.
pause
goto END


:END
echo Will close in approx 30 seconds...
ping -n 30 127.0.0.1 > nul
echo Will close in approx 5 seconds...
ping -n 1 127.0.0.1 > nul
echo Will close in approx 4 seconds...
ping -n 1 127.0.0.1 > nul
echo Will close in approx 3 seconds...
ping -n 1 127.0.0.1 > nul
echo Will close in approx 2 seconds...
ping -n 1 127.0.0.1 > nul
echo Will close in approx 1 second...
ping -n 1 127.0.0.1 > nul
