#!/bin/bash

LOC=`pwd`
PROP=ambari.props
source $LOC/$PROP

#############

ts()
{
        echo "`date +%Y-%m-%d,%H:%M:%S`"
}

setup_kdc()
{

        echo -e "\n`ts` Installing kerberos RPMs"
        zypper -n in krb5 krb5-server krb5-client
        echo -e "\n`ts` Configuring Kerberos"
        sed -i.bak "s/EXAMPLE.COM/$REALM/g" $LOC/krb5.conf.default
        sed -i.bak "s/kerberos.example.com/$KDC_HOST/g" $LOC/krb5.conf.default
        cat $LOC/krb5.conf.default > /etc/krb5.conf
        kdb5_util create -s -P hadoop
        echo -e "\n`ts` Starting KDC services"
        systemctl start krb5kdc
        systemctl start kadmind

        chkconfig krb5kdc on
        chkconfig kadmind on
        echo -e "\n`ts` Creating admin principal"
        kadmin.local -q "addprinc -pw hadoop admin/admin"
        sed -i.bak "s/EXAMPLE.COM/$REALM/g" /var/lib/kerberos/krb5kdc/kadm5.acl
        echo -e "\n`ts` Restarting kadmin"
        systemctl start kadmind
}

setup_kdc|tee -a $LOC/kdc_setup.log
