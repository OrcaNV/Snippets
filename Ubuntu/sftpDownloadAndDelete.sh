#!/bin/bash

TEMP_DIR=/edi/inbound/temp
RECEIVED_FILES=/edi/received.lst
FINAL_DEST=/opt/sensor/fms/inbound/

# connect to sftp and download all files to folder
sftp -i /ftp/privateKey.ppk sftpuser@sftpServer <<EOF
cd ftp_out
mget * $TEMP_DIR/
quit
EOF

# list of downloaded files
ls $TEMP_DIR/ > $RECEIVED_FILES

# prefix with rm command
sed -i -e 's/^/rm "/' $RECEIVED_FILES

# put double quotes around each file to be able to parse spaces
sed -i -e 's/$/"/' $RECEIVED_FILES

# assemble script
echo 'sftp -i /ftp/privateKey.ppk sftpuser@sftpServer <<EOF' > TEMP_SCRIPT.sh
echo 'cd ftp_out' >> TEMP_SCRIPT.sh
cat $RECEIVED_FILES >>  TEMP_SCRIPT.sh
echo 'quit' >> TEMP_SCRIPT.sh
echo ' ' >> TEMP_SCRIPT.sh
echo 'EOF' >> TEMP_SCRIPT.sh
echo ' ' >> TEMP_SCRIPT.sh

# make script executable
chmod +x TEMP_SCRIPT.sh

# run as a script to remove all files already downloaded
/bin/bash TEMP_SCRIPT.sh


# move contents of locally downloaded folder to processed folder to be ready for next download
mv $TEMP_DIR/* $FINAL_DEST
