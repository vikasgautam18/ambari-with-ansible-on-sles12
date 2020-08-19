#! /bin/bash

source ./useful-scripts.sh

start_service KNOX
start_service ZOOKEEPER
start_service HDFS
start_service YARN
start_service HBASE
start_service MAPREDUCE2
start_service HIVE
start_service KAFKA
start_service SPARK2
start_service AMBARI_INFRA_SOLR
start_service AMBARI_METRICS
start_service ZEPPELIN
start_service SMARTSENSE
