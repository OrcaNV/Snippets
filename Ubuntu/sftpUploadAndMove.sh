#!/bin/bash

SRC_DIR=/ftp/outbound/
DONE_DIR=/ftp/outbound/sent

pushAndMove() {
  ediFile=$1
  echo Pushing and Moving $ediFile
  echo 'sftp -i /ftp/privateKey.ppk sftpuser@sftpServer <<EOF' > TEMP_SCRIPT.sh
  echo 'cd ftp_in' >> TEMP_SCRIPT.sh
  echo 'put ' $ediFile >> TEMP_SCRIPT.sh
  echo 'quit' >>  TEMP_SCRIPT.sh
  echo ' ' >>  TEMP_SCRIPT.sh
  echo 'EOF' >>  TEMP_SCRIPT.sh
  # cat TEMP_SCRIPT.sh
  chmod +x TEMP_SCRIPT.sh
  /bin/bash TEMP_SCRIPT.sh
  mv $ediFile $DONE_DIR
  echo '*************************************'
  echo ' '
  echo ' '
}


cd $SRC_DIR
for filename in $SRC_DIR/*.xml; do
  pushAndMove ${filename##*/}
done
