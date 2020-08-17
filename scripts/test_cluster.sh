#! /bin/bash

echo "setting up user $1"
sudo -u hdfs hdfs dfs -mkdir /user/$1
sudo -u hdfs hdfs dfs -mkdir /user/$1
sudo -u hdfs hdfs dfs -chown $1:$1 /user/$1
sudo -u hdfs hdfs dfs -chmod -R 755 /user/$1

echo "Run the smoke test as the $1. Using Terasort, sort 10GB of data"

sudo -u $1 /usr/hdp/current/hadoop-client/bin/hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-examples-*.jar teragen 10000 tmp/teragenout
sudo -u $1 /usr/hdp/current/hadoop-client/bin/hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-examples-*.jar terasort tmp/teragenout tmp/terasortout
