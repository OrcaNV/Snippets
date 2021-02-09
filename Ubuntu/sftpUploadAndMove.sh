#!/bin/bash

TEMP_SCRIPT=TEMP_STATUS_SCRIPT.sh
SRC_DIR=/ftp/outbound/
DONE_DIR=/ftp/outbound/sent

pushAndMove() {
  ediFile=$1
  echo Pushing and Moving $ediFile
  echo 'sftp -i /ftp/privateKey.ppk sftpuser@sftpServer <<EOF' > $TEMP_SCRIPT
  echo 'cd ftp_in' >> $TEMP_SCRIPT
  echo 'put ' $ediFile >> $TEMP_SCRIPT
  echo 'quit' >>  $TEMP_SCRIPT
  echo ' ' >>  $TEMP_SCRIPT
  echo 'EOF' >>  $TEMP_SCRIPT
  # cat $TEMP_SCRIPT
  chmod +x $TEMP_SCRIPT
  /bin/bash $TEMP_SCRIPT
  mv $ediFile $DONE_DIR
}

echo ' '
echo ' '
date
echo '************************************* Starting'
cd $SRC_DIR
for filename in $SRC_DIR/*.xml; do
  pushAndMove ${filename##*/}
  date
done

date
echo 'Done'
