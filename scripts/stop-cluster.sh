#! /bin/bash

sh bring-down-services.sh

echo  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

sleep 60

sudo ambari-server stop

echo  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

sudo ambari-server status

echo "\n\n\n"

sudo ambari-agent stop

echo  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

sudo ambari-agent status

echo  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

echo "Request complete..."

echo  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
