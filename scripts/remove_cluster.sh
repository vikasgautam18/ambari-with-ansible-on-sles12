#! /bin/bash

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : running  HostCleanup.py"
python /usr/lib/ambari-agent/lib/ambari_agent/HostCleanup.py --silent --skip=users

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : stopping ambari-server"
ambari-server stop

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : re-setting ambari-server"
ambari-server reset --silent

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : stopping ambari-agent"
ambari-agent stop

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing ambari-server package"
zypper -n rm ambari-server

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing folder /var/lib/ambari-server"
rm -rf /var/lib/ambari-server

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing folder /var/run/ambari-server"
rm -rf /var/run/ambari-server

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing folder /usr/lib/ambari-server"
rm -rf /usr/lib/amrbari-server

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing folder /etc/ambari-server"
rm -rf /etc/ambari-server
 
echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing folder /usr/lib/python2.6/site-packages/resource_monitoring/ambari_commons"
rm -rf /usr/lib/python2.6/site-packages/resource_monitoring/ambari_commons

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing ambari-agent package"
zypper -n rm ambari-agent 

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing /var/lib/ambari-agent"
rm -rf /var/lib/ambari-agent

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing /var/run/ambari-agent"
rm -rf /var/run/ambari-agent

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing /usr/lib/ambari-agent"
rm -rf /usr/lib/amrbari-agent

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing all packages from repo HDP-3.1-repo-1"
zypper se --repo HDP-3.1-repo-1 --installed | awk '/^i(\+|\s)/ {print $3}' | xargs zypper -n rm

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing all packages from repo HDP-UTILS-1.1.0.22-repo-1"
zypper se --repo HDP-UTILS-1.1.0.22-repo-1 --installed | awk '/^i(\+|\s)/ {print $3}' | xargs zypper -n rm

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : removing all packages from repo ambari-2.7.4.0"
zypper se --repo ambari-2.7.4.0 --installed | awk '/^i(\+|\s)/ {print $3}' | xargs zypper -n rm

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /var/log/"
rm -rf /var/log/ambari-metrics-monitor
rm -rf /var/log/ambari-agent
rm -rf /var/log/ambari-infra-solr
rm -rf /var/log/ambari-infra-solr-client
rm -rf /var/log/ambari-metrics-collector
rm -rf /var/log/ambari-metrics-grafana
rm -rf /var/log/ambari-server
rm -rf /var/log/hadoop
rm -rf /var/log/hst
rm -rf /var/log/spark2

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /var/lib/"
rm -rf /var/lib/ambari-infra-solr
rm -rf /var/lib/ambari-metrics-collector
rm -rf /var/lib/ambari-metrics-grafana
rm -rf /var/lib/pgsql
rm -rf /var/lib/spark2

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /usr/hdp/"
rm -rf /usr/hdp

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /usr/bin/hadoop/"
rm -rf /usr/bin/hadoop

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /hadoop/"
rm -rf /hadoop

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /data/postgres"
rm -rf /data/postgres

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /etc/"
rm -rf /etc/ambari-agent
rm -rf /etc/ambari-infra-solr
rm -rf /etc/ambari-metrics-collector
rm -rf /etc/ambari-metrics-grafana
rm -rf /etc/ams-hbase
rm -rf /etc/hadoop
rm -rf /etc/hive_llap
rm -rf /etc/oozie
rm -rf /etc/ranger-admin
rm -rf /etc/ranger-kms
rm -rf /etc/ranger-tagsync
rm -rf /etc/ranger-usersync
rm -rf /etc/spark2
rm -rf /etc/tez_llap

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /var/run/"
rm -rf /var/run/ambari-metrics-collector
rm -rf /var/run/hadoop

echo "$(date +"%Y_%m_%d_%H_%M_%S") : INFO : cleaning up /usr/lib/"
rm -rf /usr/lib/ambari-agent
rm -rf /usr/lib/ambari-logsearch-logfeeder
rm -rf /usr/lib/ambari-metrics-hadoop-sink
rm -rf /usr/lib/ambari-metrics-kafka-sink
rm -rf /usr/lib/ams-hbase

zypper -n rm krb5-server krb5-client
rm -rf /var/lib/kerberos
rm -rf /etc/krb5.conf
rm -rf /var/log/krb5
rm -rf /var/lib/systemd/migrated/krb5kdc

zypper rm libsnappy1-1.1.3-1.2.x86_64
zypper rm snappy-devel-1.1.3-1.2.x86_64
