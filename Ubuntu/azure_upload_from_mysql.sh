#!/bin/bash

USER="mysqlUser"
PASS="mysqlPassword"
HOST="localhost"
DBNAME="mysqlDb_db"

export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=azureAccountName;AccountKey=azureAccountKeyOrPassword;"

today=$(date +%Y%m%d)
now=$(date +%H%M)

if ! grep -q $today FULL.dump; then

 echo Taking a dump...
 /usr/bin/mysql --default-character-set=utf8 --host=$HOST --user=$USER --password=$PASS $DBNAME -e "SET names 'utf8'; select * from analytics_db.vw_purchase_order_sg;" | sed 's/\t/;/g' > purchase_order.csv
 /usr/bin/mysql --host=$HOST --user=$USER --password=$PASS ods_utf8_db -e "SET names 'utf8'; select * from analytics_db.vw_equipment_sg;" | sed 's/\t/;/g' > equipment.csv

 azure storage blob upload -q purchase_order.csv    data $today/purchase_order.csv
 azure storage blob upload -q equipment.csv     data $today/equipment.csv

 echo $today > FULL.dump
 rm $PIDFILE
 ./azureDeleteFilesFromYesterday.sh

else

 echo Taking a dump...
 /usr/bin/mysql --default-character-set=utf8 --host=$HOST --user=$USER --password=$PASS $DBNAME -e "SET names 'utf8'; select * from analytics_db.vw_purchase_order_diff_sg;" | sed 's/\t/;/g' > purchase_order_diff.csv
 /usr/bin/mysql --host=$HOST --user=$USER --password=$PASS ods_utf8_db -e "SET names 'utf8'; select * from analytics_db.vw_equipment_diff_sg;" | sed 's/\t/;/g' > equipment_diff.csv

 if [ -s "sg_purchase_order_diff.csv" ]
 then
 azure storage blob upload -q purchase_order_diff.csv    data $today/diff/purchase_order_$now.csv
 fi
 if [ -s "sg_equipment_diff.csv" ]
 then
  azure storage blob upload -q equipment_diff.csv    data $today/diff/equipment_$now.csv
 fi

fi
