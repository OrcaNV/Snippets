@echo off

date /t
time /t
echo Processing %1

set tmp_file=tmp_%1
set log_file=tmp_%1.log
copy %1 %tmp_file%
date /t >> %log_filelog_file%
time /t >> %log_filelog_file%
dir  %1 >> %log_filelog_file%

REM change table name. e.g.  Order to Orders
sed -i "s/\[Order\]/\[Orders\]/" %tmp_file%
sed -i "s/\[OrderId\]/\[OrdersId\]/" %tmp_file%

REM remove lines containing string
sed -i "/^SET IDENTITY_INSERT.*OFF$/d" %tmp_file%

REM change   SET IDENTITY_INSERT [dbo].[Order] ON     to TRUNCATE TABLE Order
sed -i "s/] ON $//" %tmp_file%
sed -i "s/SET IDENTITY_INSERT \[dbo\].\[/truncate table /" %tmp_file%

REM remove empty lines
sed -i "/^$/d" %tmp_file%
REM remove GO lines
sed -i "/^GO$/d" %tmp_file%

REM remove the N'
sed -i "s/, N'/, '/g" %tmp_file%
sed -i "s/(N'/('/g" %tmp_file%

REM add semicolon to end of line
sed -i "s/$/;/g" %tmp_file%

REM remove [dbo].
sed -i "s/\[dbo\]\.//g" %tmp_file%

REM remove [ & ]
sed -i "s/\[//g" %tmp_file%
sed -i "s/\]//g" %tmp_file%

sed -i "s/Vendor/Client/g" %tmp_file%

REM remove the datetime casting -- CAST(N'2020-09-17 11:05:34.5524000' AS DateTime2)
sed -i "s/CAST(N'/'/g" %tmp_file%
sed -i "s/' AS DateTime2)/'/g" %tmp_file%
sed -i "s/CAST('/'/g" %tmp_file%
sed -i "s/' AS Date)/'/g" %tmp_file%
sed -i "s/' AS DateTime)/'/g" %tmp_file%

sed -i "s/\\/\\\\/g" %tmp_file%

REM remove temporary files by retaining only SQL files
REM note: to run this command outside of batch file, change %%F to %F below
for /f %%F in ('dir /b /a-d ^| findstr /vile ".sql"') do del "%%F"

dir  %tmp_file% >> %log_filelog_file%
Echo loading %tmp_file%
mysql -h dev.c6dxd4yilwaz.us-west-2.rds.amazonaws.com -u oscar -pB1rdb@thFlaxenMidLifeRowdy dev < %tmp_file%

IF %ERRORLEVEL% NEQ 0 (
  echo FAILED...
    date /t 
    time /t
    echo FAILED... >> %log_filelog_file%
    date /t >> %log_filelog_file%
    time /t >> %log_filelog_file%
  pause
  ) else (
    date /t 
    time /t
    echo SUCCESS...
    echo SUCCESS... >> %log_filelog_file%
	date /t >> %log_filelog_file%
    time /t >> %log_filelog_file%
)
del %tmp_file%
echo.
echo.
echo.
echo.
echo.
echo.
echo.
