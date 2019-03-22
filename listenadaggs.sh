#!/bin/sh
ps -fe|grep update_addataaggs10.sh |grep -v grep
if [ $? -ne 0 ]
then
/data/elasticsearch-jdbc-2.3.3.0/bin/update_addataaggs4.sh $(curl -s 'http://resource.adbug.cn/api/v3/getmaxid?type=8')
else
echo 'runing'
fi
######





