#!/bin/bash

#this lives on the catalina API endpoints and uploads the catalina logs on an hourly basis to s3

epochTime=`date +%s`
tomcatPath=/var/log/tomcat8
dateYYYYMMDD=`date +"%Y-%m-%d"`
logFile=$tomcatPath/catalina.$dateYYYYMMDD.log
dateYYYYMMDDH=`date +"%Y-%m-%d-%H"`
curHour=`date +"%H"`
hourlyFilename=catalina.$dateYYYYMMDD.$curHour.$epochTime.log
hourlyLog=$tomcatPath/$hourlyFilename
outputZip=catalina.$dateYYYYMMDD.$curHour.$epochTime.log.gz
outputFile=/var/log/tomcat8/rotated/$outputZip
ipAddress=`/sbin/ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

echo "Start hourly Log $hourlyLog"
echo "output File $outputFile"
echo "logFile we are copying from originally $logFile"
echo "This is output zip file $outputZip"

cp $logFile $hourlyLog

if [ -f $logFile ]; then
    gzip $hourlyLog
mv $hourlyLog".gz" $tomcatPath/rotated
    echo > $logFile
    echo > /var/log/tomcat8/catalina.out
    echo "Starting clean up of log file"
    #rm $hourlyLog
fi

if [ -f $outputFile ]; then
  echo "Uploading zip up to s3://connex-catalina-logs/"
  aws s3 cp $outputFile s3://tomcat-ap1-vi-logs/$ipAddress/$dateYYYYMMDD/$outputZip
echo "Delete logs.."
  #rm $hourlyLog
fi

find $tomcatPath/rotated -type f -mtime +3 -name '*.gz' -execdir rm -- '{}' \;

bash /root/cleaner.bash
