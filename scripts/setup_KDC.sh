#! /bin/bash

export ROOT_DIR=`pwd`

KDC_ADMIN_USER=admin
KDC_ADMIN_PASSWORD=hadoop
KDC_HOST=$(hostname -f)
REALM=HWX.COM
KERBEROS_CLIENTS=$(hostname -f)

source $ROOT_DIR/useful-scripts.sh

setup_kdc()
{

        echo -e "\n`ts` : $(blue 'INFO') : Installing kerberos RPMs"
        zypper -n in krb5 krb5-server krb5-client
        echo -e "\n`ts` : $(blue 'INFO') : Configuring Kerberos"
        echo -e "\n`ts` : $(blue 'INFO') : Cleaning old config "
        rm -rf $ROOT_DIR/krb5.conf.default
        cp $ROOT_DIR/krb5.conf.template $ROOT_DIR/krb5.conf.default
        sed -i.bak "s/EXAMPLE.COM/$REALM/g" $ROOT_DIR/krb5.conf.default
        sed -i.bak "s/kerberos.example.com/$KDC_HOST/g" $ROOT_DIR/krb5.conf.default
        cat $ROOT_DIR/krb5.conf.default > /etc/krb5.conf
        kdb5_util create -s -P $KDC_ADMIN_PASSWORD
        echo -e "\n`ts` : $(blue 'INFO') : Starting KDC services"
        systemctl start krb5kdc
        systemctl start kadmind

        chkconfig krb5kdc on
        chkconfig kadmind on
        echo -e "\n`ts` : $(blue 'INFO') : Creating admin principal"
        kadmin.local -q "addprinc -pw $KDC_ADMIN_PASSWORD $KDC_ADMIN_USER/admin"
        echo  "*/$KDC_ADMIN_USER@$REALM *" >> /var/lib/kerberos/krb5kdc/kadm5.acl
        echo -e "\n`ts` : $(blue 'INFO') : Restarting and kadmin"
        systemctl restart krb5kdc
	systemctl restart kadmind
	
	kadmin -p admin/$KDC_ADMIN_USER -w $KDC_ADMIN_PASSWORD -q "addprinc -pw test test-something-else@$REALM"
	result=$?
	if [ $result -ne 0 ]; then
		echo -e "\n`ts` : $(red 'ERROR') : KDC set up complete but tests fail !"
	else
		echo -e "\n`ts` : $(green 'INFO') : KDC set up complete and ready to use !"
	fi
}

setup_kdc|tee -a $ROOT_DIR/kdc_setup.log
