#!/bin/bash
#TODO: look for $TOMCAT_HOME/STAGE.ZK6/*.war
WAR_FILE="$1"
echo "$WAR_FILE"
TOMCAT_HOME=/opt/tomcat
if [ -z "$WAR_FILE" ]; then
   echo "WAR file has to be passed in as the first parameter"
   exit
fi
cd $TOMCAT_HOME
cd STAGE.ZK6
pwd
if [ ! -f $WAR_FILE ]; then
    echo "File not found!"
    exit
fi
mkdir $WAR_FILE.tmp
cd $WAR_FILE.tmp
jar -xvf ../$WAR_FILE
cp $TOMCAT_HOME/lib.ZK6/* WEB-INF/lib/
mkdir $TOMCAT_HOME/STAGE/
jar -cvf $TOMCAT_HOME/STAGE/$WAR_FILE *
mv $TOMCAT_HOME/STAGE/$WAR_FILE /opt/tomcat/webapps/
cd ..
rm -Rf $WAR_FILE.tmp
rm $TOMCAT_HOME/STAGE.ZK6/$WAR_FILE
echo Done!
