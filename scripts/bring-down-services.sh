#! /bin/bash

source ./useful-scripts.sh

stop_service SMARTSENSE
stop_service AMBARI_INFRA_SOLR
stop_service AMBARI_METRICS
stop_service KNOX
stop_service HIVE
stop_service HBASE
stop_service YARN
stop_service HDFS
stop_service ZOOKEEPER
stop_service MAPREDUCE2
stop_service KAFKA
stop_service SPARK2
stop_service ZEPPELIN


