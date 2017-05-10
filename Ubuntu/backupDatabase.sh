#!/bin/bash

##### PID file handling #####
fullfile="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
filename="${fullfile%.*}"
mkdir -p "$HOME/tmp"
PIDFILE="$HOME/tmp/$filename.pid"

if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= |
                           grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  echo "Already running."
  exit 99
fi
echo $$ > $PIDFILE
chmod 644 "${PIDFILE}"
##### PID file handling #####



user="dbUser"
password="dbPassword"
host="localhost"

backup_path="/opt/company/data/DB_BAK"
date=$(date +"%Y%m%d")
dateY=$(date +"%Y")
dateM=$(date +"%m-%b")
dateD=$(date +"%d-%a")

# Get list of databases
databases=$(mysql --user=$user --password=$password -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)")

# Create folder using date
# mkdir $backup_path/$dateY
# mkdir $backup_path/$dateY/$dateM
mkdir -p $backup_path/$dateY/$dateM/$dateD
mkdir -p $backup_path/latest

# Create dumps for each database
for db in $databases
do
  time=$(date +"%H-%M-%S")
  echo Generating $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.BAK.gz
  mysqldump -f --routines --user=$user --password=$password --host=$host $db | gzip > $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.BAK.gz
  cp $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.BAK.gz  $backup_path/latest/$db.latest.BAK.gz
  mysqldump -f --routines --no-data --no-create-db --skip-opt --user=$user --password=$password --host=$host $db | gzip > $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.createOnly.BAK.gz
  cp $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.createOnly.BAK.gz  $backup_path/latest/$db.createOnly.latest.BAK.gz
  mysqldump -f --routines --no-create-info --no-data --no-create-db --skip-opt --user=$user --password=$password --host=$host $db | gzip > $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.procs.BAK.gz
  cp $backup_path/$dateY/$dateM/$dateD/$db-$date-$time.procs.BAK.gz  $backup_path/latest/$db.proc.latest.BAK.gz
done

# delete backups older than 30 days, except for day 1 of every month or the 'latest'
find /opt/company/data/DB_BAK/ -type f -mtime +30 \( ! -iname "*-[0-9][0-9][0-9][0-9][0-9][0-9]01-[0-9][0-9]-[0-9][0-9]-[0-9][0-9].BAK.gz" ! -iname "*-[0-9][0-9][0-9][0-9][0-9][0-9]01-[0-9][0-9]-[0-9][0-9]-[0-9][0-9].*.BAK.gz" ! -iname "*.latest.BAK.gz" \)  -execdir rm -Rf -- {} +
find /opt/company/data/DB_BAK/ -type d -mtime +7 \( -iname "[0-3][0-9]-[FMSTW][aehoru][deintu]" ! -name "01-[FMSTW][aehoru][deintu]" ! -name "[0-3][0-9]-Sun" \)   -exec rm -Rf -- {} +
find /opt/company/data/DB_BAK/ -empty -type d -delete


rm $PIDFILE

