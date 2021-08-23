#!/bin/bash

#v1 api server cleanup script

find /var/log/httpd/healthd -type f -mtime +1 -name '*.gz' -execdir rm -- '{}' \;
find /var/log/httpd/rotated -type f -mtime +1 -name '*.gz' -execdir rm -- '{}' \;
find /var/log/tomcat8/rotated -type f -mtime +1 -name '*.gz' -execdir rm -- '{}' \;
find /var/log/tomcat8/rotated -type f -mtime +1 -name '*.zip' -execdir rm -- '{}' \;
find /var/log/tomcat8 -type f -name "*.log" -mtime +2 -delete