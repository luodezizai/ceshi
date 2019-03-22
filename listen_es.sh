#!/bin/sh
ps -fe|grep import_domainsf10.sh |grep -v grep
if[ $? -ne 0 ]
then
#nohup /data/elasticsearch-jdbc-2.3.3.0/bin/import_domainsf10.sh
echo 99 >> text.txt
else
echo 88 >> text.txt
fi
