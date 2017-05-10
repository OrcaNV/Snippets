@echo off
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

REM if not exist %1\%yy%                  mkdir %1\%yy%
REM if not exist %1\%yy%\%mm%             mkdir %1\%yy%\%mm%
REM if not exist %1\%yy%\%mm%\%dd%-%dow%  mkdir %1\%yy%\%mm%\%dd%-%dow%
d:
cd \
REM pause
date /t
time /t
echo Dumping catalog....
mysqldump -f --routines --user=ivruser --password=ivruser mysql  > BATCH-mysql-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping abs_rater database....
mysqldump -f --routines --user=ivruser --password=ivruser abs_rater > BATCH-abs_rater-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping abs database....
mysqldump -f --routines --user=ivruser --password=ivruser abs > BATCH-abs-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping consol_db database....
mysqldump -f --routines --user=ivruser --password=ivruser consol_db > BATCH-consol_db-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping ods database....
mysqldump -f --routines --user=ivruser --password=ivruser ods > BATCH-ods-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping tnt_db database....
mysqldump -f --routines --user=ivruser --password=ivruser tnt_db > BATCH-tnt_db-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping abs_uat database....
mysqldump -f --routines --user=ivruser --password=ivruser abs_uat > BATCH-abs_uat-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

echo Dumping ods_uat database....
mysqldump -f --routines --user=ivruser --password=ivruser ods_uat > BATCH-ods_uat-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
date /t
time /t

REM echo Dumping full database....
REM mysqldump -f --routines --user=ivruser --password=ivruser --all-databases > BATCH-FULL-%yy%%mm%%dd%-%dow%_%hh%%min%.BAK
REM date /t
REM time /t

echo Done
pause









