@echo off
REM Purpose: transform an MS SQL script to work in MySQL

REM remove lines containing string
sed -i "/SET IDENTITY_INSERT/d" *.sql
REM remove empty lines
sed -i "/^$/d" *.sql
REM remove GO lines
sed -i "/^GO$/d" *.sql

REM remove the N'
sed -i "s/, N'/, '/g" *.sql
sed -i "s/\(N'/\('/g" *.sql

REM add semicolon to end of line
sed -i "s/$/;/g" *.sql

REM remove [dbo].
sed -i "s/\[dbo\]\.//g" *.sql

REM remove [ & ]
sed -i "s/\[//g" *.sql
sed -i "s/\]//g" *.sql

REM remove temporary files by retaining only SQL files
REM note: to run this command outside of batch file, change %%F to %F below
for /f %%F in ('dir /b /a-d ^| findstr /vile ".sql"') do del "%%F"
