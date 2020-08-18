#! /bin/bash

zypper -n rm krb5-server krb5-client
rm -rf /var/lib/kerberos
rm -rf /etc/krb5.conf
rm -rf /var/log/krb5
rm -rf /var/lib/systemd/migrated/krb5kdc


