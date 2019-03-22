#!/bin/sh
ps -fe|grep import_domainsf10.sh |grep -v grep
if [ $? -ne 0 ]
then
/data/elasticsearch-jdbc-2.3.3.0/bin/import_domains_upf11.sh &
else
echo 'runing'
fi
######





