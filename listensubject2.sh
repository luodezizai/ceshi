#!/bin/sh
ps -fe|grep update_subjectf10.sh |grep -v grep
if [ $? -ne 0 ]
then
/data/elasticsearch-jdbc-2.3.3.0/bin/update_subjectf5.sh $(curl -s 'http://resource.adbug.cn/api/v6/getmaxid?type=3')
else
echo 'runing'
fi
######





