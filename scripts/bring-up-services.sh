#! /bin/bash

source ./useful-scripts.sh

start_service ZOOKEEPER
start_service HDFS
start_service YARN
start_service MAPREDUCE2

