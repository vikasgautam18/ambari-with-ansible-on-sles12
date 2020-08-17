#! /bin/bash

source ./useful-scripts.sh


stop_service MAPREDUCE2
stop_service YARN
stop_service HDFS
stop_service ZOOKEEPER

