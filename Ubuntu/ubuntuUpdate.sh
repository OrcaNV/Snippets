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


apt-get update
apt-get upgrade -y

rm $PIDFILE
