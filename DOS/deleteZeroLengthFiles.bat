@echo off


if %1.==. goto FOLDER_NOT_SET
if not exist %1\nul goto FOLDER_DOES_NOT_EXIST


pushd %PARM_LOCAL%

for /f %%a IN ('dir /b/s/a-d') do (
 if %%~za equ 0 del %%~fa
)

popd
goto END


:FOLDER_NOT_SET
echo.
echo deleteZeroLengthFiles.bat MUST be invoked with the PATH to checkout!
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
