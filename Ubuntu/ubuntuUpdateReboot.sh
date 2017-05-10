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

pushd /opt/tomcat/
find /opt/tomcat/ -type d \( -name "logs.[0-9][0-9]" \) -mtime +3 -print -exec rm -Rf {} \;
popd
pushd /opt/tomcat/ARCHIVE/
find /opt/tomcat/ARCHIVE/  \( -name "*" ! -iname "*.tgz" \) -mtime +90 -print -exec rm -Rf {} \;
find /opt/tomcat/ARCHIVE/ -type f \( -name "*" ! -iname "*.tgz" \) -mtime +90 -print -exec rm -Rf {} \;
popd
pushd /opt/openport/logs/
find /opt/openport/logs/ -mtime +90 -print -exec rm -Rf {} \;
find /opt/openport/logs/ -type f \( -name "*" ! -iname "*.gz" \)  -mtime +10 -print -exec gzip -f {} \;
popd

dateD=$(date +"%d")
LOGFILE=/opt/openport/logs/UbuntuUpdateReboot.log.$dateD
echo ====================== > $LOGFILE
date  2>&1 >> $LOGFILE
initctl stop tomcat >> $LOGFILE
date  2>&1 >> $LOGFILE
echo updating >> $LOGFILE
apt-get update 2>&1  >> $LOGFILE
date  2>&1 >> $LOGFILE
echo upgrading 2>&1  >> $LOGFILE
apt-get upgrade -q -y 2>&1  >> $LOGFILE

date  2>&1 >> $LOGFILE
cd /opt/tomcat/logs
ymd=$(date +"%Y-%m-%d")
hm=$(date +"%H-%M")
tar -zcvf /opt/tomcat/ARCHIVE/tomcat-logs-$ymd-$hm.tgz *


date  2>&1 >> $LOGFILE
rm -Rf /opt/tomcat/logs/* 2>&1 >> $LOGFILE
date  2>&1 >> $LOGFILE
# mkdir /opt/tomcat/logs
# chown tomcat:openport /opt/tomcat/logs

date  2>&1 >> $LOGFILE
echo Backup DB >> $LOGFILE
/opt/openport/BATCH_JOBS/backup_DBs.sh




DayOfWeek=$(date +%w)
Day=$(date +%-d)

date  2>&1 >> $LOGFILE

if [[ $Day -le 7 && $DayOfWeek == 0 ]]
then
  pushd /var/log/mysql
  service mysql stop
  mv mysql.log mysql.log.$ymd-$hm
  mv slow.log  slow.log.$ymd-$hm
  mv error.log error.log.$ymd-$hm

  rm $PIDFILE
  echo rebooting >> $LOGFILE
  /sbin/reboot 2>&1 >> $LOGFILE
else
  service mysql start >> $LOGFILE
  initctl start tomcat >> $LOGFILE
  date  2>&1 >> $LOGFILE
  rm $PIDFILE
fi
