#!/bin/bash

##### PID file handling #####
fullfile="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
filename="${fullfile%.*}"
mkdir -p "$HOME/tmp"
PIDFILE="$HOME/tmp/$filename.pid"

echo ---------------------------------
date
echo $filename

if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= |
                           grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  pid=$(cat ${PIDFILE});
  process=$(ps -p $pid o cmd=)
  if [[ "$process" != *"$filename"* ]]; then
    echo "that's not me";
    rm $PIDFILE
  else
    TIME=$(ps --no-headers -o etime $pid | cut -d":" -f 2)
    if [ "$TIME" -gt 30 ] ; then
      echo "Process stuck?"
      ps --no-headers -o etime $pid
      kill $pid
      rm $PIDFILE
    else
      echo "Already running."
      exit 99
    fi
  fi
fi
echo $$ > $PIDFILE
chmod 644 "${PIDFILE}"
##### PID file handling #####


 # Do your thing here


##### PID file handling #####
rm $PIDFILE
##### PID file handling #####
