#!/bin/bash

filename=$1
RUN_LIMIT=$2
NEW_PROCESS=$3
CLASS_NAME=$4

echo Checking $filename $RUN_LIMIT $NEW_PROCESS $CLASS_NAME
mkdir -p "/opt/pid"
PIDFILE="/opt/pid/$filename.pid"
echo
echo ---------------------------------
echo Starting $filename `date`

if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= |
                           grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  pid=$(cat ${PIDFILE});
  process=$(ps -p $pid o cmd=)
  echo $process process found!
  if [[ "$process" != *"$filename"* ]]; then
    echo "that's not me - " $process
    rm $PIDFILE
  else
    if (ps ax -opid= | grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
      RUN_LIMIT_SECONDS=$((60 * $RUN_LIMIT))
      echo RUN_LIMIT_SECONDS=$RUN_LIMIT_SECONDS
      #CHILD=`ps -o ppid= -o pid= -A | awk '$1 == $pid {print $2}'`
      CHILD=$(ps -o pid --no-headers --ppid $pid)
      CHILD_RUN_TIME=$(ps h -O etimes $CHILD | awk '{print $2}')
      echo Child is $CHILD Child Running for $CHILD_RUN_TIME and Limit is $RUN_LIMIT and RUN_LIMIT_SECONDS=$RUN_LIMIT_SECONDS

      TIME=$(ps --no-headers -o etime $pid | cut -d":" -f 1)
      echo Running for $TIME and Limit is $RUN_LIMIT and RUN_LIMIT_SECONDS=$RUN_LIMIT_SECONDS
      if [ "$CHILD_RUN_TIME" -gt "$RUN_LIMIT_SECONDS" ] ; then
        echo >> /opt/logs/$filename.sh.log.KILLS
        echo >> /opt/logs/$filename.sh.log.KILLS
        echo >> /opt/logs/$filename.sh.log.KILLS
        echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx >> /opt/logs/$filename.sh.log.KILLS
        date >> /opt/logs/$filename.sh.log.KILLS
        ps -U `whoami` -u `whoami` u f >> /opt/logs/$filename.sh.log.KILLS
        echo >> /opt/logs/$filename.sh.log.KILLS
        date >> /opt/logs/$filename.sh.log.KILLS
        echo Running for $CHILD_RUN_TIME seconds / $TIME and Limit is $RUN_LIMIT_SECONDS seconds / $RUN_LIMIT  >> /opt/logs/$filename.sh.log.KILLS
        echo "Running too long. Killing..." $CHILD  >> /opt/logs/$filename.sh.log.KILLS
        echo Running for $CHILD_RUN_TIME seconds / $TIME and Limit is $RUN_LIMIT_SECONDS seconds / $RUN_LIMIT
        echo "Running too long. Killing..." $CHILD
        kill -9 $CHILD   >> /opt/logs/$filename.sh.log.KILLS
      else
        echo "Already running." $pid.  Check $PIDFILE
        ps -o etime $pid
        exit 99
      fi
    fi
  fi
fi
echo $NEW_PROCESS > $PIDFILE
chmod 660 "${PIDFILE}"
exit 0






#########################################
#########################################
# Sample Usage
#########################################
#!/bin/bash
#####PID file handling #####
RUN_LIMIT=5
CLASS=pinger.js
SERVER_NAME=`hostname`

##### PID file handling - DO NOT TOUCH #####
NEW_PROCESS=$$ ; fullfile="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")" ; filename="${fullfile%.*}" ; /opt/BATCH_JOBS/PidCheckIfRunning.sh  $filename $RUN_LIMIT $NEW_PROCESS $CLASS ;retVal=$? ; echo Check returned $retVal ; if [ $retVal -eq 0 ]; then echo "Good to go" ; PIDFILE="/opt/pid/$filename.pid" ; else exit $retVal ; fi
##### PID file handling - DO NOT TOUCH #####


/usr/bin/node /opt/test/batch/pinger.js >> /opt/logs/pinger.log 2>&1

##### PID file handling - DO NOT TOUCH #####
echo Done $fullfile `date` ; echo ; rm $PIDFILE
##### PID file handling - DO NOT TOUCH #####
